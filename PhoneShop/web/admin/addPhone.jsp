<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	<title></title>
	<meta charset="utf-8"/>	
	<link rel="stylesheet" type="text/css" href="../common/css/adminPhone.css">
</head>
<body>
	<div class="adminPhone-content">
		<form action="phone_insertPhone" method="post" enctype="multipart/form-data">
			<div><label>类别：</label><input type="text" name="category"/></div>
			<div><label>名称：</label><input type="text" name="name"/></div>
			<div><label>介绍图片：</label><input type="file" name="introduction_img"/></div>
			<div><label>预览图片：</label><input type="file" name="preview_img"/></div>
			<div><label>价格：</label><input type="text" name="price"/></div>
			<div><label>品牌：</label><input type="text" name="brand"/></div>
			<div><label>型号：</label><input type="text" name="model"/></div>
			<div><label>颜色：</label><input type="text" name="color"/></div>
			<div><label>CPU：</label><input type="text" name="cpu"/></div>
			<div><label>运行内存：</label><input type="text" name="internal_storage"/></div>
			<div><label>机身内存：</label><input type="text" name="external_storage"/></div>
			<div><label>屏幕尺寸：</label><input type="text" name="screen_size"/></div>
			<div><label>屏幕分辨率：</label><input type="text" name="resolution_ratio"/></div>
			<div><label>后置摄像头：</label><input type="text" name="later_camera"/></div>
			<div><label>前置摄像头：</label><input type="text" name="before_camera"/></div>
			<div><label>店铺名：</label><input type="text" name="shop"/></div>
			<div><input type="submit" value="添加" /></div>
		</form>
	</div>
</body>
</html>