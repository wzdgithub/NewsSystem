<%@ page import="com.bean.PageBean" %>
<%@ page import="com.bean.News" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/4/10
  Time: 19:49
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
    <div style="margin-left: 20px;margin-top: 20px;"><span><a href="<%=path%>/admin/addNews.jsp">添加新闻</a></span></div>
    <%
        PageBean newsPageBean = (PageBean) session.getAttribute("NewsPageBeanByAdmin");
        List<News> newses = newsPageBean.getPageList();
    %>
    <table>
        <tr><td>ID</td><td>标题</td><td>作者</td><td>类型</td><td>日期</td><td>分数</td><td>删除操作</td><td>修改操作</td></tr>
        <%
            for (News news:newses){
        %>
        <tr>
            <td><%=news.getId()%></td>
            <td><%=news.getTitle()%></td>
            <td><%=news.getAuthor()%></td>
            <td><%=news.getCategory()%></td>
            <td><%=news.getDate()%></td>
            <%if(news.getCommentnum() == 0){%>
            <td>0</td>
            <%}else{%>
            <td><%=news.getScore()/news.getCommentnum()%></td>
            <%}%>
            <td><a href="news_deleteNews?id=<%=news.getId()%>">删除</a></td>
            <td><a href="<%=path%>/admin/modifyNews.jsp?id=<%=news.getId()%>">修改</a></td>
        </tr>
        <%}%>
    </table>
    <div style="text-align: center;margin: 20px;">
      <%if (newsPageBean.getCurrentPage() > 1){%>
      <a href="news_AllNewsByAdmin?currentPage=<%=newsPageBean.getCurrentPage()-1%>">上一页</a>
      <%}%>
      <span><%=newsPageBean.getCurrentPage()%></span>/<span><%=newsPageBean.getTotalPage()%></span>
      <%if (newsPageBean.getCurrentPage() < newsPageBean.getTotalPage()){%>
      <a href="news_AllNewsByAdmin?currentPage=<%=newsPageBean.getCurrentPage()+1%>">下一页</a>
      <%}%>
    </div>
</body>
</html>
