<%--
  Created by IntelliJ IDEA.
  User: ZhenDong
  Date: 2017/3/21
  Time: 15:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="/module/commons/js/jquery-3.2.0.min.js"></script>
</head>
<body>
<div>
    <textarea name="" id="send-text" cols="30" rows="10"></textarea>
    <input type="button" value="Start" onclick="start()" />
</div>
<div id="messages"></div>
<script type="text/javascript">
    var webSocket = new WebSocket('ws://localhost:8080/webSocket');
    function start() {
        var mes = document.getElementById("send-text").value;
        webSocket.send(mes);
        webSocket.onmessage = function(message){
            alert(message.data);
        }
    }

</script>
</body>
</html>
