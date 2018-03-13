<%@ page import="com.bean.PageBean" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bean.Comment" %>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/4/11
  Time: 23:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="<%=path%>/common/css/adminTable.css"/>
</head>
<body>
<%
    PageBean commentPageBean = (PageBean) request.getAttribute("commentPageBean");
    List<Comment> comments = commentPageBean.getPageList();
%>
<table>
    <tr><td>用户名</td><td>评论内容</td><td>评论时间</td><td>审核状态</td><td>删除</td><td>审核</td></tr>
    <%for (Comment comment : comments){%>
    <tr>
        <td><%=comment.getUsername()%></td>
        <td><%=comment.getContent()%></td>
        <td><%=comment.getDate()%></td>
        <td><%=comment.isVisible()%></td>
        <td><a href="comment_deleteComment?id=<%=comment.getId()%>">删除</a></td>
        <%if (comment.isVisible()){%>
        <td><a href="comment_commentNoPass?id=<%=comment.getId()%>">通过</a></td>
        <%}else{%>
        <td><a href="comment_commentPass?id=<%=comment.getId()%>">未通过</a></td>
        <%}%>
    </tr>
    <%}%>
</table>
<div style="text-align: center;margin: 20px;">
  <%if (commentPageBean.getCurrentPage() > 1){%>
  <a href="comment_allCommentByAdmin?currentPage=<%=commentPageBean.getCurrentPage()-1%>">上一页</a>
  <%}%>
  <span><%=commentPageBean.getCurrentPage()%></span>/<span><%=commentPageBean.getTotalPage()%></span>
  <%if (commentPageBean.getCurrentPage() < commentPageBean.getTotalPage()){%>
  <a href="comment_allCommentByAdmin?currentPage=<%=commentPageBean.getCurrentPage()+1%>">下一页</a>
  <%}%>
</div>
</body>
</html>
