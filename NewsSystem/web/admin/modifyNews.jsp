<%@ page import="com.bean.News" %>
<%@ page import="com.bean.PageBean" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/4/10
  Time: 21:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<html>
<head>
    <title></title>
    <script type="text/javascript" charset="utf-8" src="<%=path%>/common/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=path%>/common/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=path%>/common/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=path%>/common/js/jquery.js"></script>
    <style>
        form input[type="text"]{
            width: 200px;
            height: 25px;
            margin: 5px;
        }
    </style>
</head>
<body>
<%
    PageBean newsPageBean = (PageBean) session.getAttribute("NewsPageBeanByAdmin");
    List<News> newses = newsPageBean.getPageList();
    int id = Integer.parseInt(request.getParameter("id"));
    News news = null;
    for(News n:newses){
        if(n.getId() == id){
            news = n;
        }
    }
%>
<div class="content">
    <form action="news_updateNewsPic" method="post" enctype="multipart/form-data">
        <lable>展示图片：</lable>
        <input type="hidden" name="id" value="<%=news.getId()%>"/>
        <input type="file" name="pic"/><br/>
        <input type="submit" value="保存"/>
    </form>

    <form action="news_updateNews" method="post">
        <input type="hidden" name="id" value="<%=news.getId()%>"/>
        <lable>新闻标题：</lable>
        <input type="text" name="title" value="<%=news.getTitle()%>"/><br/>
        <lable>新闻作者：</lable>
        <input type="text" name="author" value="<%=news.getAuthor()%>"/><br/>
        <lable>新闻内容：</lable>
        <script id="editor" type="text/plain" name="content" style="width:960px;height:100px;"><%=news.getContent()%></script><br/>
        <lable>新闻类别：</lable>
        <input type="text" name="category" value="<%=news.getCategory()%>"/><br/>
        <lable>新闻时间：</lable>
        <input type="date" name="date" value="<%=news.getDate()%>"/><br/>
        <input type="submit" value="修改"/>
    </form>
</div>
<script type="text/javascript">
    var ue = UE.getEditor('editor', {
        toolbars: [
            ['forecolor', 'backcolor', 'undo', 'redo', 'bold']
        ]
    });
</script>
</body>
</html>
