<%@ page import="java.util.List" %>
<%@ page import="com.bean.Phone" %>
<%@ page import="com.bean.PageBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<title></title>
	<meta charset="utf-8"/>
	<link rel="stylesheet" type="text/css" href="../common/css/goodsManage.css">
	<link rel="stylesheet" type="text/css" href="../common/css/font-awesome.min.css">
</head>
<%
	PageBean pageAdminPhone = (PageBean) session.getAttribute("pageAdminPhone");
	List<Phone> phones = pageAdminPhone.getPageList();
%>
<body>
	<div class="goodsManage-header"><span><a href="addPhone.jsp">添加商品</a></span></div>
	<div class="goodsManage-content">
		<table>
			<tr><td>ID</td><td>类别</td><td>名称</td><td>价格</td><td>品牌</td><td>型号</td><td>颜色</td><td style="width:50px;">修改</td><td style="width:50px;">删除</td></tr>
			<%for (Phone p:phones){%>
			<tr><td><%=p.getId()%></td><td><%=p.getCategory()%></td><td><%=p.getName()%></td><td><%=p.getPrice()%></td>
			<td><%=p.getBrand()%></td><td><%=p.getModel()%></td><td><%=p.getColor()%></td>
			<td style="width:50px;"><a href="modifyPhone.jsp?id=<%=p.getId()%>">修改</a></td><td style="width:50px;"><a href="phone_deletePhoneById?id=<%=p.getId()%>">删除</a></td></tr>
			<%}%>
		</table>
		<div class="page" style="margin-left: 600px;">
			<%if (pageAdminPhone.getCurrentPage() > 1){%>
			<a href="phone_selectPhone?currentPage=<%=pageAdminPhone.getCurrentPage()-1%>">上一页</a>
			<%}%>
			<span><%=pageAdminPhone.getCurrentPage()%></span>/<span><%=pageAdminPhone.getTotalPage()%></span>
			<%if (pageAdminPhone.getCurrentPage() < pageAdminPhone.getTotalPage()){%>
			<a href="phone_selectPhone?currentPage=<%=pageAdminPhone.getCurrentPage()+1%>">下一页</a>
			<%}%>
		</div>
	</div>
</body>
</html>