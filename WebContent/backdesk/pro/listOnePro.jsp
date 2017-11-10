<%@page import="com.pro.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

<% ProVO proVO = (ProVO) request.getAttribute("proVO"); %>

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
		<br>
		<nav aria-label="breadcrumb" role="navigation">
  		<ol class="breadcrumb">
    		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/backdesk.jsp">首頁</a></li>
    		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/pro/proBackIndex.jsp">商城管理</a></li>
    		<li class="breadcrumb-item active" aria-current="page">商品查詢</li>
  		</ol>
	</nav>
</div>
<div class="col-xs-12 col-sm-6 col-sm-offset-1">
<table border='1' bordercolor='#CCCCFF' width='800'>
	<tr>
		<th>商品照片</th>
		<th>商品編號</th>
		<th>商品名稱</th>
		<th>商品價格</th>
		<th>商品敘述</th>
		<th>商品分類</th>
		<th>商品狀態</th>
		<th>商品折扣</th>
		<th>商品折扣開始日期</th>
		<th>商品折扣結束日期</th>
		<th colspan="2">商品異動</th>
	</tr>
	
	
		
		<tr align='center' valign='middle'>
			<td><img width="100" height="100" 
			src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}" /></td>
			<td>${proVO.pro_No}</td>
			<td>${proVO.pro_Name}</td>
			<td>${proVO.pro_Price}</td>
			<td>${proVO.pro_Info}</td>
			<td>${proVO.pro_Class_No}</td>
			<td>${proVO.pro_Status}</td>
			<td>${proVO.pro_Discount}</td>
			<td>${proVO.pro_Dis_StartDate}</td>
			<td>${proVO.pro_Dis_EndDate}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" style="margin-bottom: 0px;">
			     <button type="submit" class="btn btn-warning">修改</button>
			     <input type="hidden" name="pro_No"  value="${proVO.pro_No}">
			     <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
				 <input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  
			     <input type="hidden" name="action"	value="getOne_For_Update">
			    </FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" style="margin-bottom: 0px;">
			     <button type="submit" class="btn btn-danger">刪除</button>
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