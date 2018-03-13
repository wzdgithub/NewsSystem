<%@ page import="com.bean.PageBean" %>
<%@ page import="com.bean.ShopCart" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bean.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
	<title>我的购物车</title>
	<meta charset="utf-8"/>
	<link rel="stylesheet" type="text/css" href="../common/css/home.css">
	<link rel="stylesheet" type="text/css" href="../common/css/font-awesome.min.css">
	<link rel="stylesheet" type="text/css" href="../common/css/personal.css">
    <link rel="stylesheet" type="text/css" href="../common/css/shopCart.css">
    <script src="../common/js/jquery-1.3.2.min.js"></script>
    <script type="text/javascript">
      	$(function(){
        	$(".mask").hide();
        	$(".open").click(function(){
				var userid = $(this).attr("userid");
				var icon = $(this).attr("icon");
				var shopname = $(this).attr("shopname");
				var price = $(this).attr("price");
				$("input[name='userid']").val(userid);
				$("input[name='icon']").val(icon);
				$("input[name='shopname']").val(shopname);
				$("input[name='price']").val(price);
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
  	PageBean shopCartPage = (PageBean) request.getAttribute("shopCartPage");
  	List<ShopCart> shopCarts = shopCartPage.getPageList();
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
                <h3>我的购物车</h3>
  				<table class="cart">
                    <tr class="cart-header"><td></td><td class="cart-name">商品名称</td><td>总价</td><td>状态</td><td>操作</td></tr>
					<%for (ShopCart shopCart:shopCarts){%>
                    <tr>
                        <td class="cart-img"><img src="<%="\\"+shopCart.getIcon()%>"></td>
                        <td class="cart-name">
                            <span><%=shopCart.getShopname()%></span>
                        </td>
                        <td><%=shopCart.getPrice()%></td>
                        <td class="open" userid="<%=shopCart.getUserid()%>" icon="<%=shopCart.getIcon()%>"
								shopname="<%=shopCart.getShopname()%>" price="<%=shopCart.getPrice()%>">结算</td>
                        <td><a href="shopCart_deleteShopCart?id=<%=shopCart.getId()%>">删除</a></td>
                    </tr>
					<%}%>
                </table>
				<div>
					<a href="">上一页</a>
					<span><%=shopCartPage.getCurrentPage()%></span>/<span><%=shopCartPage.getTotalPage()%></span>
					<a href="">下一页</a>
				</div>
  			</div>
  		</div>
  	</div>
    <div class="mask">
      	<div class="mask-container">
        	<div class="mask-content">
          		<p><i class="icon-remove"></i></p>
          		<form action="bill_insertBill" method="post">
					<input type="hidden" name="userid"/>
					<input type="hidden" name="icon"/>
					<input type="hidden" name="shopname"/>
					<input type="hidden" name="price"/>
			  		<label><input type="text" name="consignee" placeholder="请输入收货人"/></label>
				  	<label><input type="text" name="telephone" placeholder="请输入收货人电话号"/></label>
				  	<label><input type="text" name="address" placeholder="请输入收货人地址"/></label><br/>
				  	<input type="submit" value="确定">
				</form>
        	</div>
      	</div>
    </div>
</body>
</html>