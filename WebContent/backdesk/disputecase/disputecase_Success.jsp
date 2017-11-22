<%@page import="java.io.OutputStream"%>
<%@page import="com.businessrefinery.barcode.QRCode"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.businessrefinery.barcode.Barcode"%>
<%
	byte[] barcodeByteArr = (byte[]) request.getAttribute("barcodeByteArr");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>
		<h1 class="text-center">哈囉～哩後！</h1>
		<%
		
		OutputStream output=response.getOutputStream(); 
		output.write(barcodeByteArr);
		
		output.flush();
		%>
</body>
</html>
