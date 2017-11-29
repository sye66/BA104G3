<%@page import="com.proclass.model.ProClassService"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.pro.model.*"%>
<%@ page import="com.proclass.model.*"%>
<%
	ProVO proVO = (ProVO) request.getAttribute("proVO");
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工具人後台</title>

<script type="text/javascript">
		function previewFile() {
	 		 var preview = document.querySelector('img');
	 		 var file    = document.querySelector('input[type=file]').files[0];
	  		 var reader  = new FileReader();

	  		  reader.addEventListener("load", function () {
	  		  preview.src = reader.result;
	 			 }, false);
	 		 if (file) {
	   			 reader.readAsDataURL(file);
	 		 }
		}
</script>
<style>

.breadcrumb li,.breadcrumb li a {
    color: #f90;
	font-size: 16px;   
}
td ,th{
	width:150px;
	font-size:20px;
	height:30px;
	
}
input{
	heiht:30px;
}
</style>
</head>
<body>
<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
<jsp:include page="/backdesk/pro/proBackLeft.jsp" flush="true" />
	
	<div class="col-xs-12 col-sm-8 col-sm-offset-1">
	
<!-- 	<nav aria-label="breadcrumb" role="navigation"> -->
<!--   		<ol class="breadcrumb"> -->
<%--     		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/backdesk.jsp">首頁</a></li> --%>
<%--     		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/proBackIndex.jsp">商城管理</a></li> --%>
<!--     		<li class="breadcrumb-item active" aria-current="page">新增商品</li> -->
<!--   		</ol> -->
<!-- 	</nav> -->
	<br>
	<h3>資料修改:</h3>
	<div class="col-xs-12 col-sm-6 col-sm-offset-2">
		
	

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font color='red'>請修正以下錯誤:
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li>${message}</li>
				</c:forEach>
			</ul>
		</font>
	</c:if>
	
	
	

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do"
		enctype="multipart/form-data" name="form1">
		<table style="background-color:#FFFFB9 ;border: solid 1px #FFBD9D;">
			<tr>
				<th style="border: solid 1px #d0d0d0;text-align:right;">商品編號:</th>
				<td style="border: solid 1px #d0d0d0;">${proVO.pro_No}</td>
			</tr>
			
			<tr>
				<th style="border: solid 1px #d0d0d0;text-align:right;">商品照片:</th>
				<td style="border: solid 1px #d0d0d0;"><img width="150" height="150"
					src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}" />
					<span class="btn btn-block btn-large file-input-container">
				 		<input id="pro_pic" name="pro_Pic"  type="file" value="上傳照片" onchange="previewFile();"/>
					</span>
				</td>
			</tr>

			<tr>
				<th style="border: solid 1px #d0d0d0;text-align:right;">商品名稱:</th>
				<td style="border: solid 1px #d0d0d0;">
				<input type="TEXT" name="pro_Name" style="height:30px;font-size:20px;width:250px;text-align: center;"
					value="${proVO.pro_Name}" /></td>
			</tr>
			<tr>
				<th style="border: solid 1px #d0d0d0;text-align:right;">商品價錢:</th>
				<td style="border: solid 1px #d0d0d0;">
				<input type="number" name="pro_Price" style="height:30px;font-size:20px;width:100px;text-align: center;"
					value="${proVO.pro_Price}" /></td>
			</tr>
			<jsp:useBean id="proClassSvc" scope="page"
				class="com.proclass.model.ProClassService" />
			<tr>
				<th style="border: solid 1px #d0d0d0;text-align:right;">種類:</th>
				<td style="border: solid 1px #d0d0d0;"><select size="1" name="pro_Class_No" style="height:30px;font-size:20px;text-align: center;">
						<c:forEach var="proClassVO" items="${proClassSvc.all}">
							<option value="${proClassVO.pro_Class_No}"
								${(proVO.pro_Class_No==proClassVO.pro_Class_No)? 'selected':'' }>${proClassVO.pro_Class_Name}
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<th style="border: solid 1px #d0d0d0;text-align:right;">商品折扣:</th>
				<td style="border: solid 1px #d0d0d0;">
				<input type="number" name="pro_Discount"  style="height:30px;font-size:20px;width:100px;text-align: center;"
					value="${proVO.pro_Discount}" /></td>
			</tr>
			<tr>
				<th style="border: solid 1px #d0d0d0;text-align:right;">商品開始日期:</th>
				<td style="border: solid 1px #d0d0d0;"><input type="date" name="pro_Dis_StartDate" size="20"
					value="${proVO.pro_Dis_StartDate}" style="height:30px;font-size:20px;text-align: center;"/></td>
			</tr>
			<tr>
				<th style="border: solid 1px #d0d0d0;text-align:right;">商品結束日期:</th>
				<td style="border: solid 1px #d0d0d0;"><input type="date" name="pro_Dis_EndDate" size="20"
					value="${proVO.pro_Dis_EndDate}" style="height:30px;font-size:20px;text-align: center;" /></td>
			</tr>

			<tr>
				<th style="border: solid 1px #d0d0d0;text-align:right;">商品狀態:</th>
				<td style="border: solid 1px #d0d0d0;">
				<select size="1" name="pro_Status" style="height:30px;font-size:20px;text-align: center;">
						<option value="下架">下架
						<option value="上架">上架
				</select>
				</td>
			</tr>
			<tr><th style="border: solid 1px #d0d0d0;text-align:right;">商品說明:</th>
				<td style="border: solid 1px #d0d0d0;padding:10px">
					<textarea id="pro_info" name="pro_Info" cols="40" rows="6" required>${proVO.pro_Info}</textarea>
				</td>
			</tr>
</table>

		<br> <input type="hidden" name="action" value="update">
		 	 <input type="hidden" name="requestURL"  value="<%=request.getParameter("requestURL")%>">
		 	 <input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>"> 
			 <input type="hidden" name="pro_No" value="${proVO.pro_No}"> 
			 <button type="submit" class="btn btn-warning" style="width:500px;height:50px;font-size:24px;">送出修改</button>
	</FORM>
</div></div>
</body>
</html>