package vn.edu.iuh.fit.controllers;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.iuh.fit.connection.Connection;
import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.GrantAccess;
import vn.edu.iuh.fit.entities.Log;
import vn.edu.iuh.fit.entities.Role;
import vn.edu.iuh.fit.respositories.AccountRespository;
import vn.edu.iuh.fit.respositories.LogRespository;
import vn.edu.iuh.fit.respositories.RoleRespository;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet(urlPatterns = {"/controller", "/action"})
public class ControllerServlet extends HttpServlet {
    private AccountRespository accountRespository = new AccountRespository();
    private RoleRespository roleRespository = new RoleRespository();
    private LogRespository logRespository = new LogRespository();
    private RequestDispatcher requestDispatcher = null;
    private LocalDateTime timeLogin = null;
    private Account account = null;
    private LocalDateTime timeLogout;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String login = req.getParameter("login");
        String addAccount = req.getParameter("addAccount");
        String upAccount = req.getParameter("upAccount");
        String delAccount = req.getParameter("delAccount");
        String grantAccount = req.getParameter("grantAccount");
        String findAccountFromRole = req.getParameter("findAccountFromRole");
        String logout = req.getParameter("logOut");
        if (login != null) {
            handleLogin(req, resp);
        } else if (addAccount != null) {
            if (!handleAddAccount(req, resp))
                System.out.println("Oh no can't add!");
            requestDispatcher = getServletContext().getRequestDispatcher("/manageUsers.jsp");
            requestDispatcher.forward(req, resp);
        } else if (upAccount != null) {
            if (!handleUpdateAccount(req, resp))
                System.out.println("Can't update");
            requestDispatcher = getServletContext().getRequestDispatcher("/manageUsers.jsp");
            requestDispatcher.forward(req, resp);
        } else if (delAccount != null) {
            if (!handleDeleteAccount(req, resp))
                System.out.println("Can't delete!");
            requestDispatcher = getServletContext().getRequestDispatcher("/manageUsers.jsp");
            requestDispatcher.forward(req, resp);
        } else if (grantAccount!=null) {
            String roleNameGrant = req.getParameter("selectRoleGrant");
            if(!handleGrantAccount(req, resp, roleNameGrant)){
                System.out.println("You can't grant this role for this user!");
            }
            requestDispatcher = getServletContext().getRequestDispatcher("/manageUsers.jsp");
            requestDispatcher.forward(req, resp);
        } else if (findAccountFromRole!=null) {
            String nameRole = req.getParameter("selectRoleFind");
            req.setAttribute("roleOfAccount", nameRole);
            requestDispatcher = getServletContext().getRequestDispatcher("/manageUsers.jsp");
            requestDispatcher.forward(req, resp);
        } else if (logout!=null) {
            handleLogOut(req, resp);
            requestDispatcher = getServletContext().getRequestDispatcher("/index.jsp");
            requestDispatcher.forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        System.out.println(action);
    }

    public void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        timeLogin = LocalDateTime.now();
        String email = req.getParameter("email");
        String password = req.getParameter("pswd");
        account = accountRespository.getAccountByEmailAndPassword(email, password);
        if (account != null) {
            List<Role> roles = accountRespository.getRoleFromAccountID(account.getId());
            if (roles != null) {
                Log log = new Log(account, timeLogin, null,"");
                logRespository.addLog(log);
                String roleNames = roleRespository.getRoleName(roles).toString();
                roleNames = roleNames.substring(1,roleNames.length()-1);
                if (roleNames.contains("admin")) {
                    requestDispatcher = getServletContext().getRequestDispatcher("/manageUsers.jsp");
                    requestDispatcher.forward(req, resp);
                } else {
                    req.setAttribute("name", account.getName());
                    req.setAttribute("email", account.getEmail());
                    req.setAttribute("phone", account.getPhone());
                    req.setAttribute("roles", roleNames);
                    requestDispatcher = getServletContext().getRequestDispatcher("/users.jsp");
                    requestDispatcher.forward(req, resp);
                }
            } else {
                req.setAttribute("noti", "Account do not have access!");
                requestDispatcher = getServletContext().getRequestDispatcher("/index.jsp");
                requestDispatcher.forward(req, resp);
            }
        } else {
            req.setAttribute("noti", "Thông tin sai!");
            requestDispatcher = getServletContext().getRequestDispatcher("/index.jsp");
            requestDispatcher.forward(req, resp);
        }
    }

    public boolean handleAddAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("add_acc_id");
        String name = req.getParameter("add_acc_name");
        String email = req.getParameter("add_acc_email");
        String phone = req.getParameter("add_acc_phone");
        Account account = new Account(id, name, "123", email, phone, 1);
        return accountRespository.addAccount(account);
    }

    public boolean handleUpdateAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("up_acc_id");
        String name = req.getParameter("up_acc_name");
        String email = req.getParameter("up_acc_email");
        String password = req.getParameter("up_acc_password");
        String phone = req.getParameter("up_acc_phone");
        Account account = new Account(id, name, password, email, phone, 1);
        return accountRespository.updateAccount(account);
    }

    public boolean handleDeleteAccount(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("del_acc_id");
        String name = req.getParameter("del_acc_name");
        String email = req.getParameter("del_acc_email");
        String password = req.getParameter("del_acc_password");
        String phone = req.getParameter("del_acc_phone");
        Account account = new Account(id, name, password, email, phone, -1);
        return accountRespository.updateAccount(account);
    }

    public boolean handleGrantAccount(HttpServletRequest req, HttpServletResponse resp, String roleName) throws ServletException, IOException {
        String accountId = req.getParameter("grant_acc_id");
        System.out.println(accountId);
        String roleId = roleRespository.getRoleIdFromRoleName(roleName);
        String note = req.getParameter("grant_acc_note");
        return accountRespository.grantAccount(accountId, roleId, note);
    }
    public void handleLogOut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        timeLogout = LocalDateTime.now();
        Log log = new Log(logRespository.getLogId(account, timeLogin),account, timeLogin, timeLogout,"");
        System.out.println(log);
        logRespository.updateLog(log);
    }
}
