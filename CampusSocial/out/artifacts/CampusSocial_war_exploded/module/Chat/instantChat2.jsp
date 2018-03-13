<%--
  Created by IntelliJ IDEA.
  User: ZhenDong
  Date: 2017/3/21
  Time: 18:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>聊天</title>
</head>
<body>
<div>
    <textarea name="" id="send-text" cols="30" rows="10"></textarea>
    <input type="button" value="Start" onclick="start()" />
</div>
<div id="messages"></div>
<script type="text/javascript">
    var url = "ws://localhost:8080/instantChat/2/1";
    var webSocket = new WebSocket(url);

    webSocket.onmessage = function(message){
        document.getElementById("send-text").value += message.data+"\r";
    }

    function start() {
        var mes = document.getElementById("send-text").value;
        webSocket.send(mes);
    }
</script>
</body>
</html>