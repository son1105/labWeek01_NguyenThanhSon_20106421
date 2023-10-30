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
import vn.edu.iuh.fit.entities.Role;
import vn.edu.iuh.fit.repositories.AccountRepository;
import vn.edu.iuh.fit.repositories.LogRepository;
import vn.edu.iuh.fit.repositories.RoleRepository;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet(urlPatterns = {"/logController"})
public class LogController extends HttpServlet {

    private final AccountRepository accountRepository = new AccountRepository();
    private final LogRepository logRepository = new LogRepository();
    private final RoleRepository roleRepository = new RoleRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String login = req.getParameter("logIn");
        String logout = req.getParameter("logOut");
        String findAccountFromRole = req.getParameter("findAccountFromRole");
        if (login != null) {
            handleLogin(req, resp);
        } else if (logout!=null) {
            handleLogOut(req, resp);
        } else if (findAccountFromRole!=null) {
            handleFindAccountByRole(req.getParameter("roleSelected"), req, resp);
        }
    }

    public void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LocalDateTime timeLogin = LocalDateTime.now();
        String email = req.getParameter("email");
        String password = req.getParameter("passwd");
        Account account = accountRepository.getAccountByEmailAndPassword(email, password);
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
        System.out.println(log);
        logRepository.updateLog(log);
        RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/index.jsp");
        requestDispatcher.forward(req, resp);
    }

    public void handleFindAccountByRole(String roleName, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        session.setAttribute("roleSelected", roleName);
        List<Account> accounts = accountRepository.getAccountFromRoleName(roleName);
        session.setAttribute("accountByRole", accounts);
        RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/manageUsers.jsp");
        requestDispatcher.forward(req, resp);
    }
}
