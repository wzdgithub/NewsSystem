<%@ page import="java.util.List" %>
<%@ page import="com.bean.Feedback" %>
<%@ page import="com.bean.PageBean" %>

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
        <a href="feedback_selectFeedback?currentPage=<%=feedbackPage.getCurrentPage()-1%>">上一页</a>
        <%}%>
        <span><%=feedbackPage.getCurrentPage()%></span>/<span><%=feedbackPage.getTotalPage()%></span>
        <%if (feedbackPage.getCurrentPage() < feedbackPage.getTotalPage()){%>
        <a href="feedback_selectFeedback?currentPage=<%=feedbackPage.getCurrentPage()+1%>">下一页</a>
        <%}%>
    </div>
</body>
</html>
