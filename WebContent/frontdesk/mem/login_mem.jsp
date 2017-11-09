<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Login Page</title>
	</head>
	
	<body>
<%-- 錯誤處理 --%>

<c:if test="${not empty errorMsgs}">
	<font style="color:#da0">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:#00f">${message}</li>
		</c:forEach>
	</ul>
</c:if>



		<form method="post" action="<%=request.getContextPath()%>/mem/mem.do">

			Please enter your E-mail
			<input type="text" name="mem_email"/><br>		
		
			Please enter your password
			<input type="text" name="mem_pw"/>
			<input type="hidden" name="action" value="loginServlet">
			<input type="submit" value="submit">			
		
		</form>
	</body>
</html>