<%@ page import="com.bean.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
	<title>个人中心</title>
	<meta charset="utf-8"/>
	<link rel="stylesheet" type="text/css" href="../common/css/home.css">
	<link rel="stylesheet" type="text/css" href="../common/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="../common/css/personal.css">
	<script src="../common/js/jquery-1.3.2.min.js"></script>
	<script>
		$(function(){
			$(".inf-input").hide();
			$(".modify").click(function(){
				$(".inf-input").show();
				$(".inf-data").text("");
				$(".modify").hide();
			})
		})

		$(function(){
			$(".mask").hide();
			$(".open").click(function(){
				$(".mask").show();
			})
			$(".icon-remove").click(function(){
				$(".mask").hide();
			})
		})
	</script>
</head>
<%
	User user = null;
	User u = (User) session.getAttribute("user");
	if(u != null){
		user = u;
	}
%>
<body>
	<div class="site-topbar">
		<div class="container">
			<div class="topbar-nav">
				<a href="<%=path%>/phone_home">手机销售系统</a>
				<span class="sep">|</span>
				<%if (user != null){%>
				<a href="<%=path%>/feedback.jsp">意见反馈</a>
				<%}else {%>
				<a href="<%=path%>/login.jsp">意见反馈</a>
				<%}%>
			</div>
			<div class="topbar-cart">
				<%if (user != null){%>
				<a class="cart-mini" href="shopCart_selectShopCart?userid=<%=user.getId()%>">
					<i class="icon-shopping-cart icon-large" style="margin-right:5px;"></i>
					购物车
				</a>
				<%}else {%>
				<a class="cart-mini" href="login.jsp">
					<i class="icon-shopping-cart icon-large" style="margin-right:5px;"></i>
					购物车
				</a>
				<%}%>
			</div>
			<div class="topbar-info">
				<%if (user == null){%>
				<a href="login.jsp" class="link">登录</a>
				<span class="sep">|</span>
				<a href="register.jsp" class="link">注册</a>
				<%}else{%>
				<a href="<%=path%>/personal/personal.jsp" class="link"><%=user.getUsername()%></a>
				<span class="sep">|</span>
				<a href="user_logout" class="link">登出</a>
				<%}%>
			</div>
		</div>
  	</div>

  	<div class="personal-container">
  		<div class="personal-title">
  			<a href="">首页</a>
  			<span class="sep">&gt;</span>
  			<span>个人中心</span>
  		</div>
  		<div class="personal-content">
  			<div class="personal-left">
				<p><a href="<%=path%>/personal/personal.jsp">个人信息</a></p>
				<p><a href="shopCart_selectShopCart?userid=<%=user.getId()%>">我的购物车</a></p>
				<p><a href="bill_selectBill?userid=<%=user.getId() %>">我的账单</a></p>
  			</div>
  			<div class="personal-right">
  				<div class="personal-img">
  					<img src="<%=path%>/<%=user.getIcon()%>"/>
  					<p><span class="open">设置头像</span></p>
  				</div>
  				<div class="personal-inf">
					<form action="user_updateUserDetails" method="post">
						<div class="personal-data">
							<p><h3>个人资料</h3></p>
						</div>
						<div class="personal-data">
							<p><span>用户名：</span><%=user.getUsername()%></p>
						</div>
						<div class="personal-data">
							<input type="hidden" name="id" value="<%=user.getId()%>"/>
							<p><span>姓名：</span><span class="inf-data"><%=user.getName()%></span>
								<input type="text" name="name" value="<%=user.getName()%>" class="inf-input"/></p>
						</div>
						<div class="personal-data">
							<p><span>性别：</span><span class="inf-data"><%=user.getSex()%></span>
								<input type="text" name="sex" value="<%=user.getSex()%>" class="inf-input"/></p>
						</div>
						<div class="personal-data">
							<p><span>电话号：</span><span class="inf-data"><%=user.getTelephone()%></span>
								<input type="text" name="telephone" value="<%=user.getTelephone()%>" class="inf-input"/></p>
						</div>
						<div class="personal-data">
							<p><span>邮箱：</span><span class="inf-data"><%=user.getEmail()%></span>
								<input type="text" name="email" value="<%=user.getEmail()%>" class="inf-input"/></p>
						</div>
						<p class="personal-modify"><span class="modify">修改资料</span></p>
						<input type="submit" class="inf-input" value="提交"/>
					</form>
  				</div>
  			</div>
  		</div>
  	</div>

	<div class="mask">
		<div class="mask-container">
			<div class="mask-content">
				<p><i class="icon-remove"></i></p>
				<form action="user_updateUserIcon" method="post" enctype="multipart/form-data">
					<input type="hidden" name="id" value="<%=user.getId()%>">
					<input type="file" name="icon" /><br/>
					<input type="submit" value="开始上传">
				</form>
			</div>
		</div>
	</div>
</body>
</html>