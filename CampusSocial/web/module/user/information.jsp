<%@ page import="com.bean.User" %>
<%@ page import="com.bean.Security" %><%--
  Created by IntelliJ IDEA.
  User: ZhenDong
  Date: 2017/4/26
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>个人信息</title>
    <link rel="stylesheet" href="/module/commons/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/module/home/css/index.css">
    <link rel="stylesheet" href="/module/user/css/info.css">

    <script type="application/javascript" src="/module/commons/js/jquery-3.2.1.min.js"></script>
    <script type="application/javascript" src="/module/commons/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<c:set var="user" value="${sessionScope.user}" />
<%
    User uu = (User) session.getAttribute("user");
    Security security = (Security) session.getAttribute("security");
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
        <div class="col-md-8 main-content" style="background-color: #fff;padding: 20px;">
            <div class="media">
                <div class="media-left">
                    <a href="#">
                        <%if(uu.getIcon()!=null&&uu.getIcon()!=""){%>
                        <img class="media-object" data-src="holder.js/64x64" alt="80x80" src="http://localhost:8080${user.icon}" data-holder-rendered="true" style="width: 80px; height: 80px;">
                        <%}else{%>
                        <img class="media-object" data-src="holder.js/64x64" alt="80x80" data-holder-rendered="true" style="width: 80px; height: 80px;">
                        <%}%>
                    </a>
                </div>
                <div class="media-body">
                    <div class="table-responsive">
                        <table class="table">
                            <tr>
                                <td class="col-lg-2" style="text-align: right;">姓名：</td>
                                <td>${user.name}</td>
                            </tr>
                            <tr>
                                <td class="col-lg-2" style="text-align: right;">性别：</td>
                                <td>${user.sex}</td>
                            </tr>
                            <tr>
                                <td class="col-lg-2" style="text-align: right;">年龄：</td>
                                <td>${user.age}</td>
                            </tr>
                            <tr>
                                <td class="col-lg-2" style="text-align: right;">地址：</td>
                                <td>${user.address}</td>
                            </tr>
                            <tr>
                                <td class="col-lg-2" style="text-align: right;">电话：</td>
                                <td>${user.telephone}</td>
                            </tr>
                            <tr>
                                <td class="col-lg-2" style="text-align: right;">邮箱：</td>
                                <td>${user.email}</td>
                            </tr>
                            <tr>
                                <td class="col-lg-2" style="text-align: right;">签名：</td>
                                <td>${user.autograph}</td>
                            </tr>
                        </table>
                        <button type="button" class="btn btn-primary btn-lg tou" data-toggle="modal" data-target="#myModal">上传头像</button>
                        <button type="button" class="btn btn-primary btn-lg tou" data-toggle="modal" data-target="#myModal1">修改信息</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-2 sidebar"></div>
    </div>
    <div class="row">
        <div class="col-md-2 sidebar"></div>
        <div class="col-md-8 main-content panel panel-default" style="padding:0;margin: 20px 0;">
            <div class="panel-heading">
                <h4 class="panel-title">修改密码</h4>
            </div>
            <div class="panel-body">
                <div class="" style="width: 400px;margin: 0 auto;margin-top: 30px;margin-bottom: 30px;">
                    <form action="/updateNewPassword.action" method="post">
                        <input type="hidden" name="userId" value="${user.id}">
                        <label>旧密码</label>
                        <input type="password" name="oldPassword" class="form-control password-old">
                        <label>新密码</label>
                        <input type="password" name="newPassword" class="form-control password-new">
                        <label>重复密码</label>
                        <input type="password" class="form-control password-new1">
                        <button class="btn btn-primary mod-pass" style="margin-top: 10px;">修改</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-2 sidebar"></div>
    </div>

    <div class="row">
        <div class="col-md-2 sidebar"></div>
        <div class="col-md-8 main-content panel panel-default" style="padding:0;margin: 20px 0;">
            <div class="panel-heading">
                <h4 class="panel-title">修改密保</h4>
            </div>
            <div class="panel-body">
                <div class="" style="width: 400px;margin: 0 auto;margin-top: 30px;margin-bottom: 30px;">
                    <h4><%=security.getSecurityQuestion()%></h4>
                    <form action="/modifySecurity.action" method="post">
                        <input type="hidden" name="userId" value="${user.id}">
                        <label>旧密保答案</label>
                        <input type="text" name="oldAnswer" class="form-control answer-old">
                        <label>新密保问题</label>
                        <select name="newQuestion" class="form-control">
                            <option value="你母亲的姓名">你母亲的姓名</option>
                            <option value="你父亲的姓名">你父亲的姓名</option>
                            <option value="你大学所在学校">你大学所在学校</option>
                            <option value="你爱人的姓名">你爱人的姓名</option>
                            <option value="你出生地">你出生地</option>
                        </select>
                        <label>新密保答案</label>
                        <input type="text" name="newAnswer" class="form-control answer-new">
                        <label>重复密保答案</label>
                        <input type="text" class="form-control answer-new1">
                        <button class="btn btn-primary mod-answer" style="margin-top: 10px;">修改</button>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-md-2 sidebar"></div>
    </div>
