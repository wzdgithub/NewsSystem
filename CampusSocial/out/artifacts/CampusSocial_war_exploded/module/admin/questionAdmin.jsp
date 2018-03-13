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
    <title>问答管理</title>
    <link rel="stylesheet" href="/module/commons/bootstrap/css/bootstrap.min.css">

    <script src="/module/commons/js/jquery-3.2.1.min.js"></script>
    <script type="application/javascript" src="/module/commons/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<table class="table table-hover">
    <tr>
        <th>#</th>
        <th>ID</th>
        <th>作者</th>
        <th>标题</th>
        <th>日期</th>
        <th>操作</th>
    </tr>
    <tbody class="questionList">

    </tbody>
</table>
<div class="page-btn" style="width: 100%;text-align: center;margin-bottom: 40px;">
    <button class="pre-btn btn btn-default">上一页</button>
    <button class="next-btn btn btn-default">下一页</button>
</div>
</body>
<script>
    var page = 0;
    var questions;
    var len = 0;
    $(function () {
        var loadAllQuestion = function () {
            $.ajax({
                type:"POST",
                async:false,
                url:"/selectAllQuestion.action",
                dataType:'json',
                data:{
                    page:page,
                },
                success:function(data){
                    questions = data;
                    len = questions.length;
                }
            })
        }

        var appendQuestion = function () {
            loadAllQuestion();
            $(".questionList").empty();
            for (var q = 0;q<len;q++){
                $(".questionList").append("" +
                        "<tr>" +
                        "<td>"+(page+q+1)+"</td>" +
                        "<td>"+questions[q].id+"</td>" +
                        "<td>"+questions[q].username+"</td>" +
                        "<td>"+questions[q].title+"</td>" +
                        "<td>"+questions[q].date+"</td>" +
                        "<td><span onclick='del(this)' qid = '"+questions[q].id+"'>删除</span></td>" +
                        "<tr>" +
                        "");
            }
        }
        appendQuestion();

        $(".page-btn .pre-btn").click(function () {
            if (page>0){
                page -= 15;
                appendQuestion();
            }
        })
        $(".page-btn .next-btn").click(function () {
            if (len>=15){
                page += 15;
                appendQuestion();
            }
        })
    })
    var del = function (d) {
        var qid = $(d).attr("qid");
        $.ajax({
            type:"POST",
            async:false,
            url:"/deleteAdminQuestion.action",
            dataType:'json',
            data:{
                page:page,
                id:qid
            },
            success:function(data){
                questions = data;
                len = questions.length;
            }
        })
        $(".questionList").empty();
        for (var q = 0;q<len;q++){
            $(".questionList").append("" +
                    "<tr>" +
                    "<td>"+(page+q+1)+"</td>" +
                    "<td>"+questions[q].id+"</td>" +
                    "<td>"+questions[q].username+"</td>" +
                    "<td>"+questions[q].title+"</td>" +
                    "<td>"+questions[q].date+"</td>" +
                    "<td><span onclick='del(this)' qid = '"+questions[q].id+"'>删除</span></td>" +
                    "<tr>" +
                    "");
        }
    }
</script>
</html>
