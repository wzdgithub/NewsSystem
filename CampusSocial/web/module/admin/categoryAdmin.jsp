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
    <title>类别管理</title>
    <link rel="stylesheet" href="/module/commons/bootstrap/css/bootstrap.min.css">

    <script src="/module/commons/js/jquery-3.2.1.min.js"></script>
    <script type="application/javascript" src="/module/commons/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<table class="table table-hover">
    <tr>
        <th>#</th>
        <th>ID</th>
        <th>类型</th>
        <th>操作</th>
    </tr>
    <tbody class="categoryList">

    </tbody>
</table>
<button class="btn btn-primary" style="margin: 20px;" type="button" data-toggle="modal" data-target="#exampleModal">添加分类</button>
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">添加分类</h4>
            </div>
            <form action="/insertCategory.action" method="post">
                <div class="modal-body">
                    <div class="form-group">
                        <label for="recipient-name" class="control-label">分类名:</label>
                        <input type="text" name="content" class="form-control" id="recipient-name">
                        <input type="hidden" name="part" value="帖子">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">添加</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script>
    var categorys;
    var len;
    $(function () {
        var loadCatrgory = function () {
            $.ajax({
                type:"POST",
                async:false,
                url:"/selectCategory.action",
                dataType:'json',
                success:function(data){
                    categorys = data;
                    len = categorys.length;
                }
            })
        }

        var appendCatrgory = function () {
            loadCatrgory();
            $(".categoryList").empty();
            for (var c = 0;c<len;c++){
                $(".categoryList").append("" +
                        "<tr>" +
                        "<td>"+(c+1)+"</td>" +
                        "<td>"+categorys[c].id+"</td>" +
                        "<td>"+categorys[c].content+"</td>" +
                        "<td><span onclick='del(this)' cid = '"+categorys[c].id+"'>删除</span></td>" +
                        "<tr>" +
                        "");
            }
        }
        appendCatrgory();

    })
    var del = function (d) {
        var cid = $(d).attr("cid");
        $.ajax({
            type:"POST",
            async:false,
            url:"/deleteCategory.action",
            dataType:'json',
            data:{
                id:cid
            },
            success:function(data){
                categorys = data;
                len = categorys.length;
            }
        })
        $(".categoryList").empty();
        for (var c = 0;c<len;c++){
            $(".categoryList").append("" +
                    "<tr>" +
                    "<td>"+(c+1)+"</td>" +
                    "<td>"+categorys[c].id+"</td>" +
                    "<td>"+categorys[c].content+"</td>" +
                    "<td><span onclick='del(this)' cid = '"+categorys[c].id+"'>删除</span></td>" +
                    "<tr>" +
                    "");
        }
    }
</script>
</html>
