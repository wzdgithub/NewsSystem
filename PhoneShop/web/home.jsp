<%@ page import="com.bean.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bean.Phone" %>
<%@ page import="com.bean.Ad" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
	<title>Phone Shop</title>
	<meta charset="utf-8"/>
	<link rel="stylesheet" type="text/css" href="common/css/home.css">
	<link rel="stylesheet" type="text/css" href="common/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="common/css/unslider.css">
	<script src="<%=path%>/common/js/jquery.js"></script>
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
	List<Phone> phoneSales = (List<Phone>) request.getAttribute("phoneSales");
	List<Phone> phoneDate = (List<Phone>) request.getAttribute("phoneDate");
	List<Ad> adList = (List<Ad>) request.getAttribute("adList");
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

  	<div class="home-container">
  		<div class="home-viwepager">
			<ul>
				<li><a href="<%=path%>/phone_selectPhoneById?id=31"><img src="common/img/1.jpg" alt=""></a></li>
				<li><a href="<%=path%>/phone_selectPhoneById?id=27"><img src="common/img/2.jpg" alt=""></a></li>
				<li><a href="<%=path%>/phone_selectPhoneById?id=28"><img src="common/img/3.jpg" alt=""></a></li>
				<li><a href="<%=path%>/phone_selectPhoneById?id=29"><img src="common/img/4.jpg" alt=""></a></li>
				<li><a href="<%=path%>/phone_selectPhoneById?id=26"><img src="common/img/5.jpg" alt=""></a></li>
			</ul>
  		</div>
  	</div>
	<script src="<%=path%>/common/js/unslider.js"></script>
	<script>
		$(function() {
			$('.home-viwepager').unslider({
				autoplay:true
			});
		})
	</script>
	<style>
		.unslider-nav {
			display: none;
		}
		.unslider-arrow{
			display: none;
		}
	</style>
  	<%--<div class="ad clearfix">--%>
		<%--<%for (int i = 0;i<adList.size() - 1;i++){%>--%>
  		<%--<div class="ad-1"><a href="<%=adList.get(i).getAdUrl()%>"><img src="<%=adList.get(i).getAdImg()%>" alt=""/></a></div>--%>
		<%--<%}%>--%>
  		<%--<div class="ad-5"><a href="<%=adList.get(adList.size() - 1).getAdUrl()%>"><img src="<%=adList.get(adList.size() - 1).getAdImg()%>" alt=""/></a></div>--%>
  	<%--</div>--%>

  	<div class="goods clearfix">
  		<div class="goods-sales clearfix">
  			<div class="sales-hd">
  				<h2 class="title">畅销商品</h2>
  				<div class="more">
  					<%--<a href="">查看全部<i class="icon-circle-arrow-right" style="margin-left:10px"></i></a>--%>
  				</div>
  			</div>

  			<div class="sales-1">
			  <div class="gl-i-wrap">
				<div class="p-img"><a href="phone_selectPhoneById?id=<%=phoneSales.get(0).getId()%>"><img src="<%=phoneSales.get(0).getIntroduction_img()%>"/></a></div>
				<div class="p-price">￥<%=phoneSales.get(0).getPrice() %></div>
				<div class="p-name"><a href=""><%=phoneSales.get(0).getName() %></a></div>
				<div class="p-commit"><p>已有<span><%=phoneSales.get(0).getSales() %></span>人购买</p></div>
				<div class="p-shop"><%=phoneSales.get(0).getShop() %></div>
			  </div>
			</div>

  			<div class="sales-2">
			  <div class="gl-i-wrap">
				  <div class="p-img"><a href="phone_selectPhoneById?id=<%=phoneSales.get(1).getId()%>"><img src="<%=phoneSales.get(1).getIntroduction_img()%>"/></a></div>
				  <div class="p-price">￥<%=phoneSales.get(1).getPrice() %></div>
				  <div class="p-name"><a href=""><%=phoneSales.get(1).getName() %></a></div>
				  <div class="p-commit"><p>已有<span><%=phoneSales.get(1).getSales() %></span>人购买</p></div>
				  <div class="p-shop"><%=phoneSales.get(1).getShop() %></div>
			  </div>
			</div>
  			<div class="sales-3">
			  <div class="gl-i-wrap">
				  <div class="p-img"><a href="phone_selectPhoneById?id=<%=phoneSales.get(2).getId()%>"><img src="<%=phoneSales.get(2).getIntroduction_img()%>"/></a></div>
				  <div class="p-price">￥<%=phoneSales.get(2).getPrice() %></div>
				  <div class="p-name"><a href=""><%=phoneSales.get(2).getName() %></a></div>
				  <div class="p-commit"><p>已有<span><%=phoneSales.get(2).getSales() %></span>人购买</p></div>
				  <div class="p-shop"><%=phoneSales.get(2).getShop() %></div>
			  </div>
			</div>
  			<div class="sales-4">
			  <div class="gl-i-wrap">
				  <div class="p-img"><a href="phone_selectPhoneById?id=<%=phoneSales.get(3).getId()%>"><img src="<%=phoneSales.get(3).getIntroduction_img()%>"/></a></div>
				  <div class="p-price">￥<%=phoneSales.get(3).getPrice() %></div>
				  <div class="p-name"><a href=""><%=phoneSales.get(3).getName() %></a></div>
				  <div class="p-commit"><p>已有<span><%=phoneSales.get(3).getSales() %></span>人购买</p></div>
				  <div class="p-shop"><%=phoneSales.get(3).getShop() %></div>
			  </div>
			</div>
  			<div class="sales-5">
			  <div class="gl-i-wrap">
				  <div class="p-img"><a href="phone_selectPhoneById?id=<%=phoneSales.get(4).getId()%>"><img src="<%=phoneSales.get(4).getIntroduction_img()%>"/></a></div>
				  <div class="p-price">￥<%=phoneSales.get(4).getPrice() %></div>
				  <div class="p-name"><a href=""><%=phoneSales.get(4).getName() %></a></div>
				  <div class="p-commit"><p>已有<span><%=phoneSales.get(4).getSales() %></span>人购买</p></div>
				  <div class="p-shop"><%=phoneSales.get(4).getShop() %></div>
			  </div>
			</div>
  		</div>
  		<div class="goods-new clearfix">
  			<div class="new-hd">
  				<h2 class="title">最新商品</h2>
  				<div class="more">
  					<%--<a href="">查看全部<i class="icon-circle-arrow-right" style="margin-left:10px"></i></a>--%>
  				</div>
  			</div>
  			<div class="new-1">
			  <div class="gl-i-wrap">
				  <div class="p-img"><a href="phone_selectPhoneById?id=<%=phoneDate.get(0).getId()%>"><img src="<%=phoneDate.get(0).getIntroduction_img()%>"/></a></div>
				  <div class="p-price">￥<%=phoneDate.get(0).getPrice() %></div>
				  <div class="p-name"><a href=""><%=phoneDate.get(0).getName() %></a></div>
				  <div class="p-commit"><p>已有<span><%=phoneDate.get(0).getSales() %></span>人购买</p></div>
				  <div class="p-shop"><%=phoneDate.get(0).getShop() %></div>
			  </div>
			</div>
  			<div class="new-2">
			  <div class="gl-i-wrap">
				  <div class="p-img"><a href="phone_selectPhoneById?id=<%=phoneDate.get(1).getId()%>"><img src="<%=phoneDate.get(1).getIntroduction_img()%>"/></a></div>
				  <div class="p-price">￥<%=phoneDate.get(1).getPrice() %></div>
				  <div class="p-name"><a href=""><%=phoneDate.get(1).getName() %></a></div>
				  <div class="p-commit"><p>已有<span><%=phoneDate.get(1).getSales() %></span>人购买</p></div>
				  <div class="p-shop"><%=phoneDate.get(1).getShop() %></div>
			  </div>
			</div>
  			<div class="new-3">
			  <div class="gl-i-wrap">
				  <div class="p-img"><a href="phone_selectPhoneById?id=<%=phoneDate.get(2).getId()%>"><img src="<%=phoneDate.get(2).getIntroduction_img()%>"/></a></div>
				  <div class="p-price">￥<%=phoneDate.get(2).getPrice() %></div>
				  <div class="p-name"><a href=""><%=phoneDate.get(2).getName() %></a></div>
				  <div class="p-commit"><p>已有<span><%=phoneDate.get(2).getSales() %></span>人购买</p></div>
				  <div class="p-shop"><%=phoneDate.get(2).getShop() %></div>
			  </div>
			</div>
  			<div class="new-4">
				  <div class="gl-i-wrap">
				  <div class="p-img"><a href="phone_selectPhoneById?id=<%=phoneDate.get(3).getId()%>"><img src="<%=phoneDate.get(3).getIntroduction_img()%>"/></a></div>
				  <div class="p-price">￥<%=phoneDate.get(3).getPrice() %></div>
				  <div class="p-name"><a href=""><%=phoneDate.get(3).getName() %></a></div>
				  <div class="p-commit"><p>已有<span><%=phoneDate.get(3).getSales() %></span>人购买</p></div>
				  <div class="p-shop"><%=phoneDate.get(3).getShop() %></div>
			  </div>
			</div>
  			<div class="new-5">
			  <div class="gl-i-wrap">
				  <div class="p-img"><a href="phone_selectPhoneById?id=<%=phoneDate.get(4).getId()%>"><img src="<%=phoneDate.get(4).getIntroduction_img()%>"/></a></div>
				  <div class="p-price">￥<%=phoneDate.get(4).getPrice() %></div>
				  <div class="p-name"><a href=""><%=phoneDate.get(4).getName() %></a></div>
				  <div class="p-commit"><p>已有<span><%=phoneDate.get(4).getSales() %></span>人购买</p></div>
				  <div class="p-shop"><%=phoneDate.get(4).getShop() %></div>
			  </div>
			</div>
  		</div>
  	</div>

  	<div class="footer">
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