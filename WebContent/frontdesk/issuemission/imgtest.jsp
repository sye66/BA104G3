<%@page import="com.mem.model.MemVO"%>
<%@page import="com.mem.model.MemService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<%
	MemService memService = new MemService();
	MemVO memVO = memService.getOneMem("M000005");
%>
<body>
	<img src ="<%=request.getContextPath()%>/mem/mem.do?action=get_Mem_pic&request_From_Issue=<%=memVO.getMem_No()%>">
</body>
</html>