<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/4/17
  Time: 22:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
    <style>
        body{
            background: #f7f7f7;
        }
        .content {
            width: 400px;
            height: 350px;
            position: relative;
            top: 50%;
            left: 50%;
            margin-top: -175px;
            margin-left: -200px;
            border-radius: 10px;
            background: #fff;
            text-align: center;
        }
        input[type="text"], input[type="password"] {
            width: 200px;
            height: 30px;
            border-style: solid;
            border-width: 2px;
            border-color: rgb(0,84,146);
            outline: none;
            border-radius: 8px;
            margin: 10px;
            padding-left: 8px;
        }
        input[type="submit"] {
            width: 200px;
            height: 30px;
            font-size: 18px;
            border-radius: 5px;
            margin: 10px;
            background: rgb(0,84,146);
            border: 2px solid rgb(0,84,146);
            outline: none;
            color: #fff;
            cursor: pointer;
        }
        h2{
            padding-top: 60px;
        }
    </style>
</head>
<body>
<div class="content">
    <h2>管理员登录入口</h2>
    <form action="admin_loginAdmin" method="post">
        <input type="text" name="adminname" placeholder="管理员账号"/>
        <input type="password" name="password" placeholder="管理员密码"/><br>
        <input type="submit" value="管理员登录"/>
    </form>
</div>
</body>
</html>
