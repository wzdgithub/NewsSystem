<%@ page import="com.bean.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ZhenDong
  Date: 2017/4/27
  Time: 17:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的相册</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
    <link href="./css/piccontext.css" rel="stylesheet" type="text/css" />
    <link href="/module/commons/css/smartMenu.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="/module/commons/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="/module/home/css/index.css">

    <script src="./js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script type="application/javascript" src="/module/commons/bootstrap/js/bootstrap.min.js"></script>
    <script type="application/javascript" src="/module/commons/js/jquery.session.js"></script>
    <script type="application/javascript" src="/module/commons/js/jquery-smartMenu.js"></script>
    <style>
        .smart_menu_body{
            width: 75px;
        }
    </style>
</head>
<body>
<%
    int albumId = Integer.parseInt(request.getParameter("albumId"));
    int num = Integer.parseInt(request.getParameter("num"));
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
<!--主体内容-->
<div class="main">
    <!--弹出层开始-->
    <div class="bodymodal"></div>
    <!--播放到第一张图的提示-->
    <div class="firsttop">
        <div class="firsttop_left">
        </div>
        <div class="firsttop_right">
            <div class="close2"> <a class="closebtn1" title="关闭" href="javascript:void(0)"></a> </div>
            <div class="replay">
                <h2 id="div-end-h2" style="margin-top: 0px;"> 已到第一张图片了。 </h2>
                <p> <a class="replaybtn1" href="javascript:;">重新播放</a> </p>
            </div>
            <div class="pictwo">
                <ul>
                    <li class="pic1">
                        <a href="" title="" target="_blank">

                        </a>
                        <div class="imgdivtext">
                            <a href="" title="" target="_blank">上一图集</a>
                        </div>
                    </li>
                    <li class="pic2">
                        <a href="" title="" target="_blank">
                        </a>
                        <div class="imgdivtext">
                            <a href="" title="" target="_blank">下一图集</a>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="returnbtn"> <a href="">返回图库首页</a> </div>
        </div>
    </div>
    <!--播放到最后一张图的提示-->
    <div class="endtop">
        <div class="firsttop_left">
        </div>
        <div class="firsttop_right">
            <div class="close2"> <a class="closebtn2" title="关闭" href="javascript:void(0)"></a> </div>
            <div class="replay">
                <h2 id="H1"> 已到最后一张图片了。 </h2>
                <p> <a class="replaybtn2" href="javascript:;">重新播放</a> </p>
            </div>
            <div class="pictwo">
                <ul>
                    <li class="pic1">
                        <a href="" title="" target="_blank">
                        </a>
                        <div class="imgdivtext">
                            <a href="" title="" target="_blank">上一图集</a>
                        </div>
                    </li>
                    <li class="pic2">
                        <a href="" title="" target="_blank">
                        </a>
                        <div class="imgdivtext">
                            <a href="" title="" target="_blank">下一图集</a>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="returnbtn"> <a href="#">返回图库首页</a> </div>
        </div>
    </div>
    <!--弹出层结束-->
    <!--图片特效内容开始-->
    <div class="piccontext">
        <h2 class="album-name">
            <!--此处为相册标题-->
        </h2>
        <div class="source">
            <div class="source_left"><span class="album-date"></span></div>
            <div class="source_right">
                <div class="support"> 支持<img src="images/jiantou1.jpg" />键翻阅图片 </div>
                <span>|</span><a href="javascript:;" class="list">列表查看</a> </div>
            <div class="source_right1"> <a href="javascript:;" class="gaoqing">高清查看</a> </div>
        </div>
        <!--大图展示-->
        <div class="picshow">
            <div class="picshowtop">
                <a href="#"><img src="" alt="" id="pic1" curindex="0" /></a>
                <a id="preArrow" href="javascript:void(0)" class="contextDiv" title="上一张"><span id="preArrow_A"></span></a>
                <a id="nextArrow" href="javascript:void(0)" class="contextDiv" title="下一张"><span id="nextArrow_A"></span></a>
            </div>
            <div class="picshowtxt">
                <div class="picshowtxt_left"><span>1</span>/<i></i></div>
                <div class="picshowtxt_right"></div>
            </div>
            <div class="picshowlist">
                <!--上一条图库-->
                <div class="picshowlist_left">
                    <div class="picleftimg">
                        <a href="" title="" target="_blank">

                        </a>
                    </div>
                    <div class="piclefttxt">
                        <a href="" title="" target="_blank"></a>
                    </div>
                </div>
                <div class="picshowlist_mid">
                    <div class="picmidleft">
                        <a href="javascript:void(0)" id="preArrow_B"><img src="images/left1.jpg" alt="上一个" /></a> </div>
                    <div class="picmidmid">
                        <ul class="big-photos">
                            <!--此处为大图下面的小图,与大图一体-->
                        </ul>
                    </div>
                    <div class="picmidright"> <a href="javascript:void(0)" id="nextArrow_B"><img src="images/right1.jpg" alt="下一个" /></a> </div>
                </div>
                <!--下一张图库新闻-->
                <div class="picshowlist_right">
                    <div class="picleftimg">
                        <a href="" title="" target="_blank">
                        </a>
                    </div>
                    <div class="piclefttxt">
                        <a href="" title="" target="_blank"></a>
                    </div>
                </div>
            </div>
        </div>

        <!--列表展示-->
        <div class="piclistshow">
            <ul>
                <!--此处为列表显示的图片-->
            </ul>
        </div>
    </div>
