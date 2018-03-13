<%@ page import="com.bean.PageBean" %>
<%@ page import="com.bean.Bill" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bean.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% String path = request.getContextPath();%>
<!DOCTYPE html>
<html>
<head>
  <title>我的账单</title>
  <meta charset="utf-8"/>
  <link rel="stylesheet" type="text/css" href="../common/css/home.css">
  <link rel="stylesheet" type="text/css" href="../common/css/font-awesome.min.css">
  <link rel="stylesheet" type="text/css" href="../common/css/personal.css">
  <link rel="stylesheet" type="text/css" href="../common/css/personalBill.css">
</head>
<%
  User user = null;
  User u = (User) session.getAttribute("user");
  if(u != null){
    user = u;
  }
  PageBean billPage = (PageBean) request.getAttribute("billPage");
  List<Bill> bills = billPage.getPageList();
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
          <p><a href="<%=path %>/personal/personal.jsp">个人信息</a></p>
          <p><a href="shopCart_selectShopCart?userid=<%=user.getId()%>">我的购物车</a></p>
          <p><a href="bill_selectBill?userid=<%=user.getId() %>">我的账单</a></p>
        </div>
        <div class="personal-right">
          <h3>我的账单</h3>
          <table class="bill">
            <tr class="bill-header"><td></td><td class="bill-name">商品名称</td><td>总价</td><td>收货人</td><td>电话号</td><td>地址</td><td>操作</td></tr>  
            <%for (Bill bill:bills){%>
            <tr>
              <td class="bill-img"><img src="<%=path+"\\"+bill.getIcon()%>"></td>
              <td class="bill-name">
                <span><%=bill.getShopname()%></span>
              </td>
              <td><%=bill.getPrice()%></td>
              <td><%=bill.getConsignee()%></td>
              <td><%=bill.getTelephone()%></td>
              <td><%=bill.getAddress()%></td>
              <td><a href="bill_deleteBill?id=<%=bill.getId() %>">删除</a></td>
            </tr>
            <%}%>
          </table>
          <div>
            <a href="">上一页</a>
            <span><%=billPage.getCurrentPage()%></span>/<span><%=billPage.getTotalPage()%></span>
            <a href="">下一页</a>
          </div>
        </div>
      </div>
    </div>
</body>
</html>