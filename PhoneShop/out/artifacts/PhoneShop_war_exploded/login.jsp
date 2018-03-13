<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<title>Login</title>
	<meta charset="utf-8"/>
	<link rel="stylesheet" type="text/css" href="common/css/loginAndRegister.css">
</head>
<body>
	<div class="content">
		<div class="content-title">用户登录</div>
		<div class="content-form">
			<form action="user_login" method="post">
				<label>
					<input type="text" name="username" placeholder="请输入用户名"/>
				</label>
				<label>
					<input type="password" name="password" placeholder="请输入密码"/>
				</label>
				<input type="submit" value="立即登录" />
			</form>
		</div>
	</div>
</body>
</html>