<%@ page import="com.bean.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
	<title>新闻管理系统</title>
	<meta charset="utf-8"/>
	<link rel="stylesheet" type="text/css" href="../common/css/admin.css">
	<script src="../common/js/jquery-1.3.2.min.js"></script>
</head>
<body>
	<%
		Admin admin = (Admin) session.getAttribute("admin");
	%>
	<%
		if (admin == null){
	%>
	<jsp:forward page="adminlogin.jsp"/>
	<%}else{%>
	<div class="site-topbar">
		<div class="topbar-nav">
			<a href="">新闻管理系统</a>
		</div>
  	</div>
  	
  	<div class="left-menu">
  		<ul>
  			<li><a href="news_AllNewsByAdmin" target="content-frame">新闻管理</a></li>
  			<li><a href="comment_allCommentByAdmin" target="content-frame">评论管理</a></li>
  			<li><a href="score_selectScore" target="content-frame">评分管理</a></li>
  			<li><a href="feedback_selectFeedback" target="content-frame">留言管理</a></li>
  			<li><a href="user_selectUser" target="content-frame">用户管理</a></li>
  		</ul>
  	</div>
  	<div class="right-content">
  		<iframe src="news_AllNewsByAdmin" name="content-frame" scrolling="yes" frameborder="no"></iframe>
  	</div>
	<%}%>
</body>
<script>
	$(function(){
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