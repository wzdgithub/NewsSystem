<%@ page import="com.bean.PageBean" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bean.User" %>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/3/22
  Time: 19:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<html>
<head>
    <title></title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=path%>/common/css/adminTable.css"/>
</head>
<%
    PageBean userPage = (PageBean) request.getAttribute("userPage");
    List<User> users = userPage.getPageList();
%>
<body>
    <table>
        <tr><td>ID</td><td>用户名</td><td>电子邮件</td><td>姓名</td><td>性别</td><td>电话号</td><td>删除</td></tr>
        <%for (User user:users){%>
        <tr>
            <td><%=user.getId()%></td>
            <td><%=user.getUsername()%></td>
            <td><%=user.getEmail()%></td>
            <td><%=user.getName()%></td>
            <td><%=user.getSex()%></td>
            <td><%=user.getTelephone()%></td>
            <td><a href="user_deleteUser?id=<%=user.getId()%>">删除</a></td>
        </tr>
        <%}%>
    </table>
    <div class="page" style="margin-left: 600px;">
        <%if (userPage.getCurrentPage() > 1){%>
        <a href="user_selectUser?currentPage=<%=userPage.getCurrentPage()-1%>">上一页</a>
        <%}%>
        <span><%=userPage.getCurrentPage()%></span>/<span><%=userPage.getTotalPage()%></span>
        <%if (userPage.getCurrentPage() < userPage.getTotalPage()){%>
        <a href="user_selectUser?currentPage=<%=userPage.getCurrentPage()+1%>">下一页</a>
        <%}%>
    </div>
</body>
</html>
