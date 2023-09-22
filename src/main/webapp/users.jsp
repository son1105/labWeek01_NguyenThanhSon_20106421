<%--
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
<div class="container w-50 mt-5 p-3 border">
    <form class="w-3">
        <div class="mb-3 mt-3 d-flex justify-content-center">
            <label class="display-6 mx-5">Users Information</label>
            <button type="submit" class="form-btn mx-5" name="logOut">Logout</button>
        </div>
        <div class="mb-3 mt-3">
            <label class="form-label">Full name:</label>
            <%
                String name = request.getAttribute("name")+"";
            %>
            <label><%=name%></label>
        </div>
        <div class="mb-3 mt-3">
            <label class="form-label">Email:</label>
            <%
                String email = request.getAttribute("email")+"";
            %>
            <label><%=email%></label>
        </div>
        <div class=" mt-3">
            <label class="form-label">Phone:</label>
            <%
                String phone = request.getAttribute("phone")+"";
            %>
            <label><%=phone%></label>
        </div>
        <div class=" mt-3">
            <ul>Roles:
                <%
                    String[] arrRole = (request.getAttribute("roles")+"").split(", ");
                    for (String role:arrRole){%>
                <li><%=role%></li>
                    <%}%>
            </ul>
        </div>
    </form>
</div>
</body>
</html>
