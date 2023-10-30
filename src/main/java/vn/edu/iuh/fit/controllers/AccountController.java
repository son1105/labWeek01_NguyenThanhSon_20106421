package vn.edu.iuh.fit.controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.Role;
import vn.edu.iuh.fit.repositories.AccountRepository;
import vn.edu.iuh.fit.repositories.RoleRepository;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/accountController"})
public class AccountController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher requestDispatcher;
        AccountRepository accountRepository = new AccountRepository();
        RoleRepository roleRepository = new RoleRepository();
        String addAccount = req.getParameter("addAccount");
        String upAccount = req.getParameter("upAccount");
        String delAccount = req.getParameter("delAccount");
        String idAccount = req.getParameter("grant");
        if (idAccount != null) {
            System.out.println("ok!");
            handleGrantAccount(idAccount, roleRepository, accountRepository, req, resp);
        }
        else {
            if (addAccount != null) {
                if (!handleAddAccount(accountRepository, req, resp))
                    System.out.println("Oh no can't add!");
            } else if (upAccount != null) {
                if (!handleUpdateAccount(accountRepository, req, resp))
                    System.out.println("Can't update");
            } else if (delAccount != null) {
                if (!handleDeleteAccount(accountRepository, req, resp))
                    System.out.println("Can't delete!");
            }
            requestDispatcher = getServletContext().getRequestDispatcher("/manageUsers.jsp");
            requestDispatcher.forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    }

    public boolean handleAddAccount(AccountRepository accountRepository, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("add_acc_id");
        String name = req.getParameter("add_acc_name");
        String email = req.getParameter("add_acc_email");
        String phone = req.getParameter("add_acc_phone");
        Account account = new Account(id, name, "123", email, phone, 1);
        return accountRepository.addAccount(account);
    }

    public boolean handleUpdateAccount(AccountRepository accountRepository, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("up_acc_id");
        String name = req.getParameter("up_acc_name");
        String email = req.getParameter("up_acc_email");
        String password = req.getParameter("up_acc_password");
        String phone = req.getParameter("up_acc_phone");
        Account account = new Account(id, name, password, email, phone, 1);
        return accountRepository.updateAccount(account);
    }

    public boolean handleDeleteAccount(AccountRepository accountRepository, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("del_acc_id");
        System.out.println(id);
        Account account = accountRepository.getAccountById(id);
        account.setStatus(-1);
        return accountRepository.updateAccount(account);
    }

    public void handleGrantAccount(String idAccount, RoleRepository roleRepository, AccountRepository accountRepository, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Role> roles = roleRepository.getRoleFromAccountID(idAccount);
        HttpSession session = req.getSession();
        session.setAttribute("accountGrant", accountRepository.getAccountById(idAccount));
        session.setAttribute("rolesAccount", roles);
        RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/grant.jsp");
        requestDispatcher.forward(req, resp);
    }
}
