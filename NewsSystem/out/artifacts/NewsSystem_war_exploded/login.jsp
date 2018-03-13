<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
	<title>MyLogin</title>
	<link rel="stylesheet" href="common/css/Login.css">
</head>
<body style="background: #f7f7f7;">
	<div class="content">
		<div class="login_left">
			<img src="common/picture/newslogin.jpg" alt="">
		</div>
		<div class="login_right">
			<div class="login_logo"></div>
			<form action="user_loginUser" method="post">
				<h2>用户登录</h2>
				<input type="text" name="username" placeholder="昵称"><br>
				<input type="password" name="password" placeholder="密码">
				<input type="submit" value="登录">
				<a href="register.jsp" class="login_a">立即注册</a>
			</form>
			<div style="padding-left: 50px;margin-top: 20px;"><a href="news_home">返回首页</a></div>
		</div>
	</div>
</body>
</html>
