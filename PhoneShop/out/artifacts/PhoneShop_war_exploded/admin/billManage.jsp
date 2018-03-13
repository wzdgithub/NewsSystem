<%@ page import="com.bean.PageBean" %>
<%@ page import="com.bean.Bill" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%String path = request.getContextPath();%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="<%=path%>/common/css/adminTable.css"/>
</head>
<%
    PageBean billPageAdmin = (PageBean) request.getAttribute("billPageAdmin");
    List<Bill> bills = billPageAdmin.getPageList();
%>
<body>
    <table>
        <tr><td>ID</td><td>商品名</td><td>价格</td><td>收货人</td><td>电话号</td><td>收货地址</td><td>删除</td></tr>
        <%for (Bill bill:bills){%>
        <tr>
            <td><%=bill.getId()%></td>
            <td><%=bill.getShopname()%></td>
            <td><%=bill.getPrice()%></td>
            <td><%=bill.getConsignee()%></td>
            <td><%=bill.getTelephone()%></td>
            <td><%=bill.getAddress()%></td>
            <td><a href="bill_deleteBill?id=<%=bill.getId()%>">删除</a></td>
        </tr>
        <%}%>
    </table>
    <div class="page" style="margin-left: 600px;">
        <%if (billPageAdmin.getCurrentPage() > 1){%>
        <a href="bill_selectBillAdmin?currentPage=<%=billPageAdmin.getCurrentPage()-1%>">上一页</a>
        <%}%>
        <span><%=billPageAdmin.getCurrentPage()%></span>/<span><%=billPageAdmin.getTotalPage()%></span>
        <%if (billPageAdmin.getCurrentPage() < billPageAdmin.getTotalPage()){%>
        <a href="bill_selectBillAdmin?currentPage=<%=billPageAdmin.getCurrentPage()+1%>">下一页</a>
        <%}%>
    </div>
</body>
</html>
