<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.iuh.fit.entities.Role" %>
<%@ page import="vn.edu.iuh.fit.repositories.RoleRepository" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 20/9/2023
  Time: 3:29 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thông tin user</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container w-50 mt-5 p-3 border bg-info">
    <form class="w-3" action="logController">
        <div class="mb-3 mt-3 d-flex justify-content-center">
            <label class="display-6 mx-5">Users Information</label>
            <button type="submit" class="form-btn mx-5" name="logOut">Logout</button>
        </div>
        <%
            Object object = session.getAttribute("account");
            if (object != null) {
                Account account = (Account) object;%>
        <div class="mb-3 mt-3">
            <label class="form-label">Full name:</label>
            <label><%=account.getName()%>
            </label>
        </div>
        <div class="mb-3 mt-3">
            <label class="form-label">Email:</label>
            <label><%=account.getEmail()%>
            </label>
        </div>
        <div class=" mt-3">
            <label class="form-label">Phone:</label>
            <label><%=account.getPhone()%>
            </label>
        </div>
        <div class=" mt-3">
            <ul>Roles:
                <%
                    List<Role> roles = new RoleRepository().getRoleFromAccountID(account.getId());
                    for (Role role : roles) {%>
                <li><%=role.getName()%>
                </li>
                <%}%>
            </ul>
        </div>
        <%}%>
    </form>
</div>
</body>
</html>
