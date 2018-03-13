<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
  <title>Login</title>
  <meta charset="utf-8"/>
  <link rel="stylesheet" type="text/css" href="<%=path%>/common/css/loginAndRegister.css">
</head>
<body>
<div class="content">
  <div class="content-title">管理员登录</div>
  <div class="content-form">
    <form action="admin_loginAdmin" method="post">
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