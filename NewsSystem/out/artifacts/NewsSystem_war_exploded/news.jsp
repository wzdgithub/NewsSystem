<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@page import="com.bean.News" %>
<%@page import="com.bean.Comment" %>
<%@ page import="com.bean.User" %>
<%@ page import="com.bean.Score" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>My JSP 'news.jsp' starting page</title>
    <link rel="stylesheet" type="text/css" href="common/css/home.css">
    <link rel="stylesheet" type="text/css" href="common/css/news.css">
    <script type="text/javascript" charset="utf-8" src="common/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" charset="utf-8" src="common/js/jquery.js"></script>
</head>

<body>
<%
    News news = (News) request.getAttribute("news");
    List<Comment> comments = (List<Comment>) request.getAttribute("comments");
    User user = null;
    user = (User) session.getAttribute("user");
    List<Score> scores = (List<Score>) session.getAttribute("scores");
%>
<div class="header">
    <div class="header_center">
        <div class="header_logo">
            <a href="news_home">新闻管理系统</a>
        </div>
        <div class="header_menu">
            <ul>
                <a href="news_selectNewsByCategory?category=军事">
                    <li>军事</li>
                </a>
                <a href="news_selectNewsByCategory?category=社会">
                    <li>社会</li>
                </a>
                <a href="news_selectNewsByCategory?category=财经">
                    <li>财经</li>
                </a>
                <a href="news_selectNewsByCategory?category=科技">
                    <li>科技</li>
                </a>
                <a href="news_selectNewsByCategory?category=体育">
                    <li>体育</li>
                </a>
                <a href="news_selectNewsByCategory?category=娱乐">
                    <li>娱乐</li>
                </a>
            </ul>
        </div>
        <div class="header_search">
            <form action="news_selectNewsByTitle" method="post">
                <input type="text" class="search_title" name="title"/>
                <input type="submit" class="search_submit" value="搜索"/>
            </form>
        </div>
        <%
            if (user == null) {
        %>
        <div class="register"><a href="<%=path%>/register.jsp">注册</a></div>
        <div class="login"><a href="<%=path%>/login.jsp">登录</a></div>
        <%} else {%>
        <div class="register"><a href="user_loginOutUser">登出</a></div>
        <div class="login"><a href="<%=path%>/personal.jsp"><%=user.getUsername()%></a></div>
        </div>
        <%}%>
    </div>
</div>
<div class="content">
    <div class="news_title">
        <%=news.getTitle() %>
    </div>
    <div class="news_inf">
        <span>来源:<%=news.getAuthor() %></span><span>时间:<%=news.getDate() %></span>
        <%if (news.getCommentnum() == 0){%>
        <span>评分:0</span>
        <%}else{%>
        <span>评分:<%=news.getScore()/news.getCommentnum()%></span>
        <%}%>
    </div>
    <div class="news_content">
        <%if(!news.getPic().equals("images/null")){%>
        <div style="text-align: center;margin-bottom: 20px;">
            <img src="<%=news.getPic()%>" alt="" style="width: 600px;height: 400px;"/>
        </div>
        <%}%>
        <%=news.getContent() %>
    </div>
</div>
<div class="comments">
    <%
        if (user != null) {
    %>
    <div class="comment_editor clearfix">
        <form action="comment_insertComment" method="post" class="comment_form">
            <input type="hidden" name="userid" value="<%=user.getId()%>">
            <input type="hidden" name="newsid" value="<%=news.getId()%>"/>
            <input type="hidden" name="username" value="<%=user.getUsername()%>"/>
            <input type="hidden" name="icon" value="<%=user.getIcon()%>">
            <script id="editor" type="text/plain" name="content" style="width:960px;height:100px;"></script>
            <input type="submit" value="评论"/>
        </form>
        <%
            int q = 0;
            float s = 0;
            for (Score score : scores) {
                if (score.getNewsid() == news.getId()) {
                    q = 1;
                    s = score.getScore();
                }
            }
        %>
        <%if (q==1){%>
        <span style="display: inline-block;margin-top: 10px;">您已评分:<%=s%></span>
        <%}else{%>
        <form action="score_insertScore" method="post">
            <input type="hidden" name="userid" value="<%=user.getId()%>"/>
            <input type="hidden" name="username" value="<%=user.getUsername()%>"/>
            <input type="hidden" name="newsid" value="<%=news.getId()%>"/>
            <input type="hidden" name="newstitle" value="<%=news.getTitle()%>"/>
            <input type="text" name="score" style="width: 40px;height: 30px;margin-top: 10px;"/>
            <input type="submit" value="我要评分" style="width:60px;height: 30px;margin-top: 10px;"/>
        </form>
        <%}%>
    </div>
    <%}%>
    <div class="comments_content">
        <% for (Comment comment : comments) { %>
        <div class="comment clearfix">
            <img src="<%=path%>/<%=comment.getIcon()%>"/>

            <div class="comment_inf">
                <div class="comment_title">
                    <span><%=comment.getUsername() %></span><span class="comment_date"><%=comment.getDate() %></span>
                </div>
                <div class="comment_content">
                    <%=comment.getContent() %>
                </div>
            </div>
        </div>
        <%}%>
    </div>
</div>
<div class="foot">
    <div class="contact">
        <div>与我们联系</div>
        <div>
            <i class="icon-phone icon-large"></i>
            <span>000-0000-0000</span>
        </div>
        <div>
            <i class="icon-envelope-alt icon-large"></i>
            <span>123456@qwe.com</span>
        </div>
    </div>
</div>
</body>
<script type="text/javascript">
    var ue = UE.getEditor('editor', {
        toolbars: [
            ['forecolor', 'backcolor', 'undo', 'redo', 'bold']
        ]
    });
</script>
</html>
