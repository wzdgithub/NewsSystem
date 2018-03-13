<%@ page import="com.bean.PageBean" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bean.Comment" %>
<%@ page import="com.bean.Score" %>
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
    PageBean commentPageBean = (PageBean) request.getAttribute("ScorePageBean");
    List<Score> scores = commentPageBean.getPageList();
%>
<table>
    <tr>
        <td>用户名</td>
        <td>评论分数</td>
        <td>评分的帖子标题</td>
        <td>删除</td>
    </tr>
    <%for (Score score : scores) {%>
    <tr>
        <td><%=score.getUsername()%>
        </td>
        <td><%=score.getScore()%>
        </td>
        <td><%=score.getNewstitle()%>
        </td>
        <td>
            <a href="score_deleteScore?id=<%=score.getId()%>&score=<%=score.getScore()%>&newsid=<%=score.getNewsid()%>&userid=<%=score.getUserid()%>">删除</a>
        </td>
    </tr>
    <%}%>
</table>
<div style="margin-left: 350px;margin-top: 20px;">
    <%if (commentPageBean.getCurrentPage() > 1) {%>
    <a href="score_selectScore?currentPage=<%=commentPageBean.getCurrentPage()-1%>">上一页</a>
    <%}%>
    <span><%=commentPageBean.getCurrentPage()%></span>/<span><%=commentPageBean.getTotalPage()%></span>
    <%if (commentPageBean.getCurrentPage() < commentPageBean.getTotalPage()) {%>
    <a href="score_selectScore?currentPage=<%=commentPageBean.getCurrentPage()+1%>">下一页</a>
    <%}%>
</div>
</body>
</html>
