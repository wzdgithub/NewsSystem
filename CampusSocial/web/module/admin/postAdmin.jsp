<%--
  Created by IntelliJ IDEA.
  User: ZhenDong
  Date: 2017/5/2
  Time: 20:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>帖子管理</title>
    <link rel="stylesheet" href="/module/commons/bootstrap/css/bootstrap.min.css">

    <script src="/module/commons/js/jquery-3.2.1.min.js"></script>
    <script type="application/javascript" src="/module/commons/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<table class="table table-hover">
    <tr>
        <th>#</th>
        <th>ID</th>
        <th>内容</th>
        <th>日期</th>
        <th>类型</th>
        <th>赞数</th>
        <th>操作</th>
    </tr>
    <tbody class="postList">

    </tbody>
</table>
<div class="page-btn" style="width: 100%;text-align: center;margin-bottom: 40px;">
    <button class="pre-btn btn btn-default">上一页</button>
    <button class="next-btn btn btn-default">下一页</button>
</div>
</body>
<script>
    var page = 0;
    var posts;
    var len = 0;
    $(function () {
        var loadAllPost = function () {
            $.ajax({
                type:"POST",
                async:false,
                url:"/selectAllPost.action",
                dataType:'json',
                data:{
                    page:page,
                },
                success:function(data){
                    posts = data;
                    len = posts.length;
                }
            })
        }

        var appendPost = function () {
            loadAllPost();
            $(".postList").empty();
            for (var p = 0;p<len;p++){
                $(".postList").append("" +
                        "<tr>" +
                        "<td>"+(page+p+1)+"</td>" +
                        "<td>"+posts[p].id+"</td>" +
                        "<td>"+posts[p].content+"</td>" +
                        "<td>"+posts[p].date+"</td>" +
                        "<td>"+posts[p].category+"</td>" +
                        "<td>"+posts[p].upvote+"</td>" +
                        "<td><span onclick='del(this)' pid = '"+posts[p].id+"'>删除</span></td>" +
                        "<tr>" +
                        "");
            }
        }
        appendPost();

        $(".page-btn .pre-btn").click(function () {
            if (page>0){
                page -= 15;
                appendPost();
            }
        })
        $(".page-btn .next-btn").click(function () {
            if (len>=15){
                page += 15;
                appendPost();
            }
        })
    })
    var del = function (d) {
        var pid = $(d).attr("pid");
        $.ajax({
            type:"POST",
            async:false,
            url:"/deletePostAdmin.action",
            dataType:'json',
            data:{
                page:page,
                id:pid
            },
            success:function(data){
                posts = data;
                len = posts.length;
            }
        })
        $(".postList").empty();
        for (var p = 0;p<len;p++){
            $(".postList").append("" +
                    "<tr>" +
                    "<td>"+(page+p+1)+"</td>" +
                    "<td>"+posts[p].id+"</td>" +
                    "<td>"+posts[p].content+"</td>" +
                    "<td>"+posts[p].date+"</td>" +
                    "<td>"+posts[p].category+"</td>" +
                    "<td>"+posts[p].upvote+"</td>" +
                    "<td><span onclick='del(this)' pid = '"+posts[p].id+"'>删除</span></td>" +
                    "<tr>" +
                    "");
        }
    }
</script>
</html>
