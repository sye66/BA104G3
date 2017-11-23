<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.pro.model.*"%>
<%@ page import="com.proclass.model.*"%>
<%
	ProVO proVO = (ProVO) request.getAttribute("proVO");
%>
<html>
<!-- -->
<head>
<script language="JavaScript" src="js/calendarcode.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品</title>



<style>
textarea {
	outline: none;
	padding: 0.4em;
	width: 100%;
	
	font-weight: 600;
	font-size: 16px;
	border: 1px solid #1186ec;
}
.breadcrumb li,.breadcrumb li a {
    color: #f90;
	font-size: 16px;   
}

</style>
 

</head>


<body>
	<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/pro/proBackLeft.jsp" flush="true" />
	
<!-- 	<div class="col-xs-12 col-sm-6 col-sm-offset-1"> -->
<!-- 	<br> -->
<!-- 	<nav aria-label="breadcrumb" role="navigation"> -->
<!--   		<ol class="breadcrumb"> -->
<%--     		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/backdesk.jsp">首頁</a></li> --%>
<%--     		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/pro/proBackIndex.jsp">商城管理</a></li> --%>
<!--     		<li class="breadcrumb-item active" aria-current="page">新增商品</li> -->
<!--   		</ol> -->
<!-- 	</nav> -->
<!-- 	</div> -->
<div class="col-xs-12 col-sm-5 col-sm-offset-2">
		<br>
		<h1>添加新的商品</h1>
		<br>
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

	<form action="<%=request.getContextPath()%>/pro/pro.do" method=post enctype="multipart/form-data" name="form1">

    <div class="row">
		<div class="col-xs-12 col-sm-6">
			<div class="input-group input-group-lg ">
  					<span class="input-group-addon" id="sizing-addon1">商品名稱:</span>
  					<input name="pro_Name" value="<%=(proVO == null) ? "小王子" : proVO.getPro_Name()%>" type="text" class="form-control">
			
			</div>
			<br>
			<div class="input-group input-group-lg">
			
  					<span class="input-group-addon" id="sizing-addon1">商品價格:</span>
  					<input name="pro_Price" value="<%=(proVO == null) ? "40" : proVO.getPro_Price()%>" type="text" class="form-control"  placeholder="Username" aria-label="Username" aria-describedby="sizing-addon1">
			</div>
			<br>
			<div class="input-group input-group-lg">
  					<span class="input-group-addon" id="sizing-addon1">商品折扣:</span>
  					<input name="pro_Discount" value="<%=(proVO == null) ? "100" : proVO.getPro_Discount()%>" type="text" class="form-control"  placeholder="Username" aria-label="Username" aria-describedby="sizing-addon1">
			</div>
			<%
				java.sql.Date date_SQL = new java.sql.Date(System.currentTimeMillis());
			%>
			<br>
			<div class="input-group input-group-lg">
  					<span class="input-group-addon" id="sizing-addon1">折扣開始日期:</span>
  					<input name="pro_Dis_StartDate" value="<%=(proVO == null) ? date_SQL : proVO.getPro_Dis_StartDate()%>" type="date" class="form-control"  placeholder="Username" aria-label="Username" aria-describedby="sizing-addon1">
			</div>
			<br>
			<div class="input-group input-group-lg">
  				<span class="input-group-addon" id="sizing-addon1">折扣結束日期:</span>
  				<input name="pro_Dis_EndDate" value="<%=(proVO == null) ? date_SQL : proVO.getPro_Dis_EndDate()%>" type="date" class="form-control"  placeholder="Username" aria-label="Username" aria-describedby="sizing-addon1">
			</div>
		</div><!-- 資料欄 -->
	<br>
		<div class="col-xs-12 col-sm-6">
			<div class=" ordering-image wow bounceIn" data-wow-delay="0.4s" id="preview">
				<img id="blah" src="<%=request.getContextPath()%>/res/images/pro_icons/nopic.jpg" alt="your image" width="200" height="200" /> 
				<span class="btn btn-block btn-large file-input-container">
					<input id="pro_pic" name="pro_Pic" size="30" type="file" value="上傳照片" onchange="previewFile();"/>
				</span>
			</div>
		</div><!-- pic -->
	</div><!-- row -->
		<jsp:useBean id="proClassSvc" scope="page" class="com.proclass.model.ProClassService" />
	<br>		
	<div class="col-xs-12 col-sm-12">
		<div class="row">
			 <div class="col-xs-12 col-sm-2"> 
				 <h3>種類:</h3>
  			 </div>
  			<div class="col-xs-12 col-sm-2" >	
  					    <select size="1" name="pro_Class_No" style="height:30px">
								<c:forEach var="proClassVO" items="${proClassSvc.all}">
								<option value="${proClassVO.pro_Class_No}"
								${(proVO.pro_Class_No==proClassVO.pro_Class_No)? 'selected':'' }>${proClassVO.pro_Class_Name}
								</c:forEach>
						</select>
			</div>
			
			<div class="col-xs-12 col-sm-2">
				<h3>狀態:</h3>
			</div>	
			<div class="col-xs-12 col-sm-2">
  						 <select size="1" name="pro_Status" style="height:30px" >
								<option value="下架">下架
								<option value="上架">上架
				  		 </select>
			</div>
		 
		</div><!-- row -->
	</div><!-- 12 -->
	
	<br>		
		<div class="col-xs-12 col-sm-9">
			<div class="form-group">
    			<label for="exampleFormControlTextarea1"><h3>商品說明</h3></label>
    			<textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="pro_Info"><%=(proVO == null) ? "XXX" : proVO.getPro_Info()%></textarea>
  			</div>
		</div>
		<br>
		<div class="col-xs-12 col-sm-6">
		<input type="hidden" name="action" value="insert">
		<button type="submit" class="btn btn-success">新增商品</button>
		</div>
	</form>
	
	
	
</div>
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



</body>
</html>