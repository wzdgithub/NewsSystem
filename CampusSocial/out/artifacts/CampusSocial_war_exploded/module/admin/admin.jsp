<%@ page import="com.bean.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
	<title>校园社交系统后台管理</title>
	<meta charset="utf-8"/>
	<link rel="stylesheet" href="/module/commons/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="/module/admin/css/admin.css">

	<script src="/module/commons/js/jquery-3.2.1.min.js"></script>
	<script type="application/javascript" src="/module/commons/bootstrap/js/bootstrap.min.js"></script>
</head>
<%
	Admin admin = (Admin) session.getAttribute("admin");
	if(admin==null)
		response.sendRedirect("/module/admin/adminlogin.jsp");
%>
<body>
	<div class="site-topbar navbar navbar-default">
		<div class="topbar-nav">
			<a href="">校园社交系统后台管理</a>
		</div>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="#"  style="color: #fff;margin-right: 40px;">欢迎：<%=admin.getAdminName()%> &nbsp;&nbsp;<span class="glyphicon glyphicon-off adminLogout"></span></a></li>
		</ul>
  	</div>
  	
  	<div class="left-menu">
  		<ul class="list-group">
  			<li class="list-group-item"><a href="/module/admin/userAdmin.jsp" target="content-frame">用户管理</a></li>
  			<li class="list-group-item"><a href="/module/admin/postAdmin.jsp" target="content-frame">帖子管理</a></li>
  			<li class="list-group-item"><a href="/module/admin/questionAdmin.jsp" target="content-frame">问答管理</a></li>
  			<li class="list-group-item"><a href="/module/admin/categoryAdmin.jsp" target="content-frame">类别管理</a></li>
  		</ul>
  	</div>
  	<div class="right-content">
  		<iframe src="/module/admin/userAdmin.jsp" name="content-frame" scrolling="yes" frameborder="no"></iframe>
  	</div>
</body>
<script>
	$(function(){
		$(".adminLogout").click(function(){
			$(location).attr('href', '/adminLogout.action');
		})

		var bodyWidth = $(window).width();
		var bodyHeight = $(window).height();

		$(".right-content iframe").width(bodyWidth-180);
		$(".right-content iframe").height(bodyHeight - 40);
		$(window).resize(function(){
			bodyWidth = $(window).width();
			bodyHeight = $(window).height();

			$(".right-content iframe").width(bodyWidth-180);
			$(".right-content iframe").height(bodyHeight - 40);
		})

	})
</script>
</html>