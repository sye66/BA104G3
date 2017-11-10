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
<title>商品資料修改</title>

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
</style>
</head>
<body>
<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
<jsp:include page="/backdesk/pro/proBackLeft.jsp" flush="true" />
	
	<div class="col-xs-12 col-sm-6 col-sm-offset-1">
	
	<nav aria-label="breadcrumb" role="navigation">
  		<ol class="breadcrumb">
    		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/backdesk.jsp">首頁</a></li>
    		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/proBackIndex.jsp">商城管理</a></li>
    		<li class="breadcrumb-item active" aria-current="page">新增商品</li>
  		</ol>
	</nav>
	
	<br>
	<h3>資料修改:</h3>
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
	
	</div>
	
<div class="col-xs-12 col-sm-5 col-sm-offset-2">	
	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do"
		enctype="multipart/form-data" name="form1">
		<table border="0">
			<tr>
				<td>商品編號:</font></td>
				<td>${proVO.pro_No}</td>
			</tr>
			
			<tr>
				<td>商品照片:</td>
				<td><img width="150" height="150"
					src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}" />
					<span class="btn btn-block btn-large file-input-container">
				 		<input id="pro_pic" name="pro_Pic"  type="file" value="上傳照片" onchange="previewFile();"/>
					</span>
				</td>
			</tr>

			<tr>
				<td>商品名稱:<font color=red><b>*</b></td>
				<td><input type="TEXT" name="pro_Name" size="45"
					value="${proVO.pro_Name}" /></td>
			</tr>
			<tr>
				<td>商品價錢:<font color=red><b>*</b></td>
				<td><input type="TEXT" name="pro_Price" size="45"
					value="${proVO.pro_Price}" /></td>
			</tr>
			<jsp:useBean id="proClassSvc" scope="page"
				class="com.proclass.model.ProClassService" />
			<tr>
				<td>種類:<font color=red><b>*</b></font></td>
				<td><select size="1" name="pro_Class_No">
						<c:forEach var="proClassVO" items="${proClassSvc.all}">
							<option value="${proClassVO.pro_Class_No}"
								${(proVO.pro_Class_No==proClassVO.pro_Class_No)? 'selected':'' }>${proClassVO.pro_Class_Name}
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>商品折扣:</td>
				<td><input type="TEXT" name="pro_Discount" size="45"
					value="${proVO.pro_Discount}" /></td>
			</tr>
			<tr>
				<td>商品開始日期:</td>
				<td><input type="date" name="pro_Dis_StartDate" size="45"
					value="${proVO.pro_Dis_StartDate}" /></td>
			</tr>
			<tr>
				<td>商品結束日期:</td>
				<td><input type="date" name="pro_Dis_EndDate" size="45"
					value="${proVO.pro_Dis_EndDate}" /></td>
			</tr>

			<tr>
				<td>商品狀態:<font color=red><b>*</b></td>
				<td>目前狀態:${proVO.pro_Status}　　更改:
				<select size="1" name="pro_Status">
						<option value="下架">下架
						<option value="上架">上架
				</select>
				</td>
			</tr>
			<tr><th>商品說明:</th></tr>
		</table>
		
				
					<textarea id="pro_info" name="pro_Info" cols="50" rows="6" required>${proVO.pro_Info}</textarea>
				
			


		<br> <input type="hidden" name="action" value="update">
		 	 <input type="hidden" name="requestURL"  value="<%=request.getParameter("requestURL")%>">
		 	 <input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>"> 
			 <input type="hidden" name="pro_No" value="${proVO.pro_No}"> 
			 <button type="submit" class="btn btn-warning">送出修改</button>
	</FORM>
</div>
</body>
</html>