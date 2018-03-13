<%@ page import="com.bean.Phone" %>
<%@ page import="com.bean.User" %>
<%@ page import="com.bean.PageBean" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bean.Comment" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
	<title></title>
	<meta charset="utf-8"/>
	<link rel="stylesheet" type="text/css" href="common/css/home.css">
	<link rel="stylesheet" type="text/css" href="common/css/phone.css">
	<link rel="stylesheet" type="text/css" href="common/css/font-awesome.min.css">
	<script src="../common/js/jquery-1.3.2.min.js"></script>
	<script type="text/javascript">
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

	Phone phone = (Phone) request.getAttribute("phone");
	PageBean commentPage = (PageBean) request.getAttribute("commentPage");
	List<Comment> comments = commentPage.getPageList();
%>
<body style="background: #f5f5f5;">
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

  	<div class="site-header" style="background: #fff;">
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

  	<div class="phone-container">
  		<div class="phone-intro clearfix" style="margin-bottom: 40px;">
  			<div class="phone-img">
			<img src="<%=phone.getPreview_img()%>"/>
  				<div class="phone-img-shop"><%=phone.getShop()%></div>
  			</div>
  			<div class="phone-inf">
  				<div class="phone-inf-title"><p><%=phone.getName()%></p></div>
  				<div class="phone-inf-price"><span class="price">￥<%=phone.getPrice()%></span><span class="comment-count">已有<%=phone.getSales()%>购买</span></div>
  				<div class="phone-inf-details">
  					<table>
  						<tr><td class="tdTitle">品牌</td><td><%=phone.getBrand()%></td></tr>
  						<tr><td class="tdTitle">型号</td><td><%=phone.getModel()%></td></tr>
  						<tr><td class="tdTitle">颜色</td><td><%=phone.getColor()%></td></tr>
  						<tr><td class="tdTitle">CPU</td><td><%=phone.getCpu()%></td></tr>
  						<tr><td class="tdTitle">运行内存</td><td><%=phone.getInternal_storage()%></td></tr>
  						<tr><td class="tdTitle">机身内存</td><td><%=phone.getExternal_storage()%></td></tr>
  						<tr><td class="tdTitle">屏幕尺寸</td><td><%=phone.getScreen_size()%></td></tr>
  						<tr><td class="tdTitle">分辨率</td><td><%=phone.getResolution_ratio()%></td></tr>
  						<tr><td class="tdTitle">后置摄像头</td><td><%=phone.getLater_camera()%></td></tr>
  						<tr><td class="tdTitle">前置摄像头</td><td><%=phone.getBefore_camera()%></td></tr>
  					</table>
  				</div>

  				<div class="phone-inf-btn">
					<% if (user != null){%>
					<form action="shopCart_insertShopCart" method="post">
						<input type="hidden" name="userid" value="<%=user.getId()%>">
						<input type="hidden" name="icon" value="<%=phone.getIntroduction_img()%>">
						<input type="hidden" name="shopname" value="<%=phone.getName()%>">
						<input type="hidden" name="price" value="<%=phone.getPrice()%>">
						<input class="btn-append" type="submit" value="加入购物车"/>
					</form>
					<span class="btn-append open">立即购买</span>
					<%}else{%>
					<a href="login.jsp" class="btn-append">加入购物车</a>
					<a href="login.jsp" class="btn-append">立即购买</a>
					<%}%>
  					
  				</div>
  			</div>
  		</div>

  		<div class="phone-comment" style="margin-bottom: 60px;">
			<%if (user!=null){%>
			<form action="comment_insertComment" method="post" class="clearfix">
				<input type="hidden" name="userid" value="<%=user.getId()%>"/>
				<input type="hidden" name="phoneid" value="<%=phone.getId()%>"/>
				<input type="hidden" name="username" value="<%=user.getUsername()%>"/>
				<input type="hidden" name="icon" value="<%=user.getIcon()%>"/>
				<textarea name="content" id="" cols="30" rows="10"></textarea>
				<input type="submit" value="评论"/>
			</form>
			<%}%>
			<%for (Comment comment:comments){%>
	  		<div class="comments">
				<div class="comments_content">
					<div class="comment clearfix">
				    	<img src="<%=comment.getIcon()%>"/>
				    	<div class="comment_inf">
				    		<div class="comment_title">
				    			<span><%=comment.getUsername()%></span><span class="comment_date"><%=comment.getDate()%></span>
								<%if (user!=null&&user.getId()==comment.getUserid()){%>
								<span><a href="comment_deleteComment?id=<%=comment.getId()%>&userid=<%=user.getId()%>&phoneid=<%=phone.getId()%>">删除</a></span>
								<%}%>
				    		</div>
				    		<div class="comment_content">
				    		<%=comment.getContent()%>
				    		</div>
				    	</div>
				    </div>
				</div>
			</div>
			<%}%>
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
	<div class="mask">
		<div class="mask-container">
			<div class="mask-content">
				<p><i class="icon-remove"></i></p>
				<form action="bill_insertBill" method="post">
					<input type="hidden" name="phoneid" value="<%=phone.getId()%>"/>
					<%if (user != null){%>
					<input type="hidden" name="userid" value="<%=user.getId()%>"/>
					<%}%>
					<input type="hidden" name="icon" value="<%=phone.getIntroduction_img()%>"/>
					<input type="hidden" name="shopname" value="<%=phone.getName()%>"/>
					<input type="hidden" name="price" value="<%=phone.getPrice()%>"/>
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