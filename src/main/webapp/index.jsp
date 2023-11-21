<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body style="display: flex;justify-content: center;align-items: center">
<div class="container p-5">
    <form action="logController" method="get">
    <div class="mb-3 mt-3">
        <label for="email" class="form-label">Email:</label>
        <input type="email" class="form-control" required id="email" placeholder="Enter email" name="email" value="son@gmail.com">
    </div>
    <div class="mb-3">
        <label for="passwd" class="form-label">Password:</label>
        <input type="password" class="form-control" required id="passwd" placeholder="Enter password" name="passwd" value="123">
    </div>

    <%
        String notice = request.getAttribute("notice") + "";
        if (!notice.equals("null")) {%>
    <div class="alert alert-danger" role="alert"><%=notice%>
    </div>
    <%}%>
    <button type="submit" class="btn btn-primary" name="logIn">Submit</button>
</form>
</div>
</body>
</html>