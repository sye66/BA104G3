<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
img {
	width: 200px;
}
</style>
<title>Insert title here</title>
</head>
<body>
	<img src="<%=request.getContextPath()%>/qrcode/qrcode.do">
	<form method="get"
		action="<%=request.getContextPath()%>/qrcodeaccept/qrcodeaccept.do">
		<input type="hidden" name="encodingmsg" value="BA104G3"> <input
			type="submit" value="送出">
	</form>
</body>
</html>