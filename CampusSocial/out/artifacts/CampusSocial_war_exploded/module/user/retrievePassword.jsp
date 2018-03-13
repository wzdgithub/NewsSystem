<%--
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
<body>
    <div class="panel panel-primary rp-center">
        <div class="panel-heading">
            <h4 class="panel-title">找回账号</h4>
        </div>
        <div class="panel-body">
            <label class="">请输入账号</label>
            <input type="text" class="form-control username">
        </div>
        <div class="modal-footer">
            <button class="btn btn-danger next-step">下一步</button>
        </div>
    </div>
</body>
<script>
    $(function () {
        var username;
        $(".next-step").click(function () {
            username = $(".username").val();
            $.post("/verifyUser.action",{username:username},function (result) {
                if (result == 1)
                {
                    $(location).attr("href","/selectSecurityByUserName.action?username="+username);
                }else if(result == 0){
                    alert("用户不存在");
                }
            });
        })
    })
</script>
</html>
