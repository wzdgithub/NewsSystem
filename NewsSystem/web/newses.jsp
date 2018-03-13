<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@page import="com.bean.News" %>
<%@ page import="com.bean.User" %>
<%@ page import="com.bean.PageBean" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>新闻</title>
    <link rel="stylesheet" type="text/css" href="common/css/home.css">
    <link rel="stylesheet" type="text/css" href="common/css/newses.css">
</head>

<body>
    <%
        User user = null;
        user = (User) session.getAttribute("user");

        PageBean newsPageBean = (PageBean) request.getAttribute("NewsPageBean");
        List<News> newses = newsPageBean.getPageList();

        List<News> newsScore = (List<News>) request.getAttribute("newsScore");

        String category = (String) request.getAttribute("category");
        String title = (String) request.getAttribute("title");
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
    <div class="content clearfix" style="margin-bottom: 60px;">
        <div class="content_left" style="padding-bottom: 20px;">
            <div class="clhd" style="margin-bottom: 10px;"><span style="color: #fff;margin-left: 105px;">新闻评分排行榜</span></div>
            <div class="cl_content">
                <ul style="list-style-type: none;">
                    <%
                        int i = 1;
                        for (News news:newsScore){
                    %>
                    <li>
                        <div style="display:inline-block;width: 250px;height:20px;overflow: hidden;"><a href="news_selectNews?id=<%=news.getId()%>" style="color: #000;"><span style="color: red;"><%=i++%>. </span><%=news.getTitle()%></a></div>
                        <%if (news.getCommentnum() != 0){%>
                        <span style=""><%=news.getScore()/news.getCommentnum()%>分</span>
                        <%}else{%>
                        <span style="">0分</span>
                        <%}%>
                    </li>
                    <%}%>
                </ul>
            </div>
        </div>
        <div class="content_right">
            <div class="crhd"><span style="color: #fff;margin-left: 30px;"><%=category%></span></div>
            <div class="cr_content">
                <ul>
                    <%for (News news:newses){%>
                    <li><a href="news_selectNews?id=<%=news.getId()%>"><%=news.getTitle()%></a></li>
                    <%}%>
                </ul>
            </div>
            <%if (category.equals("查询结果")){%>
            <div class="page" style="text-align: center;">
                <%if (newsPageBean.getCurrentPage() > 1){%>
                <a href="news_selectNewsByTitle?currentPage=<%=newsPageBean.getCurrentPage()-1%>&title=<%=title%>">上一页</a>
                <%}%>
                <span><%=newsPageBean.getCurrentPage()%></span>/<span><%=newsPageBean.getTotalPage()%></span>
                <%if (newsPageBean.getCurrentPage() < newsPageBean.getTotalPage()){%>
                <a href="news_selectNewsByTitle?currentPage=<%=newsPageBean.getCurrentPage()+1%>&title=<%=title%>">下一页</a>
                <%}%>
            </div>
            <%}else{%>
            <div class="page" style="text-align: center;">
                <%if (newsPageBean.getCurrentPage() > 1){%>
                <a href="news_selectNewsByCategory?currentPage=<%=newsPageBean.getCurrentPage()-1%>&category=<%=category%>">上一页</a>
                <%}%>
                <span><%=newsPageBean.getCurrentPage()%></span>/<span><%=newsPageBean.getTotalPage()%></span>
                <%if (newsPageBean.getCurrentPage() < newsPageBean.getTotalPage()){%>
                <a href="news_selectNewsByCategory?currentPage=<%=newsPageBean.getCurrentPage()+1%>&category=<%=category%>">下一页</a>
                <%}%>
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
