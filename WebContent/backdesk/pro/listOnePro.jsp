<%@page import="com.pro.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 
<% 

	ProVO proVO = (ProVO) request.getAttribute("proVO");
	pageContext.setAttribute(" proVO", proVO);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style>

.breadcrumb li,.breadcrumb li a {
    color: #f90;
	font-size: 16px;   
}

</style>
</head>
<body>
<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
<jsp:include page="/backdesk/pro/proBackLeft.jsp" flush="true" />
<div class="col-xs-12 col-sm-6 col-sm-offset-1">
		<br><br>
		
</div>
<div class="col-xs-12 col-sm-8 col-sm-offset-1">
<table style="border: solid 1px #d0d0d0;  ">
	<tr>
		<th style="width:100px;text-align: center;" rowspan="6"><img width="150" height="150" 
			src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}" /></th>
		<th style="width:100px;text-align: center;">商品編號</th>
		<th style="width:100px;text-align: center;">商品名稱</th>
		<th style="width:100px;text-align: center;">商品價格</th>
		
	</tr>
	
	
	
	
		<tr align='center' valign='middle'>
			
			<td>${proVO.pro_No}</td>
			<td>${proVO.pro_Name}</td>
			<td>${proVO.pro_Price}</td>
			
		</tr>
		
		
	<tr>
		<th style="width:100px;text-align: center;">商品分類</th>
		<th style="width:100px;text-align: center;">商品狀態</th>
		<th style="width:100px;text-align: center;">商品折扣</th>
	</tr>
	
	
		<jsp:useBean id="proClassSvc" scope="page" class="com.proclass.model.ProClassService" />
		<tr>
		<c:forEach var="proClassVO" items="${proClassSvc.all}">
			<c:if test="${proVO.pro_Class_No==proClassVO.pro_Class_No}">
					<td>${proClassVO.pro_Class_Name}</td>
							
			</c:if>				
		</c:forEach>	
			
			<td>${proVO.pro_Status}</td>
			<td>${proVO.pro_Discount}</td>
			
		</tr>
		<tr>
		
			<th style="width:100px;text-align: center;">商品折扣開始日期</th>
			<th style="width:100px;text-align: center;">商品折扣結束日期</th>
			<td></td>
		</tr>
		<tr>
			<td>${proVO.pro_Dis_StartDate}</td>
			<td>${proVO.pro_Dis_EndDate}</td>
			<td></td>
		</tr>
		<tr>
			<th style="width:100px;text-align: center;">商品敘述</th><td colspan="3" style="height:100px;">${proVO.pro_Info}</td>
		</tr>
		<tr>
			
		
			<td colspan="2">
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" style="margin-bottom: 0px;">
			     <button type="submit" class="btn btn-warning" style="width:200px;height:40px;font-size:20px;">修改</button>
			     <input type="hidden" name="pro_No"  value="${proVO.pro_No}">
			     <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
				 <input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  
			     <input type="hidden" name="action"	value="getOne_For_Update">
			    </FORM>
			</td>
		
			<td colspan="2">
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" style="margin-bottom: 0px;">
			     <button type="submit" class="btn btn-danger" style="width:200px;height:40px;font-size:20px;">刪除</button>
			     <input type="hidden" name="pro_No"  value="${proVO.pro_No}">
			      <input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">
			     <input type="hidden" name="action" value="delete">
			   </FORM>
			</td>
		</tr>	
</table>
</div>

</body>
</html>