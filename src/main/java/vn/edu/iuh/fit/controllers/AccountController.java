package vn.edu.iuh.fit.controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.GrantAccess;
import vn.edu.iuh.fit.entities.Role;
import vn.edu.iuh.fit.repositories.AccountRepository;
import vn.edu.iuh.fit.repositories.GrantAccessRepository;
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
        GrantAccessRepository grantAccessRepository = new GrantAccessRepository();
        String addAccount = req.getParameter("addAccount");
        String upAccount = req.getParameter("upAccount");
        String delAccount = req.getParameter("delAccount");
        String findAccountFromRole = req.getParameter("findAccountFromRole");
        String showGrantForm = req.getParameter("grant");
        String grantAccount = req.getParameter("grantAccount");
        if (showGrantForm != null) {
            handleShowGrantForm(showGrantForm, roleRepository, accountRepository, req, resp);
            requestDispatcher = getServletContext().getRequestDispatcher("/grant.jsp");
            requestDispatcher.forward(req, resp);
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
            } else if (findAccountFromRole!=null) {
                handleFindAccountByRole(req.getParameter("roleSelected"), accountRepository, req, resp);
            } else if (grantAccount!=null) {
                HttpSession session = req.getSession();
                Object object = session.getAttribute("accountGrant");
                if(object!=null) {
                    Account account = (Account) object;
                    if(grantAccount.endsWith("revoke"))
                        handleRevokeAccount(grantAccount.replace("revoke",""), account, roleRepository, grantAccessRepository, req, resp);
                    else
                        handleGrantAccount(grantAccount, account, req.getParameter("note"), roleRepository, grantAccessRepository, req, resp);
                }

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
        Account account = accountRepository.getAccountById(id);
        account.setStatus(-1);
        return accountRepository.updateAccount(account);
    }

    public void handleFindAccountByRole(String roleName, AccountRepository accountRepository, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        session.setAttribute("roleSelected", roleName);
        List<Account> accounts = accountRepository.getAccountFromRoleName(roleName);
        session.setAttribute("accountByRole", accounts);
    }

    public void handleShowGrantForm(String idAccount, RoleRepository roleRepository, AccountRepository accountRepository, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Role> roles = roleRepository.getRoleFromAccountID(idAccount);
        HttpSession session = req.getSession();
        session.setAttribute("accountGrant", accountRepository.getAccountById(idAccount));
        session.setAttribute("rolesAccount", roles);
    }

    public void handleGrantAccount(String idRole, Account account, String note, RoleRepository roleRepository, GrantAccessRepository grantAccessRepository, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        GrantAccess grantAccess = grantAccessRepository.getOneByAccountIdAndRoleId(account.getId(), idRole);
        if(grantAccess == null) {
            grantAccess = new GrantAccess(roleRepository.getRole(idRole), account, true, note);
            if(!grantAccessRepository.addGrantAccess(grantAccess))
                System.out.println("Can't grant role to account!");
        } else{
            grantAccess.setGrant(true);
            grantAccess.setNote(note);
            if(!grantAccessRepository.updateGrantAccess(grantAccess))
                System.out.println("Can't grant role to account!");
        }

    }

    public void handleRevokeAccount(String idRole, Account account, RoleRepository roleRepository, GrantAccessRepository grantAccessRepository, HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        GrantAccess grantAccess = grantAccessRepository.getOneByAccountIdAndRoleId(account.getId(), idRole);
        grantAccess.setGrant(false);
        if(!grantAccessRepository.updateGrantAccess(grantAccess))
            System.out.println("Can't revoke role from account!");
    }
}
