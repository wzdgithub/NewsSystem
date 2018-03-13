<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bean.Friend" %>
<%@ page import="com.bean.User" %>
<%@ page import="com.bean.FriendGroup" %><%--
  Created by IntelliJ IDEA.
  User: ZhenDong
  Date: 2017/4/28
  Time: 18:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>查找朋友</title>
    <link rel="stylesheet" href="/module/commons/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/module/home/css/index.css">
    <link rel="stylesheet" href="/module/user/css/info.css">
    <link rel="stylesheet" href="/module/commons/css/popup.css">

    <script type="application/javascript" src="/module/commons/js/jquery-3.2.1.min.js"></script>
    <script type="application/javascript" src="/module/commons/bootstrap/js/bootstrap.min.js"></script>
    <script type="application/javascript" src="/module/commons/js/popup.js"></script>
</head>
<body>
<c:set var="user" value="${sessionScope.user}" />
<%
    List<FriendGroup> friendGroups = (List<FriendGroup>) session.getAttribute("friendGroups");
    List<User> users = (List<User>) session.getAttribute("users");
    String userName = (String) session.getAttribute("userName");
    int len = users.size();
    int fglen = friendGroups.size();
%>
<%
    User uu = (User) session.getAttribute("user");
    if(uu==null)
        response.sendRedirect("/module/user/login.jsp");
%>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="navbar-header">
            <a class="navbar-brand" href="/module/home/index.jsp">校园社交</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <form action="/selectFriendByName.action" class="navbar-form navbar-left" method="post">
                <div class="input-group">
                    <input type="hidden" name="pageNum" value="0">
                    <input type="hidden" name="userId" value="${user.id}">
                    <input type="text" name="userName" class="form-control" placeholder="Search for...">
                    <span class="input-group-btn">
                        <button class="btn btn-group-lg" type="submit">查找好友</button>
                    </span>
                </div><!-- /input-group -->
            </form>

            <ul class="nav navbar-nav navbar-left">
                <li>
                    <a class="bar-a" href="/module/user/information.jsp"><span class="glyphicon glyphicon-user"></span>&nbsp;个人中心</a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-left">
                <li>
                    <a class="bar-a" href="/module/photoAlbum/album.jsp"><span class="glyphicon glyphicon-picture"></span>&nbsp;我的相册</a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-left">
                <li>
                    <a class="bar-a" href="/module/question/index.jsp"><span class="glyphicon glyphicon-question-sign"></span>&nbsp;知识问答</a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-left">
                <li>
                    <a class="bar-a" href="/selectLeaveMessage.action?userId=${user.id}"><span class="glyphicon glyphicon-envelope"></span>&nbsp;留言板</a>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">欢迎：<c:out value="${user.username}"/> &nbsp;&nbsp;<span class="glyphicon glyphicon-off logout"></span></a></li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
    <div class="row">
        <div class="col-md-2 sidebar"></div>
        <div class="col-md-8 main-content panel panel-default" style="background-color: #fff;padding: 0;">
            <div class="panel-heading">
                <h3 class="panel-title">搜索到的好友</h3>
            </div>
            <div class="friends-list panel-body">
                <%
                    for (User u : users){
                %>
                <div style="margin:5px;padding: 5px;border: 1px solid #ccc;">
                    <div class="media">
                        <div class="media-left">
                            <a href="#">
                                <img class="media-object" data-src="holder.js/64x64" alt="80x80" src="http://localhost:8080<%=u.getIcon()%>" data-holder-rendered="true" style="width: 80px; height: 80px;">
                            </a>
                        </div>
                        <div class="media-body">
                            <h4><%=u.getUsername()%> <a style="float: right;"><span uid="<%=u.getId()%>" onclick='addFirend(this)' class="add-friend glyphicon glyphicon-plus" style="margin-right: 10px;"></span></a></h4>
                            <%=u.getAutograph()%>
                        </div>
                    </div>
                </div>
                <%}%>
            </div>

            <%--<%if (users.size()==15){%>--%>
            <button class="btn btn-primary sfriend-but" style="width: 100%;margin-top: 15px;">加载更多..</button>
            <%--<%}%>--%>
        </div>
        <div class="col-md-2 sidebar"></div>
    </div>
</div>
<div class="popup">
    <div class="popup-content">
        <div class="popup-title">
            <h4>选择分组</h4>
        </div>
        <div class="popup-body">
            <select class="form-control popup-select" name="" id="">
                <option value="0">默认分组</option>
                <%for (int i=0;i<fglen;i++){%>
                <option value="<%=friendGroups.get(i).getId()%>"><%=friendGroups.get(i).getGroupName()%></option>
                <%}%>
            </select>
        </div>
        <div class="popup-footer">
            <button type="button" class="popup-close btn btn-default" data-dismiss="modal">Close</button>
            <button type="submit" class="popup-submit btn btn-primary">Add</button>
        </div>
    </div>
</div>
</select>
<script>
    $(function () {
        $(".logout").click(function(){
            $(location).attr('href', '/logout.action');
        })

        var pageNum = 0;
        var users;
        var len = <%=len%>;
        $(".sfriend-but").click(function () {
            if(len==15) {
                pageNum += 15;
                $.ajax({
                    type: "POST",
                    async: false,
                    url: "/ajaxSearchName.action",
                    dataType: 'json',
                    data: {
                        userName: '<%=userName%>',
                        pageNum: pageNum,
                        userId:${user.id}
                    },
                    success: function (data) {
                        users = data;
                        len = data.length;
                    }
                })
                for (var u in users) {
                    $(".friends-list").append("" +
                            "<div style='margin:5px;padding: 5px;border: 1px solid #ccc;'>" +
                            "<div class='media'>" +
                            "<div class='media-left'> " +
                            "<a href='#'>" +
                            "<img class='media-object' data-src='holder.js/64x64' alt='80x80' src='http://localhost:8080" + users[u].icon + "' data-holder-rendered='true' style='width: 80px; height: 80px;'></a>" +
                            "</div><div class='media-body'>" +
                            "<h4>" + users[u].username + "<a style='float: right;'><span uid='"+users[u].id+"' onclick='addFirend(this)' class='glyphicon glyphicon-plus' style='margin-right: 10px;'></span></a></h4>" + users[u].autograph +
                            "</div>" +
                            "</div>" +
                            "</div>" +
                            "");
                }
            }
        })


    })
    var uid;
    var addFirend = function (e) {
        uid = $(e).attr("uid");
        $(".popup").show();
    }
    $(function () {
        $(".popup-submit").click(function(){
            var fgId = $(".popup-select").val();
            $.ajax({
                type: "POST",
                async: true,
                url: "/insertMessage.action",
                dataType: 'json',
                data: {
                    sourceId: ${user.id},
                    rootId: uid,
                    userName:'${user.username}',
                    extend:fgId,
                },
                success: function (data) {
                    if(data==1){
                        alert("添加好友成功等待对方确认");
                    }else if(data == -1){
                        alert("已经发送过请求等待对方确认");
                    }else{
                        alert("添加好友失败");
                    }
                }
            })
            $(".popup").hide();
        })
    })
</script>
</body>
</html>