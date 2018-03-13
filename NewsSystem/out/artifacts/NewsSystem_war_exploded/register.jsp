<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>MyRegister</title>
    <link rel="stylesheet" type="text/css" href="common/css/register.css" />
    <script src="common/js/jquery.js"></script>
</head>

<body style="background: #f7f7f7;">
<div class="content">
	<div class="register_logo">
        <img src="" />  <!-- logo图片大小114*38 -->
    </div>
    <div class="register_left">
    	<div>
        <form action="user_register" method="post">
        	<table>
            	<tr>
                	<td><h2>用户注册</h2></td>
                </tr>
                <tr>
                	<td><input type="text" placeholder="昵称" onkeyup="this.value=this.value.replace(/[\u4e00-\u9fa5]/g,'')" value="" name="username" /></td>
                </tr>
                <tr>
                	<td><input type="password" placeholder="密码" value="" name="password" /></td>
                </tr>
                <tr>
                	<td><input type="password" placeholder="确认密码" value="" name="affirm" />
                </tr>
                <tr>
                	<td><input type="text" placeholder="电子邮件" value="" name="email"/></td>
                </tr>
                <tr>
                	<td><input type="submit" value="立即注册"/></td>
                </tr> 76
            </table>
            </form> 
        </div>
    </div>
    <div class="register_right">
    	<div>
        	<div class="register_other_word">
                <p>欢迎使用新闻管理系统</p>
                <p><a class="register_other_a" href="login.jsp">如果已有账号请在此登录</a></p>
                <p><a href="news_home">返回首页</a></p>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    $(function(){
        $("input[name=affirm]").blur(function(){
            var password = $("input[name=password]").val();
            var affirm = $("input[name=affirm]").val();
            if(password!=affirm){
                alert("两次输入的密码不一致请从新输入");
                $("input[type=submit]").attr("disabled","disable");
            }else{
                $("input[type=submit]").removeAttr("disabled");
            }
        })
    })
</script>
</html>
