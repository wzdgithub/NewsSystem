<%@ page import="com.bean.PageBean" %>
<%@ page import="com.bean.Comment" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="<%=path%>/common/css/adminTable.css"/>
</head>
<body>
<%
    PageBean commentPage = (PageBean) request.getAttribute("commentPage");
    List<Comment> comments = commentPage.getPageList();
%>
    <table>
        <tr><td>ID</td><td>用户名</td><td>评论内容</td><td>时间</td><td>删除</td></tr>
        <%for (Comment comment:comments){%>
        <tr>
            <td><%=comment.getId()%></td>
            <td><%=comment.getUsername()%></td>
            <td><%=comment.getContent()%></td>
            <td><%=comment.getDate()%></td>
            <td><a href="comment_deleteComment?id=<%=comment.getId()%>&userid=-1">删除</a></td>
        </tr>
        <%}%>
    </table>
    <div class="page" style="margin-left: 400px;">
        <%if (commentPage.getCurrentPage() > 1){%>
        <a href="comment_selectComment?currentPage=<%=commentPage.getCurrentPage()-1%>">上一页</a>
        <%}%>
        <span><%=commentPage.getCurrentPage()%></span>/<span><%=commentPage.getTotalPage()%></span>
        <%if (commentPage.getCurrentPage() < commentPage.getTotalPage()){%>
        <a href="comment_selectComment?currentPage=<%=commentPage.getCurrentPage()+1%>">下一页</a>
        <%}%>
    </div>
</body>
</html>
