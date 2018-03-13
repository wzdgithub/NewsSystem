<%@ page import="com.bean.User" %><%--
  Created by IntelliJ IDEA.
  User: ZhenDong
  Date: 2017/3/19
  Time: 11:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%String path = request.getContextPath();%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>知识问答</title>
    <link rel="stylesheet" href="/module/commons/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/module/home/css/index.css">
    <link rel="stylesheet" href="/module/commons/css/jquery-confirm.min.css">
    <link rel="stylesheet" href="/module/commons/fileinput/css/fileinput.min.css">
    <link rel="stylesheet" href="/module/question/css/question.css">


    <script type="application/javascript" src="/module/commons/js/jquery-3.2.1.min.js"></script>
    <script type="application/javascript" src="/module/commons/bootstrap/js/bootstrap.min.js"></script>
    <script type="application/javascript" src="/module/commons/js/jquery-confirm.min.js"></script>

    <script type="application/javascript" src="/module/commons/fileinput/js/fileinput.min.js"></script>
    <script type="application/javascript" src="/module/commons/fileinput/js/locales/zh.js"></script>


</head>
<body>
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

<section class="content-wrap">
    <div class="container">
        <div class="row">

            <aside class="col-md-2 sidebar">
            </aside>

            <main class="col-md-8 main-content panel panel-default" style="padding: 0;">
                <div class="panel-heading">
                    <div class="panel-title" style="height: 32px;line-height:32px;">问答中心<button class="btn btn-danger" style="float:right;" data-toggle="modal" data-target="#add-question">我要提问</button></div>
                </div>
                <div class="more-question">

                </div>
                <button class="btn btn-primary more-question-but" style="width: 100%;margin-top: 15px;">加载更多..</button>
            </main>
            <aside class="col-md-2 sidebar"></aside>
        </div>
    </div>
</section>

<div class="modal fade" id="add-question" tabindex="-1" role="dialog" aria-labelledby="addQuestionModalLabel">
    <div class="modal-dialog" role="document" style="width: 60%;height: auto;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addPhotoModalLabel">提交问题</h4>
            </div>
            <form action="/insertQuestion.action" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="form-group">
                        <input type="hidden" name="userId" value="${user.id}">
                        <label class="control-label">问题:</label>
                        <input type="text" name="title" class="form-control">
                        <label class="control-label">问题描述:</label>
                        <textarea name="detail" id="" cols="30" rows="10" class="form-control"></textarea>
                        <label class="control-label">上传照片:</label>
                        <input id="file-question" type="file" name="pics" multiple=true>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">提问</button>
                </div>
            </form>
            <script>
                $("#file-question").fileinput({
                    language: 'zh',
                    allowedFileExtensions : ['jpg', 'png','gif'],
                    showUpload: false,
                    showCaption: false,
                });
            </script>
        </div>
    </div>
</div>
</body>
<script>
    $(function () {
        $(".logout").click(function(){
            $(location).attr('href', '/logout.action');
        })

        var questionNum = 0;
        var questionPlusLen = 0;
        var $loadQuestion = function () {
            var questionPluses;

            $.ajax({
                type:"POST",
                async:false,
                url:"/showQuestionPlus.action",
                dataType:'json',
                data:{
                    questionNum:questionNum
                },
                success:function(data){
                    questionPluses = data;
                    questionPlusLen = questionPluses.length;
                }
            })

            for (var q in questionPluses){
                $(".more-question").append("" +
                        "<div class='media'>"+
                        "<div class='media-left'>"+
                        "<a href='#'>"+
                        "<img class='media-object' data-src='holder.js/64x64' alt='80x80' src='http://localhost:8080"+questionPluses[q].userIcon+"' data-holder-rendered='true' style='width: 80px; height: 80px;'>"+
                        "</a>"+
                        "</div>"+
                        "<div class='media-body'>"+
                        "<p>"+questionPluses[q].username+"</p>" +
                        "<a class='ques' href='/question.action?id="+questionPluses[q].id+"&username="+questionPluses[q].username+"'>"+
                        "<h4 class='question-title'>"+questionPluses[q].title+"</h4>"+
                        "<div class='question-detail'>"+
                        questionPluses[q].detail+
                        "</div>" +
                        "</a>"+
                        "</div>"+
                        "</div>" +
                        "");
            }
        }

        $loadQuestion();

        $(".more-question-but").click(function(){
            if (questionPlusLen==15){
                questionNum += 15;
                $loadQuestion();
            }
        })
    })
</script>
</html>
