<%@ page import="vn.edu.iuh.fit.entities.Account" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.iuh.fit.entities.Role" %>
<%@ page import="vn.edu.iuh.fit.repositories.RoleRepository" %>
<%@ page import="vn.edu.iuh.fit.repositories.GrantAccessRepository" %>
<%@ page import="vn.edu.iuh.fit.entities.GrantAccess" %><%--
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        function showModal(e) {
            const td = e.parentElement.parentElement.getElementsByTagName("td");
            document.getElementById("grantAccount").value = td[0].textContent.trim()
            if (e.checked === true) {
                document.getElementById("stopShowModal").value = e.getAttribute("id");
                document.getElementById("closeModal").value = e.getAttribute("id");
                document.getElementById("modalIdRole").innerHTML = td[0].textContent
                document.getElementById("modalNameRole").innerHTML = td[1].textContent
                document.getElementById("modalDescriptionRole").innerHTML = td[2].textContent
                const note = td[3].textContent.trim()
                if (note !== "")
                    document.getElementById("modalNoteRole").innerHTML = note
                document.getElementById("showModal").click()
            } else{
                document.getElementById("grantAccount").value += "revoke"
                alert("Revoked role of user!")
                document.getElementById("grantAccount").click()
            }
        }

        function denyGrant(e) {
            document.getElementById(e.getAttribute("value")).checked = false
        }
    </script>
</head>
<body>
<div class="container">
    <h3 class="text-center">Grant</h3>
    <div class="d-flex">
        <div class="bg-info w-25 p-4">
            <h4 class="text-center" style="text-align: center;">User</h4>
            <div>
                <%
                    Account account = null;
                    Object obj = session.getAttribute("accountGrant");
                    if (obj != null) {
                        account = (Account) obj;%>
                <h5>Id: <%=account.getId()%>
                </h5>
                <h5 class="my-4">Name: <%=account.getName()%>
                </h5>
                <h5>Email: <%=account.getEmail()%>
                </h5>
                <h5 class="my-4">Phone: <%=account.getPhone()%>
                </h5>
                <%}%>
            </div>
        </div>
        <div class="bg-warning w-75 p-4">
                <h4 class="text-center" style="text-align: center">Roles</h4>
            <table class="table table-hover text-center fs-5 mt-2" style="width: 100%;">
                <thead>
                <tr>
                    <th>Id</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Note</th>
                    <th>Status</th>
                    <%--                    <th>Edit Role</th>--%>
                </tr>
                </thead>
                <tbody>
                <%
                    if (account != null) {
                        Object objRoleOfAccount = session.getAttribute("rolesAccount");
                        if (objRoleOfAccount != null) {
                            List<Role> rolesOfAccount = (List<Role>) objRoleOfAccount;
                            List<Role> roles = new RoleRepository().getAllRole();
                            roles.add(new RoleRepository().getRole("user"));
                            String note = "";
                            GrantAccessRepository grantAccessRepository = new GrantAccessRepository();
                            GrantAccess grantAccess;
                            int i=0;
                            for (Role role : roles) {
                                i++;
                                grantAccess = grantAccessRepository.getOneByAccountIdAndRoleId(account.getId(), role.getId());
                                if (grantAccess != null)
                                    note = grantAccess.getNote();
                %>
                <tr>
                    <td><%=role.getId()%>
                    </td>
                    <td><%=role.getName()%>
                    </td>
                    <td><%=role.getDescription()%>
                    </td>
                    <td><%=note%>
                    </td>
                    <td>
                        <%
                            if (rolesOfAccount.contains(role)) {
                        %>
                        <input class="form-check-input" id="checkBoxCheck" type="checkbox" checked
                               onclick="showModal(this)">
                        <%}%>
                        <%
                            if (!rolesOfAccount.contains(role)) {
                        %>
                        <input class="form-check-input" id="checkBoxNotCheck" type="checkbox" onclick="showModal(this)">
                        <%}%>
                        <button style="display: none" id="showModal" data-bs-toggle="modal"
                                data-bs-target="#grantModal">
                        </button>
                    </td>
                    <%--                    <td>--%>
                    <%--                        <button class="btn btn-primary" type="button" data-bs-toggle="modal"--%>
                    <%--                                data-bs-target="#grantModal">Edit--%>
                    <%--                        </button>--%>
                    <%--                    </td>--%>
                </tr>
                <%
                            }
                        }
                    }
                %>
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
                    <button type="button" class="btn-close" id="stopShowModal" value="" data-bs-dismiss="modal"
                            aria-label="Close" onclick="denyGrant(this)"></button>
                </div>
                <form action="accountController" method="post">
                    <div class="modal-body">
                        <h5>Role id: <span id="modalIdRole"></span></h5>
                        <h5>Name: <span id="modalNameRole"></span></h5>
                        <h5>Description: <span id="modalDescriptionRole"></span></h5>
                        <label class="h5" for="modalNoteRole">Note:</label>
                        <textarea class="form-control my-2" id="modalNoteRole" placeholder="Enter the note of role"
                                  name="note"></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" id="closeModal" value="" data-bs-dismiss="modal"
                                onclick="denyGrant(this)">Close
                        </button>
                        <button type="submit" class="btn btn-primary" id="grantAccount" value="" name="grantAccount">
                            Grant
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
