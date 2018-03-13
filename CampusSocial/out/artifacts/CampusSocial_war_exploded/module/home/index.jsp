<%@ page import="com.bean.User" %>
<%@ page import="com.bean.Category" %>
<%@ page import="java.util.List" %><%--
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
    <title>Home</title>
    <link rel="stylesheet" href="/module/commons/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/module/home/css/index.css">
    <link rel="stylesheet" href="/module/commons/css/jquery-confirm.min.css">
    <link rel="stylesheet" href="/module/commons/fileinput/css/fileinput.min.css">
    <link rel="stylesheet" href="/module/commons/css/popup.css">


    <script type="application/javascript" src="/module/commons/js/jquery-3.2.1.min.js"></script>
    <script type="application/javascript" src="/module/commons/js/popup.js"></script>
    <script type="application/javascript" src="/module/commons/bootstrap/js/bootstrap.min.js"></script>
    <script type="application/javascript" src="/module/commons/js/jquery-confirm.min.js"></script>

    <script type="application/javascript" src="/module/commons/fileinput/js/fileinput.min.js"></script>
    <script type="application/javascript" src="/module/commons/fileinput/js/locales/zh.js"></script>


</head>
<body>
<c:set var="user" value="${sessionScope.user}" />
<%
    List<Category> categories = (List<Category>) session.getAttribute("categories");
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

            <aside class="col-md-3 sidebar">
                <div class="widget">
                    <div class="title"><span class="glyphicon glyphicon-list"></span>&nbsp;好友列表</div>
                    <div class="content community">

                        <div class="panel-group friend-groups" id="accordion" role="tablist" aria-multiselectable="true">

                            <div class='panel panel-default friend-group-default'>
                                <div class='panel-heading' role='tab' id='heading00'>
                                    <h4 class='panel-title'>
                                        <a role='button' data-toggle='collapse' data-parent='#accordion' href='#collapse00' aria-expanded='false' aria-controls='collapse00'>
                                            默认分组
                                        </a>
                                    </h4>
                                </div>

                                <div id='collapse00' class='panel-collapse collapse' role='tabpanel' aria-labelledby='heading00'>
                                    <div class='panel-body'>
                                        <ul style='padding-left: 0px;' class='friend-list00'>

                                        </ul>
                                    </div>
                                </div>
                            </div>


                        </div>

                        <button type="button" class="btn btn-primary add-group" data-toggle="modal" data-target="#exampleModal">添加分组</button>

                    </div>
                </div>
            </aside>

            <main class="col-md-6 main-content">
                <div class="send-post">
                    <form action="/addPost.action" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <input type="hidden" name="userId" value="<c:out value="${user.id}"/>">
                            <textarea name="content" class="form-control" style="margin-bottom: 15px;" maxlength="200"></textarea>
                            <div style="position: relative;">
                                <input id="file-pics" type="file" name="pics" multiple=true>
                                <select name="category" id="" class="send-select">
                                    <%for (Category c : categories){%>
                                    <option value="<%=c.getContent()%>"><%=c.getContent()%></option>
                                    <%}%>
                                    <option value="其他">其他</option>
                                </select>
                                <div class="send-sub">
                                    <input type="submit" class="btn btn-success" value="发帖">
                                </div>
                            </div>
                        </div>

                    </form>
                    <script>
                        $("#file-pics").fileinput({
                            language: 'zh',
                            allowedFileExtensions : ['jpg', 'png','gif'],
                            showUpload: false,
                            showCaption: false,
                        });
                    </script>
                </div>
                <article class="posts">

                </article>
                <div class="more-posts">
                    <button class="btn btn-primary more-post-but" style="width: 100%;margin-top: 15px;">加载更多..</button>
                </div>
            </main>

            <aside class="col-md-3 sidebar">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">通知中心
                            <span style="float: right;font-size: 14px;">
                                <a href="/messageList.action?userId=${user.id}&category=好友请求">全部</a>
                            </span>
                         </h3>
                    </div>
                    <div class="panel-body new-message">
                    </div>
                </div>
                <script>
                    $(function () {
                        $.ajax({
                            type: "POST",
                            async: false,
                            url: "/readMessage.action",
                            dataType: 'json',
                            data: {
                                userId: ${user.id},
                                category:"好友请求",
                                type:"未读",
                            },
                            success: function (data) {
                                for(var m in data) {
                                    $(".new-message").append("" +
                                            "<p>" +
                                            "<a href='/messageList.action?userId=${user.id}&category=好友请求' style='display:inline-block;width: 200px;height:20px;overflow: hidden;'>" +
                                            data[m].content +
                                            "</a>" +
                                            "<span style='float: right;'>" +
                                            data[m].type +
                                            "</span>" +
                                            "</p>" +
                                            "");
                                }
                            }
                        })
                    })
                </script>
            </aside>

        </div>
    </div>
