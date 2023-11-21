package vn.edu.iuh.fit.controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.Log;
import vn.edu.iuh.fit.repositories.AccountRepository;
import vn.edu.iuh.fit.repositories.LogRepository;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(urlPatterns = {"/logController"})
public class LogController extends HttpServlet {

    private final AccountRepository accountRepository = new AccountRepository();
    private final LogRepository logRepository = new LogRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String login = req.getParameter("logIn");
        String logout = req.getParameter("logOut");
        if (login != null) {
            handleLogin(req, resp);
        } else if (logout!=null) {
            handleLogOut(req, resp);
        }
    }

    public void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LocalDateTime timeLogin = LocalDateTime.now();
        String id = req.getParameter("id");
        String password = req.getParameter("passwd");
        Account account = accountRepository.getAccountByIdAndPassword(id, password);
        RequestDispatcher requestDispatcher;
        if (account != null) {
            if(accountRepository.checkAdmin(account.getId()) || accountRepository.checkUser(account.getId())){
                HttpSession session = req.getSession();
                session.setAttribute("account", account);
                Log log = new Log(account, timeLogin, null,"");
                session.setAttribute("log", log);
                if(!logRepository.addLog(log))
                    return;
                if(accountRepository.checkAdmin(account.getId())){
                    requestDispatcher = getServletContext().getRequestDispatcher("/manageUsers.jsp");
                } else {
                    requestDispatcher = getServletContext().getRequestDispatcher("/users.jsp");
                }

            } else {
                req.setAttribute("notice", "Account do not allow access!");
                requestDispatcher = getServletContext().getRequestDispatcher("/index.jsp");
            }
        } else {
            req.setAttribute("notice", "Not found account!");
            requestDispatcher = getServletContext().getRequestDispatcher("/index.jsp");
        }
        requestDispatcher.forward(req, resp);
    }
    
    public void handleLogOut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LocalDateTime timeLogout = LocalDateTime.now();
        HttpSession session = req.getSession();
        Log log = (Log) session.getAttribute("log");
        log.setLogoutTime(timeLogout);
        logRepository.updateLog(log);
        RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/index.jsp");
        requestDispatcher.forward(req, resp);
    }
}
