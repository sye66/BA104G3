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
	<jsp:useBean id="proSvc" scope="page"
	class="com.pro.model.ProService" /> 
	<h3>訂單明細:</h3>
	<table class="table table-hover" style=" background-color:#FFED97;">
				<caption></caption>
						<thead>
							<tr>
								<th>商品名稱</th>
								<th>單價</th>
								<th>數量</th>
								<th>小計</th>
								
								
								
							</tr>
						</thead>
	
				<c:forEach var="proOrdListVO" items="${oneOrdList}">
						
						<tbody>
					
						
							<tr>
								<td>
								<c:forEach var="proVO" items="${proSvc.all}">
									
									<c:if test="${proVO.pro_No==proOrdListVO.pro_No}">
	                				   	${proVO.pro_Name}
                   				 </c:if>
								</c:forEach>
								</td>		
								<td>${proOrdListVO.ordPro_Price}</td>				
								<td>${proOrdListVO.ordPro_Count} </td>
								<td>${(proOrdListVO.ordPro_Count)*(proOrdListVO.ordPro_Price)} </td>
								
								
								
							
							</tr>
							
						</c:forEach>
						
						</tbody>
					</table>
</body>
</html>