</section>
<!-- 添加好友分组 -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">添加分组</h4>
            </div>
            <form action="/addFriendGroup.action" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">分组名:</label>
                        <input type="text" name="groupName" class="form-control" id="recipient-name">
                        <input type="hidden" name="userId" value="${user.id}">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Add</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- 添加好友分组结束 -->




<script>
    $(function(){
        $(".logout").click(function(){
            $(location).attr('href', '/logout.action');
        })

        var $friendGroups;
        var $friends;
        //加载好友分组、以及好友
        var $loadFriendList = function () {


            $.ajax({
                type:"POST",
                async:false,
                url:"/selectFriendList.action",
                dataType:'json',
                data:{
                    userId:${user.id}
                },
                success:function(data){
                    $friendGroups = data.friendGroups;
                    $friends = data.friends;
                }
            })

            for(var o in $friendGroups){
                $(".friend-groups").append(
                        "<div class='panel panel-default'>" +
                        "<div class='panel-heading' role='tab' id='heading"+o+"'>" +
                        "<h4 class='panel-title'>" +
                        "<a value='"+$friendGroups[o].id +"' role='button' data-toggle='collapse' data-parent='#accordion' href='#collapse"+o+"' aria-expanded='false' aria-controls='collapse"+o+"'>" +
                        $friendGroups[o].groupName +
                        "</a>" +
                        "<span value='"+$friendGroups[o].id+"' style='float: right;' class='delete-fg glyphicon glyphicon-remove'></span>"+
                        "</h4>" +
                        "</div>" +

                        "<div id='collapse"+o+"' class='panel-collapse collapse' role='tabpanel' aria-labelledby='heading"+o+"'>" +
                        "<div class='panel-body'>" +
                        "<ul style='padding-left: 0px;' class='friend-list"+o+"'>" +

                        "</ul>" +
                        "</div>" +
                        "</div>" +
                        "</div>"

                );
            }
            $(".friend-list00").empty();
            for(var i in $friends){
                if ($friends[i].friendGroupId == 0)
                    $(".friend-list00").append("<li class='friend-info' style='list-style-type: none;'><span  onclick='liuyan(this)' value='" + $friends[i].friendId + "'>" +
                            $friends[i].friendName + "</span><span style='float: right;'><a href='/deleteFriend.action?userId=${user.id}&friendId="+$friends[i].friendId+"'>删除</a></span></li>");
                else
                    for(var j in $friendGroups) {
                        if ($friendGroups[j].id == $friends[i].friendGroupId)
                            $(".friend-list" + j + "").append("<li class='friend-info' style='list-style-type: none;'><span  onclick='liuyan(this)' value='" + $friends[i].friendId + "'>" +
                                    $friends[i].friendName + "</span><span style='float: right;'><a href='/deleteFriend.action?userId=${user.id}&friendId="+$friends[i].friendId+"'>删除</a></span></li>");
                    }
            }
        }

        $loadFriendList();

        //删除好友分组
        $(".friend-groups").on("click",".delete-fg",function () {
            var fg_id = $(this).attr("value");

            $.confirm({
                title:'删除好友分组',
                content:'如果删除此分组的好友将自动合并到默认分组中，是否删除！',
                buttons:{
                    delete:{
                        text:'删除',
                        action:function () {
                            $.ajax({
                                type:"POST",
                                url:"/deleteFriendGroup.action",
                                dataType:'json',
                                data:{
                                    friendGroupId:fg_id
                                },
                                success:function(data){
                                    $.alert("删除成功");
                                    $(".friend-group-default").nextAll().remove();
                                    $loadFriendList();
                                },
                                error:function () {
                                    $.alert("删除失败");
                                    $(".friend-group-default").nextAll().remove();
                                    $loadFriendList();
                                }
                            })
                        }
                    },
                    close:{
                        text:'关闭'
                    }
                }
            })
        })

        //浏览帖子
        var postNum = 0;
        var postLen = 0;
        var $loadPost = function () {
            var posts;
            var ids = "";
            for (var f in $friends){
                ids += $friends[f].friendId +",";
            }
            ids += ${user.id};
            $.ajax({
                type:"POST",
                async:false,
                url:"/showPost.action",
                dataType:'json',
                data:{
                    ids:ids,
                    postNum:postNum
                },
                success:function(data){
                    posts = data;
                    postLen = posts.length;
                }
            })

            for (var p in posts){
                if(posts[p].userId == ${user.id}){
                    $("article").append(
                            "<div class='post' style='background-color: #fff;margin-top: 10px;padding:10px;'>" +
                            "<div class='media'>" +
                            "<div class='media-left'>" +
                            "<a href='#'>" +
                            "<img class='media-object' src='http://localhost:8080${user.icon}' alt='...' style='width: 40px; height: 40px;'>" +
                            "</a>" +
                            "</div>" +
                            "<div class='media-body'>" +
                            "<h4 class='media-heading'>${user.username}<span class='label label-danger' style='margin-left:10px;font-weight:400;'>"+posts[p].category+"</span></h4>" +
                            posts[p].date +"<span value='"+posts[p].id+"' style='margin-left:10px;' class='glyphicon glyphicon-thumbs-up'></span>(<span class='upvote'>"+ posts[p].upvote+"</span>) <a href='/deletePost.action?postId="+posts[p].id+"'>删除</a>"+
                            "</div>" +
                            "</div>" +
                            "<div class='post-content' style='margin-top: 15px;margin-bottom: 15px;'>" + posts[p].content + "</div>" +
                            posts[p].picsPath +
                            "<textarea name='content' class='form-control' style='margin: 10px 0 10px 0;' maxlength='200'></textarea>" +
                            "<button value='" + posts[p].id + "' class='com-but btn btn-success' style='margin-bottom: 15px;float:right;'>评论</button>" +
                            "<div class='comments' style='width:100%;word-break:break-all;'></div>" +
                            "<button value='" + posts[p].id + "' class='onload-comment btn btn-default' style='height: 40px;width: 100%;margin-bottom: 15px;'>查看评论</button>" +
                            "</div>"
                    );
                }else {
                    for (var f in $friends) {
                        if (posts[p].userId == $friends[f].friendId) {
                            $("article").append(
                                    "<div class='post' style='background-color: #fff;margin-top: 10px;padding:10px;'>" +
                                    "<div class='media'>" +
                                    "<div class='media-left'>" +
                                    "<a href='#'>" +
                                    "<img class='media-object' src='http://localhost:8080"+$friends[f].userIcon+"' alt='...' style='width: 40px; height: 40px;'>" +
                                    "</a>" +
                                    "</div>" +
                                    "<div class='media-body'>" +
                                    "<h4 class='media-heading'>" + $friends[f].friendName + "<span class='label label-danger' style='margin-left:10px;font-weight:400;'>"+posts[p].category+"</span></h4>" +
                                    posts[p].date +"<span value='"+posts[p].id+"' style='margin-left:10px;' class='glyphicon glyphicon-thumbs-up'></span>(<span class='upvote'>"+ posts[p].upvote+"</span>)"+
                                    "</div>" +
                                    "</div>" +
                                    "<div class='post-content' style='margin-top: 15px;margin-bottom: 15px;'>" + posts[p].content + "</div>" +
                                    posts[p].picsPath +
                                    "<textarea name='content' class='form-control' style='margin: 10px 0 10px 0;' maxlength='200'></textarea>" +
                                    "<button value='" + posts[p].id + "' class='com-but btn btn-success' style='margin-bottom: 15px;float:right;'>评论</button>" +
                                    "<div class='comments' style='width:100%;word-break:break-all;'></div>" +
                                    "<button value='" + posts[p].id + "' class='onload-comment btn btn-default' style='height: 40px;width: 100%;margin-top: 15px;margin-bottom: 15px;'>查看评论</button>" +
                                    "</div>"
                            );
                        }
                    }
                }
            }

        }

        $loadPost();

        $(".more-post-but").click(function(){
            if (postLen==15){
                postNum += 15;
                $loadPost();
            }
        })


        var $selectComments = function (o,com) {
            var postId = o.attr("value");
            var comments;
            $.ajax({
                type:"POST",
                async:false,
                url:"/selectComments.action",
                dataType:'json',
                data:{
                    postId:postId
                },
                success:function(data){
                    comments = data;
                }
            })
            com.empty();
            for(var c in comments){
                if (comments[c].userId == ${user.id}){
                    com.append("" +
                            "<div class='media'>" +
                            "<div class='media-left'>" +
                            "<a href='#'>" +
                            "<img class='media-object' src='${user.icon}' alt='...' style='width: 40px; height: 40px;'>" +
                            "</a>" +
                            "</div>" +
                            "<div class='media-body'>" +
                            "<h4 class='media-heading'>${user.username}</h4>"+
                            comments[c].content+
                            "<p>"+comments[c].date+"&nbsp;&nbsp;<span><a href='/deleteCommemt.action?id="+comments[c].id+"'>删除</a></span><p>"+
                            "</div>" +
                            "</div>" +
                            "");
                }else{
                    for(var f in $friends ){
                        if (comments[c].userId == $friends[f].friendId){
                            com.append("" +
                                    "<div class='media'>" +
                                    "<div class='media-left'>" +
                                    "<a href='#'>" +
                                    "<img class='media-object' src='"+$friends[f].userIcon+"' alt='...' style='width: 40px; height: 40px;'>" +
                                    "</a>" +
                                    "</div>" +
                                    "<div class='media-body'>" +
                                    "<h4 class='media-heading'>"+$friends[f].friendName+"</h4>"+
                                    comments[c].content+
                                    "<p>"+comments[c].date+"<p>"+
                                    "</div>" +
                                    "</div>" +
                                    "");
                        }
                    }
                }
            }
        }

        $(".com-but").click(function(){
            var content = $(this).prev().val();
            var postId = $(this).attr("value");
            if(content==""){
            }else{
                $.ajax({
                    type:"POST",
                    async:false,
                    url:"/addComemnt.action",
                    dataType:'json',
                    data:{
                        postId:postId,
                        userId:${user.id},
                        content:content
                    },
                    success:function(data){
                    }
                })
                $(this).prev().val("");
                $selectComments($(this),$(this).next());
            }
        })

        $(".onload-comment").click(function(){
            $selectComments($(this),$(this).prev());
        })
        
        
        $(".glyphicon-thumbs-up").click(function () {
            var upPostId = $(this).attr("value");
            var n ;
            var upvote = $(this).next(".upvote");
            $.ajax({
                type:"POST",
                async:false,
                url:"/isUpvote.action",
                dataType:'json',
                data:{
                    postId:upPostId,
                    userId:${user.id},
                },
                success:function(data){
                    n = data;
                }
            })

            if(n==1){
                $.ajax({
                    type:"GET",
                    async:false,
                    url:"/minusUpvote.action",
                    dataType:'json',
                    data:{
                        postId:upPostId,
                        userId:${user.id},
                    },
                    success:function(data){
                        var u = upvote.text();
                        upvote.text(parseInt(u)-1);
                    }
                })
            }
            if(n==0){
                $.ajax({
                    type:"GET",
                    async:false,
                    url:"/plusUpvote.action",
                    dataType:'json',
                    data:{
                        postId:upPostId,
                        userId:${user.id},
                    },
                    success:function(data){
                        var u = upvote.text();
                        upvote.text(parseInt(u)+1);
                    }
                })
            }
        })
        
    })
</script>

<div class="popup" style="display: none;">
    <div class="popup-content">
        <div class="popup-title">
            <h4>留言</h4>
        </div>
        <form action="/insertLeaveMessage.action" method="post">
        <div class="popup-body">
                <input type="hidden" name="userId" value="${user.id}">
                <input type="hidden" name="friendId" class="lf-id">
                <label class="control-label">留言内容:</label>
                <textarea name="content" class="form-control"></textarea>
        </div>
        <div class="popup-footer">
            <button type="button" class="popup-close btn btn-default" data-dismiss="modal">Close</button>
            <button type="submit" class="popup-submit btn btn-primary">留言</button>
        </div>
        </form>
    </div>
</div>

<script>
    var liuyan = function (e) {
        var lfid = $(e).attr("value");
        $(".lf-id").val(lfid);
        $(".popup").show();
    }
</script>

</body>
</html>
