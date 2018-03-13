<%@ page import="com.bean.Question" %>
<%@ page import="com.bean.User" %><%--
  Created by IntelliJ IDEA.
  User: ZhenDong
  Date: 2017/4/30
  Time: 21:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>问题详情</title>
    <link rel="stylesheet" href="/module/commons/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/module/home/css/index.css">
    <link rel="stylesheet" href="/module/commons/css/jquery-confirm.min.css">
    <link rel="stylesheet" href="/module/commons/fileinput/css/fileinput.min.css">
    <link rel="stylesheet" href="/module/question/css/content.css">


    <script type="application/javascript" src="/module/commons/js/jquery-3.2.1.min.js"></script>
    <script type="application/javascript" src="/module/commons/bootstrap/js/bootstrap.min.js"></script>
    <script type="application/javascript" src="/module/commons/js/jquery-confirm.min.js"></script>

    <script type="application/javascript" src="/module/commons/fileinput/js/fileinput.min.js"></script>
    <script type="application/javascript" src="/module/commons/fileinput/js/locales/zh.js"></script>
</head>
<body>
<%
    Question question = (Question) session.getAttribute("question");
    String username = (String) session.getAttribute("username");
    User user = (User) session.getAttribute("user");
    if(user==null)
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
<div class="container ques-container">
    <div class="row ques-content panel panel-default">
        <aside class="col-md-2 sidebar"></aside>
        <main class="col-md-8 main-content">
            <div class="ques-title">
                <h4><%=question.getTitle()%></h4>
            </div>
            <div class="ques-detail">
                <%=question.getDetail()%>
                <div><%=question.getImg()%></div>
                <p>
                    <span><%=username%></span><span><%=question.getDate()%></span>
                    <%if (question.getUserId()==user.getId())%>
                    <span><a href="/deleteQuestion.action?id=<%=question.getId()%>">删除</a></span>
                    <%%>
                    <a href="#re" class="btn btn-primary" style="float:right;">写回答</a>
                </p>
            </div>
        </main>
        <aside class="col-md-2 sidebar"></aside>
    </div>
    <div class="row">
        <aside class="col-md-2 sidebar"></aside>
        <main class="col-md-8 main-content answer-content">
            <div class="all-answer">
            </div>
            <button class="btn btn-default more-answer-but" style="width: 100%;margin-bottom: 15px;">加载更多回答..</button>


            <div class="write-answer panel panel-default">
                <div class="panel-heading">
                    <div class="panel-title">回答问题</div>
                </div>
                <form action="/insertAnswerPlus.action" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="userId" value="${user.id}">
                    <input type="hidden" name="questionId" value="<%=question.getId()%>">
                    <textarea class="form-control" name="content" id="" cols="30" rows="10"></textarea>
                    <div class="answer-btn">
                        <input id="file-answer" type="file" name="pics" multiple=true>
                        <div class="answer-sub">
                            <input type="submit" class="btn btn-success" value="回答">
                        </div>
                    </div>
                </form>
                <script>
                    $("#file-answer").fileinput({
                        language: 'zh',
                        allowedFileExtensions : ['jpg', 'png','gif'],
                        showUpload: false,
                        showCaption: false,
                    });
                </script>
            </div>
        </main>
        <aside class="col-md-2 sidebar"></aside>
    </div>
    <a id="re"></a>
</div>
</body>
<script>
    $(function () {
        $(".logout").click(function(){
            $(location).attr('href', '/logout.action');
        })
        var answerNum = 0;
        var answerPlusLen = 0;
        var $loadAnswer = function () {
            var answerPluses;

            $.ajax({
                type:"POST",
                async:false,
                url:"/showAnswerPlus.action",
                dataType:'json',
                data:{
                    questionId:<%=question.getId()%>,
                    answerNum:answerNum
                },
                success:function(data){
                    answerPluses = data;
                    answerPlusLen = answerPluses.length;
                }
            })

            for (var a in answerPluses){
                if(answerPluses[a].userId == <%=user.getId()%>){
                    $(".all-answer").append("" +
                            "<div class='answer panel panel-default'>" +
                            "<div class='media'>" +
                            "<div class='media-left'>" +
                            "<a href='#'>" +
                            "<img class='media-object' data-src='holder.js/40x40' alt='80x80' src='http://localhost:8080" + answerPluses[a].userIcon + "' data-holder-rendered='true' style='width: 40px; height: 40px;'>" +
                            "</a>" +
                            "</div>" +
                            "<div class='media-body'>" +
                            "<p style='margin-bottom: 5px' class='u-name'>" + answerPluses[a].userName + "</p>" +
                            "<p>" + answerPluses[a].date + "&nbsp;&nbsp;<span><a href='/deleteAnswer.action?id="+answerPluses[a].id+"'>删除</a></span></p>" +
                            "</div>" +
                            "</div>" +
                            "<div class='answer-text'>" +
                            answerPluses[a].content +
                            "<div>" + answerPluses[a].img + "</div>" +
                            "</div>" +
                            "</div>" +
                            "");
                }else {
                    $(".all-answer").append("" +
                            "<div class='answer panel panel-default'>" +
                            "<div class='media'>" +
                            "<div class='media-left'>" +
                            "<a href='#'>" +
                            "<img class='media-object' data-src='holder.js/40x40' alt='80x80' src='http://localhost:8080" + answerPluses[a].userIcon + "' data-holder-rendered='true' style='width: 40px; height: 40px;'>" +
                            "</a>" +
                            "</div>" +
                            "<div class='media-body'>" +
                            "<p style='margin-bottom: 5px' class='u-name'>" + answerPluses[a].userName + "</p>" +
                            "<p>" + answerPluses[a].date + "</p>" +
                            "</div>" +
                            "</div>" +
                            "<div class='answer-text'>" +
                            answerPluses[a].content +
                            "<div>" + answerPluses[a].img + "</div>" +
                            "</div>" +
                            "</div>" +
                            "");
                }
            }
        }

        $loadAnswer();

        $(".more-answer-but").click(function(){
            if (answerPlusLen==15){
                answerNum += 15;
                $loadAnswer();
            }
        })
    })
</script>
</html>
