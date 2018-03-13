<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bean.Message" %>
<%@ page import="com.bean.FriendGroup" %>
<%@ page import="com.bean.User" %><%--
  Created by IntelliJ IDEA.
  User: ZhenDong
  Date: 2017/4/30
  Time: 11:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>通知中心</title>
    <link rel="stylesheet" href="/module/commons/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/module/home/css/index.css">
    <link rel="stylesheet" href="/module/commons/css/popup.css">

    <script type="application/javascript" src="/module/commons/js/jquery-3.2.1.min.js"></script>
    <script type="application/javascript" src="/module/commons/bootstrap/js/bootstrap.min.js"></script>
    <script type="application/javascript" src="/module/commons/js/popup.js"></script>
</head>
<body>
<%
    List<Message> messages = (List<Message>) session.getAttribute("messages");
    int messageLen = messages.size();
    List<FriendGroup> friendGroups = (List<FriendGroup>) session.getAttribute("friendGroups");
    int fglen = friendGroups.size();
%>
<c:set var="user" value="${sessionScope.user}" />
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
                <h3 class="panel-title">所有通知</h3>
            </div>
            <div class="panel-body">
                <table class="table table-hover">
                    <tr>
                        <th>#</th>
                        <th>消息类型</th>
                        <th>消息内容</th>
                        <th>时间</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                    <%for (int i = 0;i<messageLen;i++){%>
                    <tr>
                        <td><%=i+1%></td>
                        <td><%=messages.get(i).getCategory()%></td>
                        <td><%=messages.get(i).getContent()%></td>
                        <td><%=messages.get(i).getDate()%></td>
                        <td><%=messages.get(i).getType()%></td>
                        <td>
                            <%if(messages.get(i).getType().equals("未读")){%>
                                <span class="agree" style="cursor:hand;" rootId="<%=messages.get(i).getRootId()%>" sourceId="<%=messages.get(i).getSourceId()%>" fgId1="<%=messages.get(i).getExtend()%>">同意</span>
                            <%}else{%>
                                已同意
                            <%}%>
                        </td>
                    </tr>
                    <%}%>
                </table>
            </div>
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
<script>
    $(function () {
        $(".logout").click(function(){
            $(location).attr('href', '/logout.action');
        })

        var rootId;
        var sourceId;
        var fgId1;
        $(".agree").click(function () {
            rootId = $(this).attr("rootId");
            sourceId = $(this).attr("sourceId");
            fgId1 = $(this).attr("fgId1");
            $(".popup").show();
        })
        
        $(".popup-submit").click(function () {
            var fgId2 = $(".popup-select").val();
            $(location).attr('href',"/agreeAddFriend.action?rootId="+rootId+"&sourceId="+sourceId+"&" +
                    "fgId1="+fgId1+"&fgId2="+fgId2);
            $(".popup").hide();
        })

    })
</script>
</body>
</html>
