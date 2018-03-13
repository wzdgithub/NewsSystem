<%@ page import="com.bean.Phone" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dao.impl.PhoneDaoImpl" %>
<%@ page import="com.bean.PageBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title></title>
  <meta charset="utf-8"/>
  <link rel="stylesheet" type="text/css" href="../common/css/adminPhone.css">
</head>
<%
  String id = request.getParameter("id");
  PageBean pageAdminPhone = (PageBean) session.getAttribute("pageAdminPhone");
  List<Phone> phones = pageAdminPhone.getPageList();
  Phone phone = null;
  for (Phone p:phones){
    if(p.getId() == Integer.parseInt(id)){
      phone = p;
    }
  }
%>
<body>
<div class="adminPhone-content">
  <form action="phone_updatePhoneById" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="<%=id%>">
    <div><label>类别：</label><input type="text" name="category" value="<%=phone.getCategory()%>"/></div>
    <div><label>名称：</label><input type="text" name="name" value="<%=phone.getName()%>"/></div>
    <div><label>介绍图片：</label><input type="file" name="introduction_img"/></div>
    <div><label>预览图片：</label><input type="file" name="preview_img"/></div>
    <div><label>价格：</label><input type="text" name="price" value="<%=phone.getPrice()%>"/></div>
    <div><label>品牌：</label><input type="text" name="brand" value="<%=phone.getBrand()%>"/></div>
    <div><label>型号：</label><input type="text" name="model" value="<%=phone.getModel()%>"/></div>
    <div><label>颜色：</label><input type="text" name="color" value="<%=phone.getColor()%>"/></div>
    <div><label>CPU：</label><input type="text" name="cpu" value="<%=phone.getCpu()%>"/></div>
    <div><label>运行内存：</label><input type="text" name="internal_storage" value="<%=phone.getInternal_storage()%>"/></div>
    <div><label>机身内存：</label><input type="text" name="external_storage" value="<%=phone.getExternal_storage()%>"/></div>
    <div><label>屏幕尺寸：</label><input type="text" name="screen_size" value="<%=phone.getScreen_size()%>"/></div>
    <div><label>屏幕分辨率：</label><input type="text" name="resolution_ratio" value="<%=phone.getResolution_ratio()%>"/></div>
    <div><label>后置摄像头：</label><input type="text" name="later_camera" value="<%=phone.getLater_camera()%>"/></div>
    <div><label>前置摄像头：</label><input type="text" name="before_camera" value="<%=phone.getBefore_camera()%>"/></div>
    <div><label>店铺名：</label><input type="text" name="shop" value="<%=phone.getShop()%>"/></div>
    <div><input type="submit" value="修改" /></div>
  </form>
</div>
</body>
</html>