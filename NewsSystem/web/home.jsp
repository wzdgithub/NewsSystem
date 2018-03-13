<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@page import="com.bean.News" %>
<%@ page import="com.bean.User" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>My JSP 'index.jsp' starting page</title>
    <link rel="stylesheet" type="text/css" href="common/css/home.css">
    <link rel="stylesheet" type="text/css" href="common/css/unslider.css">
    <script src="common/js/jquery.js"></script>
    <script src="common/js/home.js"></script>
</head>
<%
    List<News> military = (List<News>) request.getAttribute("military"); //军事
    List<News> social = (List<News>) request.getAttribute("social"); //社会
    List<News> economic = (List<News>) request.getAttribute("economic"); //经济
    List<News> technology = (List<News>) request.getAttribute("technology"); //科技
    List<News> sports = (List<News>) request.getAttribute("sports"); // 体育
    List<News> entertain = (List<News>) request.getAttribute("entertain"); //娱乐

    User user = null;
    user = (User) session.getAttribute("user");
%>
<body>
<%if (user != null){%>
<div class="message" style="width: 40px;height: 40px;border: 1px solid #ccc;position: fixed;
right: 0px;top: 40%;background: #f7f7f7;text-align: center;line-height: 40px;">
    <a href="feedback.jsp">留言</a>
</div>
<%}%>
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
        <div class="login"><a href="<%=path%>/personal.jsp"><%=user.getUsername()%>
        </a></div>
        <%}%>
    </div>
</div>
<div class="viwepager">
    <div class="viwepager_img">
        <ul>
            <li><a href="news_selectNews?id=76"><img src="common/picture/1.jpg"/></a></li>
            <li><a href="news_selectNews?id=77"><img src="common/picture/2.jpg"/></a></li>
            <li><a href="news_selectNews?id=78"><img src="common/picture/3.jpg"/></a></li>
            <li><a href="news_selectNews?id=79"><img src="common/picture/4.jpg"/></a></li>
        </ul>
    </div>
</div>
<script src="<%=path%>/common/js/unslider.js"></script>
<script>
    $(function() {
        $('.viwepager_img').unslider({
            autoplay:true
        });
    })
</script>
<style>
    .unslider-nav {
        display: none;
    }
    .unslider-arrow{
        display: none;
    }
</style>
<div class="content clearfix">
    <div class="content_part1">
        <div class="part_header"><span>军事</span><span class="more"><a href="news_selectNewsByCategory?category=军事">more</a></span></div>
        <%if (military.size() != 0) {%>
        <div class="part_content">
            <ul>
                <%for (News news : military) {%>
                <li><a href="news_selectNews?id=<%=news.getId() %>"><%=news.getTitle() %>
                </a></li>
                <%} %>
            </ul>
        </div>
        <%}%>
    </div>
    <div class="content_part2">
        <div class="part_header"><span>社会</span><span class="more"><a href="news_selectNewsByCategory?category=社会">more</a></span></div>
        <%if (social.size() != 0) {%>
        <div class="part_content">
            <ul>
                <%for (News news : social) {%>
                <li><a href="news_selectNews?id=<%=news.getId() %>"><%=news.getTitle() %>
                </a></li>
                <%} %>
            </ul>
        </div>
        <%}%>
    </div>
    <div class="content_part3">
        <div class="part_header"><span>财经</span><span class="more"><a href="news_selectNewsByCategory?category=财经">more</a></span></div>
        <%if (economic.size() != 0) {%>
        <div class="part_content">
            <ul>
                <%for (News news : economic) {%>
                <li><a href="news_selectNews?id=<%=news.getId() %>"><%=news.getTitle() %>
                </a></li>
                <%} %>
            </ul>
        </div>
        <%}%>
    </div>
    <div class="content_part4">
        <div class="part_header"><span>科技</span><span class="more"><a href="news_selectNewsByCategory?category=科技">more</a></span></div>
        <%if (technology.size() != 0) {%>
        <div class="part_content">
            <ul>
                <%for (News news : technology) {%>
                <li><a href="news_selectNews?id=<%=news.getId() %>"><%=news.getTitle() %>
                </a></li>
                <%} %>
            </ul>
        </div>
        <%}%>
    </div>
    <div class="content_part5">
        <div class="part_header"><span>体育</span><span class="more"><a href="news_selectNewsByCategory?category=体育">more</a></span></div>
        <%if (sports.size() != 0) {%>
        <div class="part_content">
            <ul>
                <%for (News news : sports) {%>
                <li><a href="news_selectNews?id=<%=news.getId() %>"><%=news.getTitle() %>
                </a></li>
                <%} %>
            </ul>
        </div>
        <%}%>
    </div>
    <div class="content_part6">
        <div class="part_header"><span>娱乐</span><span class="more"><a href="news_selectNewsByCategory?category=娱乐">more</a></span></div>
        <%if (entertain.size() != 0) {%>
        <div class="part_content">
            <ul>
                <%for (News news : entertain) {%>
                <li><a href="news_selectNews?id=<%=news.getId() %>"><%=news.getTitle() %>
                </a></li>
                <%}%>
            </ul>
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
</html>