</div>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="/uploadUserIcon.action" method="post" enctype="multipart/form-data">
                <div class="modal-header">
                    上传头像
                </div>
                <div class="modal-body">
                    <input type="hidden" name="id" value="${user.id}">
                    <input type="file" name="icon">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">上传</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel1">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                修改信息
            </div>
            <form action="/updateUserInfo.action" method="post">
            <div class="modal-body">
                <table class="table" style="text-align: right;">
                    <input type="hidden" name="id" value="${user.id}">
                    <tr>
                        <td class="col-lg-2">姓名</td>
                        <td><input type="text" name="name" value="${user.name}" class="form-control" style="height:22px;"></td>
                    </tr>
                    <tr>
                        <td class="col-lg-2">性别</td>
                        <td><input type="text" name="sex" value="${user.sex}" class="form-control" style="height:22px;"></td>
                    </tr>
                    <tr>
                        <td class="col-lg-1">年龄</td>
                        <td><input type="text" name="age" value="${user.age}" class="form-control" style="height:22px;"></td>
                    </tr>
                    <tr>
                        <td class="col-lg-1">地址</td>
                        <td><input type="text" name="address" value="${user.address}" class="form-control" style="height:22px;"></td>
                    </tr>
                    <tr>
                        <td class="col-lg-1">电话</td>
                        <td><input type="text" name="telephone" value="${user.telephone}" class="form-control" style="height:22px;"></td>
                    </tr>
                    <tr>
                        <td class="col-lg-1">邮箱</td>
                        <td><input type="text" name="email" value="${user.email}" class="form-control" style="height:22px;"></td>
                    </tr>
                    <tr>
                        <td class="col-lg-1">签名</td>
                        <td><input type="text" name="autograph" value="${user.autograph}" class="form-control" style="height:22px;"></td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="submit" class="btn btn-primary">修改</button>
            </div>
            </form>
        </div>
    </div>
</div>
</body>
<script>
    $(function () {
        $(".logout").click(function(){
            $(location).attr('href', '/logout.action');
        })
        $(".password-new1").blur(function () {
            var newPassword = $(".password-new").val();
            var newPassword1 = $(".password-new1").val();
            if(newPassword!=null&&newPassword!=""&&newPassword1!=null&&newPassword1!="") {
                if (newPassword == newPassword1) {
                    $(".mod-pass").attr("type", "submit");
                } else {
                    $(".mod-pass").attr("type", "button");
                    alert("密码不一致");
                }
            }else{
                $(".mod-pass").attr("type", "button");
                alert("密码为空");
            }
        })

        $(".answer-new1").blur(function () {
            var newAnswer = $(".answer-new").val();
            var newAnswer1 = $(".answer-new1").val();
            if(newAnswer!=null&&newAnswer!=""&&newAnswer1!=null&&newAnswer1!="") {
                if (newAnswer == newAnswer1) {
                    $(".mod-answer").attr("type", "submit");
                } else {
                    $(".mod-answer").attr("type", "button");
                    alert("答案不一致");
                }
            }else{
                $(".mod-answer").attr("type", "button");
                alert("答案为空");
            }
        })
    })
</script>
</html>
