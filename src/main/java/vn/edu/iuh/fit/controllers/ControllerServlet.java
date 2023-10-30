package vn.edu.iuh.fit.controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.iuh.fit.entities.Account;
import vn.edu.iuh.fit.entities.Log;
import vn.edu.iuh.fit.repositories.AccountRepository;
import vn.edu.iuh.fit.repositories.LogRepository;
import vn.edu.iuh.fit.repositories.RoleRepository;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet(urlPatterns = {"/controller", "/action"})
public class ControllerServlet extends HttpServlet {
    private AccountRepository accountRespository = new AccountRepository();
    private RoleRepository roleRespository = new RoleRepository();

    private LogRepository logRepository = new LogRepository();

    private RequestDispatcher requestDispatcher = null;
    private LocalDateTime timeLogin = null;
    private Account account = null;
    private LocalDateTime timeLogout;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {



    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        System.out.println(action);
    }








}
