<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<%@ page import="vn.edu.iuh.fit.repositories.AccountRepository" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.iuh.fit.entities.Role" %>
<%@ page import="vn.edu.iuh.fit.repositories.RoleRepository" %>
<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 20/9/2023
  Time: 10:13 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Manage Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateAcc(e) {
            const acc = e.getAttribute('value').split(', ')
            document.getElementById("up_acc_id").value = acc[0]
            document.getElementById("up_acc_name").value = acc[1]
            document.getElementById("up_acc_email").value = acc[2]
            document.getElementById("up_acc_password").value = acc[3]
            document.getElementById("up_acc_phone").value = acc[4]
        }

        function deleteAcc(e) {
            document.getElementById("del_acc_id").value = e.parentElement.getElementsByTagName('button')[0].getAttribute('value').split(', ')[0]
        }
    </script>
</head>
<body>
<div class="container w-50 mt-5 p-3 border bg-info">
    <%
        Object object = session.getAttribute("account");
        Account acc = new Account();
        if (object != null)
            acc = (Account) object;
    %>
    <h4>Admin: <%=acc.getName()%>
    </h4>
    <form class="w-3" action="accountController" method="post">
        <div class="mb-3 mt-3 d-flex justify-content-center">
            <label class="display-6 mx-5">Manage Users</label>
            <button type="submit" class="form-btn mx-5" name="logOut">Logout</button>
        </div>

        <div class="mb-3 mt-3 d-flex justify-content-center">
            <button type="button" class="form-btn mx-4" data-bs-toggle="modal" data-bs-target="#myModal">Add account
            </button>
            <select class="form-select w-25" name="roleSelected">
                <option selected>All</option>
                <%
                    List<Role> roles = new RoleRepository().getAllRole();
                    Object objRole = session.getAttribute("roleSelected");
                    String roleSelected = "";
                    if (objRole != null)
                        roleSelected = objRole.toString();
                    for (Role role : roles) {
                        if (role.getName().equalsIgnoreCase(roleSelected)) {%>
                <option selected><%=role.getName()%>
                </option>
                <%} else {%>
                <option><%=role.getName()%>
                </option>
                <%
                        }
                    }
                %>
            </select>
            <button type="submit" class="form-btn mx-4" name="findAccountFromRole">Account From Role</button>
        </div>

        <%
            Object o = session.getAttribute("accountByRole");
            List<Account> accountList;
            if (o != null)
                accountList = (List<Account>) o;
            else
                accountList = new AccountRepository().getAllAccountUser();
            for (Account account : accountList) {%>
        <div class="border d-flex">
            <div class="mt-3 p-2 px-4 w-75">
                <label class="form-label"><%=account.getName()%>
                </label>
                <br>
                <label class="form-label"><%=account.getEmail()%>
                </label>
                <br>
                <label class="form-label"><%=account.getPhone()%>
                </label>
                <ul>Roles:
                    <%
                        List<Role> rolesOfAccount = new RoleRepository().getRoleFromAccountID(account.getId());
                        for (Role r : rolesOfAccount) {%>
                    <li><%=r.getName()%>
                    </li>
                    <%}%>
                </ul>
            </div>
            <div class="border p-4 w-25">
                <button class="form-btn m-1 w-75"
                        value="<%=account.getId()%>, <%=account.getName()%>, <%=account.getEmail()%>, <%=account.getPassword()%>, <%=account.getPhone()%>"
                        name="update" type="button"
                        data-bs-toggle="modal" data-bs-target="#myModalUpdate"
                        onclick="updateAcc(this)"
                >
                    Update
                </button>
                <button class="form-btn m-1 w-75" type="button" data-bs-toggle="modal"
                        data-bs-target="#myModalDelete" onclick="deleteAcc(this)">
                    Delete
                </button>
                <button class="form-btn m-1 w-75" type="submit" value="<%=account.getId()%>" name="grant">
                    Grant
                </button>
            </div>
        </div>
    </form>
    <div class="modal fade" id="myModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="staticBackdropLabel">Add an account</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="accountController" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="add_acc_id" class="form-label">ID:</label>
                            <input type="text" class="form-control" id="add_acc_id" placeholder="Enter Account Id"
                                   name="add_acc_id">
                        </div>
                        <div class="mb-3">
                            <label for="add_acc_name" class="form-label">Name:</label>
                            <input type="text" class="form-control" id="add_acc_name" placeholder="Enter Account Name"
                                   name="add_acc_name">
                        </div>
                        <div class="mb-3">
                            <label for="add_acc_email" class="form-label">Email:</label>
                            <input type="email" class="form-control" id="add_acc_email"
                                   placeholder="Enter Account Email" name="add_acc_email">
                        </div>
                        <div class="mb-3">
                            <label for="add_acc_phone" class="form-label">Phone:</label>
                            <input type="tel" class="form-control" id="add_acc_phone" placeholder="Enter Account Phone"
                                   name="add_acc_phone">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary" name="addAccount">Add</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModalUpdate" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Update a account</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="accountController" method="post">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="up_acc_id" class="form-label">ID:</label>
                            <input type="text" class="form-control" id="up_acc_id" placeholder="Enter Account Id"
                                   name="up_acc_id" readonly value="">
                        </div>
                        <div class="mb-3">
                            <label for="up_acc_name" class="form-label">Name:</label>
                            <input type="text" class="form-control" id="up_acc_name" placeholder="Enter Account Name"
                                   name="up_acc_name" value="">
                        </div>
                        <div class="mb-3">
                            <label for="up_acc_email" class="form-label">Email:</label>
                            <input type="email" class="form-control" id="up_acc_email"
                                   placeholder="Enter Account Email" name="up_acc_email"
                                   value="">
                        </div>
                        <div class="mb-3">
                            <label for="up_acc_password" class="form-label">Password:</label>
                            <input type="text" class="form-control" id="up_acc_password"
                                   placeholder="Enter Account Password" name="up_acc_password"
                                   value="">
                        </div>
                        <div class="mb-3">
                            <label for="up_acc_phone" class="form-label">Phone:</label>
                            <input type="tel" class="form-control" id="up_acc_phone" placeholder="Enter Account Phone"
                                   name="up_acc_phone" value="">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary" name="upAccount">Update</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModalDelete" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Warning!!!</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="accountController" method="post">
                    <div class="modal-body">
                        <label class="form-label">Are your sure delete account?</label>
                        <input type="hidden" name="del_acc_id" id="del_acc_id" value="">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                        <button type="submit" class="btn btn-primary" name="delAccount">Yes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
<%--    <div class="modal fade" id="myModalGrant" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"--%>
<%--         aria-labelledby="staticBackdropLabel" aria-hidden="true">--%>
<%--        <div class="modal-dialog">--%>
<%--            <div class="modal-content">--%>
<%--                <div class="modal-header">--%>
<%--                    <h5 class="modal-title">Grant Access</h5>--%>
<%--                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
<%--                </div>--%>
<%--                <form action="controller">--%>
<%--                    <div class="modal-body">--%>
<%--                        <select name="selectRoleGrant">--%>
<%--                            <%--%>
<%--                                List<Role> roleGrant = new RoleRepository().getAllRole();--%>
<%--                                for (Role role : roleGrant) {--%>
<%--                            %>--%>
<%--                            <option><%=role.getName()%></option>--%>
<%--                            <%}%>--%>
<%--                        </select>--%>
<%--                        <div class="mb-3">--%>
<%--                            <label for="grant_acc_note" class="form-label">Note:</label>--%>
<%--                            <input type="text" class="form-control" id="grant_acc_note" placeholder="Enter Grant Note"--%>
<%--                                   name="grant_acc_note">--%>
<%--                        </div>--%>
<%--                        <input type="hidden" name="grant_acc_id" value="<%=account.getId()%>">--%>
<%--                    </div>--%>
<%--                    <div class="modal-footer">--%>
<%--                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>--%>
<%--                        <button type="submit" class="btn btn-primary" name="grantAccount">Grant</button>--%>
<%--                    </div>--%>
<%--                </form>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
    <%}%>
</div>
</body>
</html>
