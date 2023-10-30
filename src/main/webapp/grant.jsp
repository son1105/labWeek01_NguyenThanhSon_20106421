<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 31/10/2023
  Time: 1:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>
<div class="container">
    <h3 class="text-center">Grant</h3>
    <div class="d-flex">
        <div class="bg-info w-25 p-4">
            <h4 class="text-center" style="text-align: center;">User</h4>
            <div>
                <h5>Id: 1</h5>
                <h5 class="my-4">Name: Nguyen Thanh Son</h5>
                <h5>Email: son@gmail.com</h5>
                <h5 class="my-4">Phone: 0987746921</h5>
            </div>
        </div>
        <div class="bg-warning w-75 p-4">
            <h4 class="text-center" style="text-align: center">Roles</h4>
            <table class="table table-hover text-center fs-5" style="width: 100%;">
                <thead>
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Note</th>
                    <th>Status</th>
                    <th>Edit Note</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>Admin</td>
                    <td>Admin</td>
                    <td>Admin</td>
                    <td><input class="form-check-input" type="checkbox"></td>
                    <td><button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#grantModal">Edit</button></td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
    <div class="modal fade" id="grantModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Grant Access</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="accountController" method="post">
                    <div class="modal-body">
                        <select class="form-selec my-2" style="width: 50%; height: 30px;">
                            <option>Admin</option>
                            <option>User</option>
                        </select>
                        <textarea class="form-control my-2" placeholder="Note" name="note"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary" name="grantAccount">Grant</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
