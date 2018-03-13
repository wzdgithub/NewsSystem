<%@ page import="com.bean.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>用户留言</title>
  <meta charset="utf-8"/>
  <link rel="stylesheet" type="text/css" href="common/css/loginAndRegister.css">
</head>
<body>
<%
  User user = (User) session.getAttribute("user");
%>
<div class="content" style="width: 600px;margin-left: -300px;">
  <div class="content-title">用户留言</div>
  <div class="content-form">
    <form action="feedback_insertFeedback" method="post">
      <input type="hidden" name="userid" value="<%=user.getId()%>"/>
      <textarea name="content" id="" cols="30" rows="10" style="width: 330px;height: 160px;resize: none;margin-bottom: 20px;"></textarea>
      <input type="submit" value="留言" style="background: #213e82;margin-bottom: 50px;"/>
    </form>
  </div>
  <div style="text-align: right;font-size: 18px;"><a href="news_home" style="display:inline-block;margin: 20px;">返回首页</a></div>
</div>
</body>
</html>