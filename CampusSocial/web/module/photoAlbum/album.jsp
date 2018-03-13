<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.bean.User" %><%--
  Created by IntelliJ IDEA.
  User: ZhenDong
  Date: 2017/4/27
  Time: 11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>我的相册</title>
    <link rel="stylesheet" href="/module/commons/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/module/home/css/index.css">
    <link rel="stylesheet" href="/module/photoAlbum/css/album.css">
    <link rel="stylesheet" href="/module/commons/fileinput/css/fileinput.min.css">

    <script type="application/javascript" src="/module/commons/js/jquery-3.2.1.min.js"></script>
    <script type="application/javascript" src="/module/commons/bootstrap/js/bootstrap.min.js"></script>
    <script type="application/javascript" src="/module/commons/fileinput/js/fileinput.min.js"></script>
    <script type="application/javascript" src="/module/commons/fileinput/js/locales/zh.js"></script>
    <script type="application/javascript" src="/module/commons/js/jquery.session.js"></script>
</head>
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
<div class="container">
    <div class="row">
        <div class="col-md-2 sidebar"></div>
        <div class="col-md-8 main-content album-list" style="background-color: #fff;padding: 10px;">
            <div class="row" style="height: 40px;margin:0 0 20px 0;">
                <button class="create-album" data-toggle="modal" data-target="#add-album">创建相册</button>
                <button class="create-album" data-toggle="modal" data-target="#add-photo">上传照片</button>
            </div>
        </div>
        <div class="col-md-2 sidebar"></div>
    </div>
</div>

<!-- 添加相册 -->
<div class="modal fade" id="add-album" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">创建相册</h4>
            </div>
            <form action="/createAlbum.action" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="form-group">
                        <label class="control-label">相册名:</label>
                        <input type="text" name="name" class="form-control">
                        <input type="hidden" name="userId" value="${user.id}">
                        <label class="control-label">相册简介:</label>
                        <textarea name="info" class="form-control"></textarea>
                        <label class="control-label">相册类型:</label>
                        <select name="category" class="form-control">
                            <option value="自拍">自拍</option>
                            <option value="朋友">朋友</option>
                            <option value="家人">家人</option>
                            <option value="旅游">旅游</option>
                            <option value="其他">其他</option>
                        </select>
                        <label class="control-label">上传封皮:</label>
                        <input type="file" name="icon">
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
<!-- 添加相册结束 -->

<!-- 添加照片 -->
<div class="modal fade" id="add-photo" tabindex="-1" role="dialog" aria-labelledby="addPhotoModalLabel">
    <div class="modal-dialog" role="document" style="width: 95%;height: auto;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addPhotoModalLabel">上传照片</h4>
            </div>
            <form action="/uploadPhotos.action" method="post" enctype="multipart/form-data">
                <div class="modal-body">
                    <div class="form-group">
                        <input type="hidden" name="userId" value="${user.id}">
                        <label class="control-label">选择相册:</label>
                        <select name="albumId" class="form-control album-select">
                        </select>
                        <label class="control-label">图片标题:</label>
                        <input type="text" name="name" class="form-control">
                        <label class="control-label">上传照片:</label>
                        <input id="file-photos" type="file" name="pics" multiple=true>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Add</button>
                </div>
            </form>
            <script>
                $("#file-photos").fileinput({
                    uploadUrl: '#',
                    language: 'zh',
                    allowedFileExtensions : ['jpg', 'png','gif'],
                });
            </script>
        </div>
    </div>
</div>
<!-- 添加照片结束 -->

<script>
    $(function () {
        $(".logout").click(function(){
            $(location).attr('href', '/logout.action');
        })

        var albums;

        $.ajax({
            type:"POST",
            async:false,
            url:"/selectAlbums.action",
            dataType:'json',
            data:{
                userId:${user.id}
            },
            success:function(data){
                albums = data;
                $.session.set("albums",JSON.stringify(data));
            }
        })

        for(var a in albums){
            $(".album-list").append("" +
                    "<div class='col-md-3' style='padding:0;'>" +
                    "<div class='album'>" +
                    "<a href='/module/photoAlbum/photos.jsp?albumId="+albums[a].id+"&num="+a+"'>" +
                    "<div class='album-pic'>" +
                    albums[a].icon +
                    "</div>" +
                    "<div class='album-info'>" +
                    "<h4>"+albums[a].name+
                    "<a style='font-size: 14px;float: right;' href='/deleteAlbum.action?id="+albums[a].id+"'>删除</a></h4> " +
                    albums[a].info +
                    "</div>" +
                    "</a>" +
                    "</div>" +
                    "</div>" +
                    "");

            $(".album-select").append("" +
                    "<option value='"+albums[a].id+"'>"+albums[a].name+"</option>" +
                    "");
        }

    })
</script>

</body>
</html>
