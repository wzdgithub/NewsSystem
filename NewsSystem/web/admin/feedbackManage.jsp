<%@ page import="java.util.List" %>
<%@ page import="com.bean.Feedback" %>
<%@ page import="com.bean.PageBean" %>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/4/1
  Time: 21:27
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
        PageBean feedbackPage = (PageBean) request.getAttribute("feedbackPage");
        List<Feedback> feedbacks = feedbackPage.getPageList();
    %>
    <table>
        <tr><td>反馈用户ID</td><td>反馈内容</td><td>反馈时间</td><td>操作</td></tr>
        <%for (Feedback feedback:feedbacks){%>
        <tr><td><%=feedback.getUserid()%></td><td><%=feedback.getContent()%></td>
          <td><%=feedback.getDate()%></td><td><a href="feedback_deleteFeedback?id=<%=feedback.getId()%>">删除</a></td></tr>
        <%}%>
    </table>
    <div class="page"  style="margin-left: 350px;">
        <%if (feedbackPage.getCurrentPage() > 1){%>
        <a href="phone_selectPhone?currentPage=<%=feedbackPage.getCurrentPage()-1%>">上一页</a>
        <%}%>
        <span><%=feedbackPage.getCurrentPage()%></span>/<span><%=feedbackPage.getTotalPage()%></span>
        <%if (feedbackPage.getCurrentPage() < feedbackPage.getTotalPage()){%>
        <a href="phone_selectPhone?currentPage=<%=feedbackPage.getCurrentPage()+1%>">下一页</a>
        <%}%>
    </div>
</body>
</html>
