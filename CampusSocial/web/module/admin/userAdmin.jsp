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
    <title>用户管理</title>
    <link rel="stylesheet" href="/module/commons/bootstrap/css/bootstrap.min.css">

    <script src="/module/commons/js/jquery-3.2.1.min.js"></script>
    <script type="application/javascript" src="/module/commons/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<table class="table table-hover">
    <tr>
        <th>#</th>
        <th>ID</th>
        <th>用户名</th>
        <th>密码</th>
        <th>姓名</th>
        <th>年龄</th>
        <th>性别</th>
        <th>电话号</th>
        <th>地址</th>
        <th>邮箱</th>
        <th>签名</th>
        <th>操作</th>
    </tr>
    <tbody class="userList">

    </tbody>
</table>
<div class="page-btn" style="width: 100%;text-align: center;margin-bottom: 40px;">
    <button class="pre-btn btn btn-default">上一页</button>
    <button class="next-btn btn btn-default">下一页</button>
</div>
</body>
<script>
    var page = 0;
    var users;
    var len = 0;
    $(function () {
        var loadAllUser = function () {
            $.ajax({
                type:"POST",
                async:false,
                url:"/selectAllUser.action",
                dataType:'json',
                data:{
                    page:page,
                },
                success:function(data){
                    users = data;
                    len = users.length;
                }
            })
        }

        var appendUser = function () {
            loadAllUser();
            $(".userList").empty();
            for (var u = 0;u<len;u++){
                $(".userList").append("" +
                        "<tr>" +
                        "<td>"+(page+u+1)+"</td>" +
                        "<td>"+users[u].id+"</td>" +
                        "<td>"+users[u].username+"</td>" +
                        "<td>"+users[u].password+"</td>" +
                        "<td>"+users[u].name+"</td>" +
                        "<td>"+users[u].age+"</td>" +
                        "<td>"+users[u].sex+"</td>" +
                        "<td>"+users[u].telephone+"</td>" +
                        "<td>"+users[u].address+"</td>" +
                        "<td>"+users[u].email+"</td>" +
                        "<td>"+users[u].autograph+"</td>" +
                        "<td><span onclick='del(this)' uid = '"+users[u].id+"'>删除</span></td>" +
                        "<tr>" +
                        "");
            }
        }
        appendUser();
        
        $(".page-btn .pre-btn").click(function () {
            if (page>0){
                page -= 15;
                appendUser();
            }
        })
        $(".page-btn .next-btn").click(function () {
            if (len>=15){
                page += 15;
                appendUser();
            }
        })
    })
    var del = function (d) {
        var uid = $(d).attr("uid");
        $.ajax({
            type:"POST",
            async:false,
            url:"/deleteUser.action",
            dataType:'json',
            data:{
                page:page,
                id:uid
            },
            success:function(data){
                users = data;
                len = users.length;
            }
        })
        $(".userList").empty();
        for (var u = 0;u<len;u++){
            $(".userList").append("" +
                    "<tr>" +
                    "<td>"+(page+u+1)+"</td>" +
                    "<td>"+users[u].id+"</td>" +
                    "<td>"+users[u].username+"</td>" +
                    "<td>"+users[u].password+"</td>" +
                    "<td>"+users[u].name+"</td>" +
                    "<td>"+users[u].age+"</td>" +
                    "<td>"+users[u].sex+"</td>" +
                    "<td>"+users[u].telephone+"</td>" +
                    "<td>"+users[u].address+"</td>" +
                    "<td>"+users[u].email+"</td>" +
                    "<td>"+users[u].autograph+"</td>" +
                    "<td><span onclick='del(this)' uid = '"+users[u].id+"'>删除</span></td>" +
                    "<tr>" +
                    "");
        }
    }
</script>
</html>
