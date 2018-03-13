<%--
  Created by IntelliJ IDEA.
  User: ZhenDong
  Date: 2017/3/21
  Time: 9:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>登录</title>
    <link rel="stylesheet" type="text/css" href="/module/user/style/register-login.css">
</head>
<body>
<div id="box"></div>
<div class="cent-box">
    <div class="cent-box-header">
        <h1 class="main-title">校园社交平台</h1>
        <h2 class="sub-title">生活热爱分享</h2>
    </div>

    <div class="cont-main clearfix">
        <div class="index-tab">
            <div class="index-slide-nav">
                <a href="/module/user/login.jsp" class="active">登录</a>
                <a href="/module/user/register.jsp">注册</a>
                <div class="slide-bar"></div>
            </div>
        </div>
        <form action="/login.action" method="post">
        <div class="login form">
            <div class="group">
                <div class="group-ipt email">
                    <input type="text" name="username" id="username" class="ipt" placeholder="用户名" required>
                </div>
                <div class="group-ipt password">
                    <input type="password" name="password" id="password" class="ipt" placeholder="输入您的登录密码" required>
                </div>
            </div>
        </div>

        <div class="button">
            <button type="submit" class="login-btn register-btn" id="button">登录</button>
        </div>
        </form>

        <div class="remember clearfix">
            <label class="forgot-password">
                <a href="/module/user/retrievePassword.jsp">忘记密码？</a>
            </label>
        </div>
    </div>
</div>

<div class="footer">

</div>

<script src='/module/user/js/particles.js' type="text/javascript"></script>
<script src='/module/user/js/background.js' type="text/javascript"></script>
<script src='/module/user/js/jquery.min.js' type="text/javascript"></script>
<script src='/module/user/js/layer/layer.js' type="text/javascript"></script>
<script src='/module/user/js/index.js' type="text/javascript"></script>
<script>
    $("#remember-me").click(function(){
        var n = document.getElementById("remember-me").checked;
        if(n){
            $(".zt").show();
        }else{
            $(".zt").hide();
        }
    });
</script>
</body>
</html>
