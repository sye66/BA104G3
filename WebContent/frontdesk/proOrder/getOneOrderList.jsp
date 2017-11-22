<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.proorder.model.*"%>
<%@ page import="com.proordlist.model.*"%>
<%@ page import="com.mem.model.*"%><html>
<%@page import="java.util.*"%><html>
<head>
<title>清單</title>
</head>
<body>
<% 
// ProOrdListVO proOrdList =(ProOrdListVO) session.getAttribute("proOrdList");
	
	
%>
<%-- 	<jsp:useBean id="proSvc" scope="page" --%>
<%-- 	class="com.pro.model.ProService" /> --%>
	
	<table class="table table-hover">
				<c:forEach var="proOrdListVO" items="${proOrdList}">
						<caption></caption>
						<thead>
							<tr>
								<th>商品名稱</th>
								<th>數量</th>
								<th>價錢</th>
								
								
							</tr>
						</thead>
						<tbody>
					
						
							<tr>
								<c:forEach var="proVO" items="${proSvc.all}">	
									<c:if test="${proVO.pro_No==proOrdList.pro_No}">
	                				   	${proVO.pro_Name}
                   				 </c:if>
								</c:forEach>						
								<td>${proOrdListVO.ordPro_Count} </td>
								<td>${proOrdListVO.ordPro_Price}</td>
								
								
							
							</tr>
							
						
						</c:forEach>
						
						</tbody>
					</table>
</body>
</html>