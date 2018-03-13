<%@ page import="java.util.List" %>
<%@ page import="com.bean.Phone" %>
<%@ page import="com.bean.PageBean" %>
<%@ page import="com.bean.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
	<title></title>
	<meta charset="utf-8"/>
	<link rel="stylesheet" type="text/css" href="common/css/home.css">
	<link rel="stylesheet" type="text/css" href="common/css/goods.css">
	<link rel="stylesheet" type="text/css" href="common/css/font-awesome.min.css">
	<script src="../common/js/jquery-1.3.2.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$("#search-submit").click(function(){
				$(".search-form").submit();
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

	PageBean pagePhone = (PageBean) request.getAttribute("pagePhone");
	List<Phone> phones = pagePhone.getPageList();

	String shop = request.getParameter("category");
%>
<body>
	<div class="site-topbar">
		<div class="container">
			<div class="topbar-nav">
				<a href="phone_home">手机销售系统</a>
				<span class="sep">|</span>
				<%if (user != null){%>
				<a href="feedback.jsp"></a>
				<%}else {%>
				<a href="login.jsp"></a>
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

  	<div class="site-header">
  		<div class="container">
  			<div class="header-nav">
  				<ul class="nav-list">
  					<li class="nav-item"><a class="link" href="phone_selectPhoneByCategory?category=苹果">苹果</a></li>
  					<li class="nav-item"><a class="link" href="phone_selectPhoneByCategory?category=三星">三星</a></li>
					<li class="nav-item"><a class="link" href="phone_selectPhoneByCategory?category=小米">小米</a></li>
					<li class="nav-item"><a class="link" href="phone_selectPhoneByCategory?category=华为">华为</a></li>
					<li class="nav-item"><a class="link" href="phone_selectPhoneByCategory?category=OPPO">OPPO</a></li>
					<li class="nav-item"><a class="link" href="phone_selectPhoneByCategory?category=魅族">魅族</a></li>
  				</ul>
  			</div>

			<div class="header-search">
				<form action="phone_selectPhoneByName" class="search-form" method="post">
					<input name="name" class="search-text" id="search">
					<span class="search-btn" id="search-submit"><i class="icon-search"></i></span>
				</form>
			</div>
  		</div>
  	</div>

  	<div class="goods-container">
  		<div class="goods-container-hd">
  			<div class="f-sort">
  				<a href="phone_selectPhoneBySales?category=<%=shop%>">销量</a>
  				<a href="phone_selectPhoneByPrice?category=<%=shop%>">价格</a>
  				<a href="phone_selectPhoneByDate?category=<%=shop%>">新品</a>
  			</div>
  		</div>
  		<div class="goods-list">
  			<ul class="gl-warp clearfix">
				<% for(Phone p:phones){ %>
  				<li class="gl-item">
  					<div class="gl-i-wrap">
  						<div class="p-img"><a href="phone_selectPhoneById?id=<%=p.getId()%>"><img src="<%=p.getIntroduction_img()%>"/></a></div>
  						<div class="p-price">￥<%=p.getPrice()%></div>
  						<div class="p-name"><a href="phone_selectPhoneById?id=<%=p.getId()%>"><%=p.getName()%></a></div>
  						<div class="p-commit"><p>已有<span><%=p.getSales()%></span>人购买</p></div>
  						<div class="p-shop"><%=p.getShop()%></div>
  					</div>
  				</li>
				<%}%>
  			</ul>
			<div style="text-align: center;margin: 20px;">
				<%if (pagePhone.getCurrentPage() > 1){%>
				<a href="phone_selectPhone?currentPage=<%=pagePhone.getCurrentPage()-1%>">上一页</a>
				<%}%>
				<span><%=pagePhone.getCurrentPage()%></span>/<span><%=pagePhone.getTotalPage()%></span>
				<%if (pagePhone.getCurrentPage() < pagePhone.getTotalPage()){%>
				<a href="phone_selectPhone?currentPage=<%=pagePhone.getCurrentPage()+1%>">下一页</a>
				<%}%>
			</div>
  		</div>
  	</div>

	<div class="footer" style="background: #f5f5f5;">
		<div>
			欢迎使用手机销售系统<br/>
			©2017 版权归XXX所有
			<%if (user != null){%>
			<a href="feedback.jsp">意见反馈</a>
			<%}else {%>
			<a href="login.jsp">意见反馈</a>
			<%}%>
		</div>
	</div>
</body>
</html>