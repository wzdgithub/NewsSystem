<%@ page import="com.bean.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath(); %>
<!DOCTYPE html>
<html>
<head>
	<title>个人中心</title>
	<meta charset="utf-8"/>
	<link rel="stylesheet" type="text/css" href="<%=path%>/common/css/home.css">
	<link rel="stylesheet" type="text/css" href="<%=path%>/common/css/personal.css">
	<script src="<%=path%>/common/js/jquery-1.3.2.min.js"></script>
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
	<div class="header">
		<div class="header_center">
			<div class="header_logo">
				<a href="news_home">新闻管理系统</a>
			</div>
			<div class="header_menu">
				<ul>
					<a href="news_selectNewsByCategory?category=军事">
						<li>军事</li>
					</a>
					<a href="news_selectNewsByCategory?category=社会">
						<li>社会</li>
					</a>
					<a href="news_selectNewsByCategory?category=财经">
						<li>财经</li>
					</a>
					<a href="news_selectNewsByCategory?category=科技">
						<li>科技</li>
					</a>
					<a href="news_selectNewsByCategory?category=体育">
						<li>体育</li>
					</a>
					<a href="news_selectNewsByCategory?category=娱乐">
						<li>娱乐</li>
					</a>
				</ul>
			</div>
			<div class="header_search">
				<form action="news_selectNewsByTitle" method="post">
					<input type="text" class="search_title" name="title"/>
					<input type="submit" class="search_submit" value="搜索"/>
				</form>
			</div>
			<%
				if (user==null){
			%>
			<div class="register"><a href="<%=path%>/register.jsp">注册</a></div>
			<div class="login"><a href="<%=path%>/login.jsp">登录</a></div>
			<%}else{%>
			<div class="register"><a href="user_loginOutUser">登出</a></div>
			<div class="login"><a href="<%=path%>/personal.jsp"><%=user.getUsername()%></a></div>
			<%}%>
		</div>
  	</div>

  	<div class="personal-container">
  		<div class="personal-title">
  			<a href="">首页</a>
  			<span class="sep">&gt;</span>
  			<span>个人中心</span>
  		</div>
  		<div class="personal-content">
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
				<p><span class="icon-remove">X</span></p>
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