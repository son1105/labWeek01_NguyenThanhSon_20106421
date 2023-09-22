<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<%@ page import="vn.edu.iuh.fit.respositories.AccountRespository" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.iuh.fit.entities.Role" %>
<%@ page import="vn.edu.iuh.fit.respositories.RoleRespository" %>
<%@ page import="java.util.ArrayList" %>
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
</head>
<body>
<div class="container w-50 mt-5 p-3 border bg-info">
    <form class="w-3" action="controller" method="get">
        <div class="mb-3 mt-3 d-flex justify-content-center">
            <label class="display-6 mx-5">Manage Users</label>
            <button type="submit" class="form-btn mx-5" name="logOut">Logout</button>
        </div>

        <div class="mb-3 mt-3 d-flex justify-content-center">
            <button type="button" class="form-btn mx-4" data-bs-toggle="modal" data-bs-target="#myModal">Add account
            </button>
            <select class="form-select w-25" name="selectRoleFind">
                <option selected>All</option>
                <%
                    String roleOfAccount = request.getAttribute("roleOfAccount") + "";
                    List<Role> allRole = new RoleRespository().getAllRole();
                    List<String> allRoleName = new RoleRespository().getRoleName(allRole);
                    for (String s : allRoleName) {
                        if (s.equalsIgnoreCase(roleOfAccount)) {%>
                <option selected><%=s%>
                </option>
                <%} else {%>
                <option><%=s%>
                </option>
                <%}%>
                <%}%>
                %>
            </select>
            <button type="submit" class="form-btn mx-4" name="findAccountFromRole">Account From Role</button>
        </div>
        <%
            List<Account> accountList;
            if (roleOfAccount.equalsIgnoreCase("All") || roleOfAccount.equalsIgnoreCase("null")) {
                accountList = new AccountRespository().getAllAccountUser();
            } else {
                accountList = new AccountRespository().getAccountFromRoleName(roleOfAccount);
            }
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
                <ul>
                    <%
                        List<Role> rolesOfAccount = new AccountRespository().getRoleFromAccountID(account.getId());
                        String roleName = new RoleRespository().getRoleName(rolesOfAccount).toString();
                        roleName = roleName.substring(1, roleName.length() - 1);
                        String[] arrRole = roleName.split(", ");
                        for (String r : arrRole) {%>
                    <li><%=r%>
                    </li>
                    <%}%>
                </ul>
            </div>
            <div class="border p-4 w-25">
                <button class="form-btn m-1 w-75" type="button" data-bs-toggle="modal" data-bs-target="#myModalUpdate">
                    Update
                </button>
                <button class="form-btn m-1 w-75" type="button" data-bs-toggle="modal" data-bs-target="#myModalDelete">
                    Delete
                </button>
                <button class="form-btn m-1 w-75" type="button" data-bs-toggle="modal" data-bs-target="#myModalGrant">
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
                    <h5 class="modal-title" id="staticBackdropLabel">Add a account</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="controller">
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
                <form action="controller">
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="up_acc_id" class="form-label">ID:</label>
                            <input type="text" class="form-control" id="up_acc_id" placeholder="Enter Account Id"
                                   name="up_acc_id" readonly value="<%=account.getId()%>">
                        </div>
                        <div class="mb-3">
                            <label for="up_acc_name" class="form-label">Name:</label>
                            <input type="text" class="form-control" id="up_acc_name" placeholder="Enter Account Name"
                                   name="up_acc_name" value="<%=account.getName()%>">
                        </div>
                        <div class="mb-3">
                            <label for="up_acc_email" class="form-label">Email:</label>
                            <input type="email" class="form-control" id="up_acc_email"
                                   placeholder="Enter Account Email" name="up_acc_email"
                                   value="<%=account.getEmail()%>">
                        </div>
                        <div class="mb-3">
                            <label for="up_acc_password" class="form-label">Password:</label>
                            <input type="text" class="form-control" id="up_acc_password"
                                   placeholder="Enter Account Password" name="up_acc_password"
                                   value="<%=account.getPassword()%>">
                        </div>
                        <div class="mb-3">
                            <label for="up_acc_phone" class="form-label">Phone:</label>
                            <input type="tel" class="form-control" id="up_acc_phone" placeholder="Enter Account Phone"
                                   name="up_acc_phone" value="<%=account.getPhone()%>">
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
                <form action="controller">
                    <div class="modal-body">
                        <label class="form-label">Are your sure delete account?</label>
                        <input type="hidden" name="del_acc_id" value="<%=account.getId()%>">
                        <input type="hidden" name="del_acc_name" value="<%=account.getName()%>">
                        <input type="hidden" name="del_acc_email" value="<%=account.getEmail()%>">
                        <input type="hidden" name="del_acc_password" value="<%=account.getPassword()%>">
                        <input type="hidden" name="del_acc_phone" value="<%=account.getPhone()%>">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                        <button type="submit" class="btn btn-primary" name="delAccount">Yes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModalGrant" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
         aria-labelledby="staticBackdropLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Grant Access</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="controller">
                    <div class="modal-body">
                        <select name="selectRoleGrant">
                        <%
                            List<Role> roles = new RoleRespository().getAllRole();
                            for (Role role : roles) {
                        %>
                            <option><%=role.getName()%></option>
                        <%}%>
                        </select>
                        <div class="mb-3">
                            <label for="grant_acc_note" class="form-label">Note:</label>
                            <input type="text" class="form-control" id="grant_acc_note" placeholder="Enter Grant Note"
                                   name="grant_acc_note">
                        </div>
                        <input type="hidden" name="grant_acc_id" value="<%=account.getId()%>">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary" name="grantAccount">Grant</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%}%>
</div>
</body>
</html>
