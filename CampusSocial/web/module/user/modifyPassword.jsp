<%@ page import="com.bean.Security" %><%--
  Created by IntelliJ IDEA.
  User: ZhenDong
  Date: 2017/5/3
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>找回密码</title>
    <link rel="stylesheet" href="/module/commons/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/module/home/css/index.css">
    <link rel="stylesheet" href="/module/user/css/retrieve-password.css">

    <script type="application/javascript" src="/module/commons/js/jquery-3.2.1.min.js"></script>
    <script type="application/javascript" src="/module/commons/bootstrap/js/bootstrap.min.js"></script>
</head>
<%
    int userId = Integer.parseInt(request.getParameter("userId"));
%>
<body>
    <div class="panel panel-primary rp-center">
        <div class="panel-heading">
            <h4 class="panel-title">找回账号</h4>
        </div>
        <form action="/updateUserPassword.action" method="post">
        <div class="panel-body">
            <input type="hidden" name="userId" value="<%=userId%>">
            <label class="">新的密码</label>
            <input type="password" name="password" class="form-control new-password">
        </div>
        <div class="modal-footer">
            <button type="submit" class="btn btn-danger next-step">下一步</button>
        </div>
        </form>
    </div>
</body>
</html>
