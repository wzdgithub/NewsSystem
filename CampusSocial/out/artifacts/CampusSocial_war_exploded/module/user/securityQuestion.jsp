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
    Security security = (Security) session.getAttribute("security");
%>
<body>
    <div class="panel panel-primary rp-center">
        <div class="panel-heading">
            <h4 class="panel-title">找回账号</h4>
        </div>
        <div class="panel-body">
            <p><%=security.getSecurityQuestion()%></p>
            <label class="">请输入答案</label>
            <input type="text" class="form-control sc-answer">
        </div>
        <div class="modal-footer">
            <button class="btn btn-danger next-step">下一步</button>
        </div>
    </div>
</body>
<script>
    $(function () {
        $(".next-step").click(function () {
            var answer = $(".sc-answer").val();
            if (answer==<%=security.getSecurityAnswer()%>){
                $(location).attr("href","/module/user/modifyPassword.jsp?userId=<%=security.getUserId()%>");
            }else{
                alert("答案错误");
            }
        })
    })
</script>
</html>
