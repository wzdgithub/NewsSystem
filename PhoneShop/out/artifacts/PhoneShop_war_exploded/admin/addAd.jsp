
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
</head>
<body>
    <form action="ad_insertAd.action" method="post" enctype="multipart/form-data">
        <lable>添加广告图片：</lable><input type="file" name="adImg"/><br/>
        <lable>添加广告链接：</lable><input type="text" name="adUrl"/><br/>
        <input type="submit" value="添加"/>
    </form>
</body>
</html>
