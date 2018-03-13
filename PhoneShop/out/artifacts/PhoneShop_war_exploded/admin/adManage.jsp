<%@ page import="com.bean.Ad" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="<%=path%>/common/css/adminTable.css"/>
</head>
<body>
    <%
      List<Ad> adList = (List<Ad>) request.getAttribute("adList");
    %>
    <table>
        <tr><td>广告图片</td><td>广告链接</td><td>操作</td></tr>
        <%for (Ad ad:adList){%>
        <tr><td><%=ad.getAdImg()%></td><td><%=ad.getAdUrl()%></td><td><a href="ad_deleteAd?id=<%=ad.getId()%>">删除</a></td></tr>
        <%}%>
    </table>
    <div style="margin-left: 200px;"><a href="/admin/addAd.jsp">添加广告</a></div>
</body>
</html>
