<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<title>手机销售系统后台管理</title>
	<meta charset="utf-8"/>
	<link rel="stylesheet" type="text/css" href="../common/css/admin.css">
	<link rel="stylesheet" type="text/css" href="../common/css/font-awesome.min.css">
	<script src="../common/js/jquery-1.3.2.min.js"></script>
</head>
<body>
	<div class="site-topbar">
		<div class="topbar-nav">
			<a href="">手机销售系统</a>
		</div>
  	</div>
  	
  	<div class="left-menu">
  		<ul>
  			<li><a href="phone_selectPhone" target="content-frame">商品管理</a></li>
  			<li><a href="user_selectUser" target="content-frame">会员管理</a></li>
  			<li><a href="bill_selectBillAdmin" target="content-frame">账单管理</a></li>
  			<li><a href="comment_selectComment" target="content-frame">评论管理</a></li>
  			<li><a href="#" target="content-frame">统计分析</a></li>
  			<%--<li><a href="ad_selectAd" target="content-frame">广告管理</a></li>--%>
			<%--<li><a href="feedback_selectFeedback" target="content-frame">反馈管理</a></li>--%>
  		</ul>
  	</div>
  	<div class="right-content">
  		<iframe src="phone_selectPhone" name="content-frame" scrolling="yes" frameborder="no"></iframe>
  	</div>
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