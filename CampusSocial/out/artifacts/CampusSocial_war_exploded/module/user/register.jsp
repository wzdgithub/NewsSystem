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
    <title>注册</title>
    <link rel="stylesheet" type="text/css" href="/module/user/style/register-login.css">
    <style>
        .form{
            width: 600px;
        }
        .group{
            width: 300px;
            float: left;
        }
        .group-span {
            width: 200px;
            float: left;
            margin-left: 10px;
        }
        .group-sp{
            height: 45px;
            line-height: 45px;
            overflow: visible;
        }
    </style>
</head>
<body>
<div id="box"></div>
<div class="cent-box register-box">
    <div class="cent-box-header">
        <h1 class="main-title">校园社交平台</h1>
        <h2 class="sub-title">生活热爱分享</h2>
    </div>

    <div class="cont-main clearfix">
        <div class="index-tab">
            <div class="index-slide-nav">
                <a href="/module/user/login.jsp">登录</a>
                <a href="/module/user/register.jsp" class="active">注册</a>
                <div class="slide-bar slide-bar1"></div>
            </div>
        </div>

        <div class="login form">
            <div class="group">
                <div class="group-ipt user">
                    <input type="text" name="username" id="user" class="ipt" placeholder="选择一个用户名" required>
                </div>
                <div class="group-ipt password">
                    <input type="password" name="password" id="password" class="ipt" placeholder="设置登录密码" required>
                </div>
                <div class="group-ipt password1">
                    <input type="password" name="password1" id="password1" class="ipt" placeholder="重复密码" required>
                </div>
                <div class="group-ipt email">
                    <input type="text" name="email" id="email" class="ipt" placeholder="邮箱地址" required>
                </div>
                <div class="group-ipt telephone">
                    <input type="text" name="telephone" id="telephone" class="ipt" placeholder="电话号" required>
                </div>
                <div class="group-ipt security">
                    <select name="" id="question">
                        <option value="你母亲的姓名">你母亲的姓名</option>
                        <option value="你父亲的姓名">你父亲的姓名</option>
                        <option value="你大学所在学校">你大学所在学校</option>
                        <option value="你爱人的姓名">你爱人的姓名</option>
                        <option value="你出生地">你出生地</option>
                    </select>
                </div>
                <div class="group-ipt answer">
                    <input type="text" name="answer" id="se-answer" class="ipt" placeholder="密保答案" required>
                </div>
            </div>
            <div class="group-span">
                <div class="group-sp user-span">
                </div>
                <div class="group-sp password-span">
                </div>
                <div class="group-sp password1-span">
                </div>
                <div class="group-sp email-span">
                </div>
                <div class="group-sp telephone-span">
                </div>
                <div class="group-sp question-span">
                </div>
                <div class="group-sp answer-span">
                </div>
            </div>
        </div>

        <div class="button">
            <button type="button" class="login-btn register-btn" id="button">注册</button>
        </div>
    </div>
</div>

<script src='/module/user/js/particles.js' type="text/javascript"></script>
<script src='/module/user/js/background.js' type="text/javascript"></script>
<script src='/module/user/js/jquery.min.js' type="text/javascript"></script>
<script src='/module/user/js/layer/layer.js' type="text/javascript"></script>
<script src='/module/user/js/index.js' type="text/javascript"></script>
<script>
    var u = 0;
    var p = 0;
    var p1 = 0;
    var e = 0;
    var t = 0;
    var a = 0;
    var username;
    var password;
    var email;
    var telephone;
    var answer;
    $("#user").blur(function () {
        username = $("#user").val();
        if(username.length>=6&&username.length<=12){
            $.post("/verifyUser.action",{username:username},function (result) {
                if (result == 1)
                {
                    $(".user-span").html("<p style='color: red;font-size: 14px;'>用户已存在</p>");
                }else if(result == 0){
                    u = 1;
                    $(".user-span").html("<p style='color: green;font-size: 14px;'>可以注册</p>");
                }
            });
        }else if(username.length < 6){
            $(".user-span").html("<p style='color: red;font-size: 14px;'>用户名太短</p>");
        }else if(username.length > 12){
            $(".user-span").html("<p style='color: red;font-size: 14px;'>用户名太长</p>");
        }
    })
    $("#password").blur(function () {
        password = $("#password").val();
        if(password.length>=6&&password.length<=16){
            $(".password-span").html("");
            p = 1;
        }else if(password.length < 6){
            $(".password-span").html("<p style='color: red;font-size: 14px;'>密码太短</p>");
        }else if(password.length > 16){
            $(".password-span").html("<p style='color: red;font-size: 14px;'>密码太长</p>");
        }
    })

    $("#password1").blur(function () {
        var pa = $("#password").val();
        var pa1 = $("#password1").val();
        if(pa1 == pa){
            $(".password1-span").html("");
            p1 = 1;
        }else{
            $(".password1-span").html("<p style='color: red;font-size: 14px;'>密码不一致</p>");
        }
    })
    $("#email").blur(function () {
        email = $("#email").val();
        if(email != null && email!=""){
            $(".email-span").html("");
            e = 1;
        }else {
            $(".email-span").html("<p style='color: red;font-size: 14px;'>邮箱不能为空</p>");
        }
    })
    $("#telephone").blur(function () {
        telephone = $("#telephone").val();
        if(telephone != null && telephone!=""){
            $(".telephone-span").html("");
            t = 1;
        }else {
            $(".telephone-span").html("<p style='color: red;font-size: 14px;'>电话不能为空</p>");
        }
    })
    $("#se-answer").blur(function () {
        answer = $("#se-answer").val();
        if(answer != null && answer!=""){
            $(".answer-span").html("");
            a = 1;
        }else {
            $(".answer-span").html("<p style='color: red;font-size: 14px;'>密保答案不能为空</p>");
        }
    })
    $(".register-btn").click(function(){
        var question = $("#question").val();
        if(u == 1&&p==1&&p1==1&&e==1&&t==1&&a==1){
            $.ajax({
                url: '/register.action',
                type: 'post',
                async: false,
                data: {
                    username:username,
                    password:password,
                    email:email,
                    telephone:telephone,
                    question:question,
                    answer:answer
                },success:function (date) {
                    if(date > 0){
                        $(location).attr("href","/module/user/login.jsp");
                    }else{
                        $(location).attr("href","/module/user/register.jsp");
                    }
                }
            })
        }
    })
</script>
</body>
</html>
