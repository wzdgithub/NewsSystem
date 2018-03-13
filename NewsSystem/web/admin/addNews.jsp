<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2016/4/8
  Time: 20:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<html>
<head>
    <title></title>
    <script type="text/javascript" charset="utf-8" src="<%=path%>/common/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=path%>/common/ueditor/ueditor.all.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=path%>/common/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" charset="utf-8" src="<%=path%>/common/js/jquery.js"></script>
    <style>
        form input[type="text"]{
            width: 200px;
            height: 25px;
            margin: 5px;
        }
    </style>
</head>
<body>
<div class="content">
    <form action="news_insertNews" method="post" enctype="multipart/form-data">
        <lable>新闻标题：</lable><input type="text" name="title"/><br/>
        <lable>新闻作者：</lable><input type="text" name="author"/><br/>
        <lable>新闻展示图片：</lable><input type="file" name="pic"/><br/>
        <lable>新闻内容：</lable><script id="editor" type="text/plain" name="content" style="width:960px;height:100px;"></script><br/>
        <lable>新闻类别：</lable><input type="text" name="category"/><br/>
        <input type="submit" value="添加"/>
    </form>
</div>
<script type="text/javascript">
    var ue = UE.getEditor('editor', {
        toolbars: [
            ['forecolor', 'backcolor', 'undo', 'redo', 'bold']
        ]
    });
</script>
</body>
</html>