</div>
<div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">
    <p></p>
</div>
<script>
    $(function () {
        $(".logout").click(function(){
            $(location).attr('href', '/logout.action');
        })

        var albumId = <%=albumId%>;
        var num = <%=num%>;
        var albums = JSON.parse($.session.get("albums"));
        var photos;
        var prevNum = 0;
        var nextNum = 0;

        $(".album-name").text(albums[num].name);
        $(".album-date").text(albums[num].date);

        $.ajax({
            type:"POST",
            async:false,
            url:"/selectPhotos.action",
            dataType:'json',
            data:{
                albumId:albumId
            },
            success:function(data){
                photos = data;
            }
        })

        var albumLength = albums.length - 1;
        if(albumLength == 0){
            nextNum = 0;
            prevNum = 0;
        }else if(num == albumLength){
            nextNum = 0;
            prevNum = num - 1;
        }else if(num == 0){
            nextNum = num + 1;
            prevNum = albumLength;
        }else{
            nextNum = num + 1;
            prevNum = num - 1;
        }
        <!--播放到第一张图的提示-->
        $(".firsttop_right .pictwo .pic1 a").attr("href","/module/photoAlbum/photos.jsp?" +
                "albumId="+albums[prevNum].id+"&num="+prevNum);
        $(".firsttop_right .pictwo .pic1 a").attr("title",albums[prevNum].name);
        $(".firsttop_right .pictwo .pic1 a").append(albums[prevNum].icon);
        $(".firsttop_right .pictwo .pic1 .imgdivtext a").attr("href","/module/photoAlbum/photos.jsp?" +
                "albumId="+albums[prevNum].id+"&num="+prevNum);
        $(".firsttop_right .pictwo .pic1 .imgdivtext a").attr("title",albums[prevNum].name);
        <!--播放到最后一张图的提示-->
        $(".firsttop_right .pictwo .pic2 a").attr("href","/module/photoAlbum/photos.jsp?" +
                "albumId="+albums[nextNum].id+"&num="+nextNum);
        $(".firsttop_right .pictwo .pic2 a").attr("title",albums[nextNum].name);
        $(".firsttop_right .pictwo .pic2 a").append(albums[nextNum].icon);
        $(".firsttop_right .pictwo .pic2 .imgdivtext a").attr("href","/module/photoAlbum/photos.jsp?" +
                "albumId="+albums[nextNum].id+"&num="+nextNum);
        $(".firsttop_right .pictwo .pic2 .imgdivtext a").attr("title",albums[nextNum].name);

        $(".firsttop_right .returnbtn a").attr("href","/module/photoAlbum/album.jsp");
        //-----------------------------------------------


        <!--上一条图库-->
        $(".picshowlist_left .picleftimg a").attr("href","/module/photoAlbum/photos.jsp?" +
                "albumId="+albums[prevNum].id+"&num="+prevNum);
        $(".picshowlist_left .picleftimg a").attr("title",albums[prevNum].name);
        $(".picshowlist_left .picleftimg a").append(albums[prevNum].icon);
        $(".picshowlist_left .piclefttxt a").attr("href","/module/photoAlbum/photos.jsp?" +
                "albumId="+albums[prevNum].id+"&num="+prevNum);
        $(".picshowlist_left .piclefttxt a").text(albums[prevNum].name);

        <!--下一张图库新闻-->
        $(".picshowlist_right .picleftimg a").attr("href","/module/photoAlbum/photos.jsp?" +
                "albumId="+albums[nextNum].id+"&num="+nextNum);
        $(".picshowlist_right .picleftimg a").attr("title",albums[nextNum].name);
        $(".picshowlist_right .picleftimg a").append(albums[nextNum].icon);
        $(".picshowlist_right .piclefttxt a").attr("href","/module/photoAlbum/photos.jsp?" +
                "albumId="+albums[nextNum].id+"&num="+nextNum);
        $(".picshowlist_right .piclefttxt a").text(albums[nextNum].name);






        var photoLength =photos.length;
        $(".picshowtxt_left i").text(photoLength);

        for (var p in photos){
            $(".big-photos").append("" +
                    "<li>" +
                    "<a href='javascript:void(0);'>" +
                    "<img src='http://localhost:8080"+photos[p].url+"' " +
                    "alt='' bigimg='http://localhost:8080"+photos[p].url+"' " +
                    "text='&nbsp;"+photos[p].name+"' />" +
                    "</a>" +
                    "</li>" +
                    "");
            var n = parseInt(p)+1;
            $(".piclistshow ul").append("" +
                    "<li pid='"+photos[p].id+"'>" +
                    "<div class='picimg'>" +
                    "<img src='http://localhost:8080"+photos[p].url+"' alt='' />" +
                    "</div>" +
                    "<div class='pictxt'>" +
                    "<h3>"+photos[p].name+"<span>("+n+"/"+photoLength+")</span></h3>" +
                    "</div>" +
                    "</li>" +
                    "");
        }



        var menuData = [
            [{
                text:"删除",
                func: function() {
                    var pid = $(this).attr("pid");
                    $(location).attr('href', "/deletePhoto.action?id="+pid+"&albumId="+albumId+"&num="+num);
                }
            }]
        ]
        $(".piclistshow ul li").smartMenu(menuData,{
            name:"",
            offsetX:2,
            offsetY:2,
            textLimit:6
        });

    })
</script>
<script src="./js/piccontent.min.js" type="text/javascript"></script>
</body>
</html>
