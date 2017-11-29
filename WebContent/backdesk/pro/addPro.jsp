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
  					<input id="pro_Name" name="pro_Name" value="<%=(proVO == null) ? "" : proVO.getPro_Name()%>" type="text" class="form-control" placeholder="請打名稱">
			
			</div>
			<br>
			<div class="input-group input-group-lg">
			
  					<span class="input-group-addon" id="sizing-addon1">商品價格:</span>
  					<input id="pro_Price" name="pro_Price" value="<%=(proVO == null) ? "" : proVO.getPro_Price()%>" type="text" class="form-control"  placeholder="請打數字" aria-label="Username" aria-describedby="sizing-addon1">
			</div>
			<br>
			<div class="input-group input-group-lg">
  					<span class="input-group-addon" id="sizing-addon1">商品折扣:</span>
  					<input id="pro_Discount" name="pro_Discount" value="<%=(proVO == null) ? "" : proVO.getPro_Discount()%>" type="text" class="form-control"  placeholder="請打數字  1~100 %" aria-label="Username" aria-describedby="sizing-addon1">
			</div>
			<%
				java.sql.Date date_SQL = new java.sql.Date(System.currentTimeMillis());
			%>
			<br>
			<div class="input-group input-group-lg">
  					<span class="input-group-addon" id="sizing-addon1">折扣開始日期:</span>
<%--   					<input id="pro_Dis_StartDate" name="pro_Dis_StartDate" value="<%=(proVO == null) ? "" : proVO.getPro_Dis_StartDate()%>" type="text" class="form-control"  > --%>
  					<input id="pro_Dis_StartDate" name="pro_Dis_StartDate" value="<%=(proVO == null) ? "" : proVO.getPro_Dis_StartDate()%>" type="date" class="form-control"  >
			</div>
			<br>
			<div class="input-group input-group-lg">
  				<span class="input-group-addon" id="sizing-addon1">折扣結束日期:</span>
<%--   				<input id="pro_Dis_EndDate" name="pro_Dis_EndDate" value="<%=(proVO == null) ? "" : proVO.getPro_Dis_EndDate()%>" type="text" class="form-control" > --%>
  				<input id="pro_Dis_EndDate" name="pro_Dis_EndDate" value="<%=(proVO == null) ? "" : proVO.getPro_Dis_EndDate()%>" type="date" class="form-control" >
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
	<div class="col-xs-12 col-sm-12" style="padding-left:0px;">
		<table>
			<tr>
				<td><h3>種類:</h3></td>
				<td>
					<select size="1" name="pro_Class_No" style="height:30px">
						<c:forEach var="proClassVO" items="${proClassSvc.all}">
						<option value="${proClassVO.pro_Class_No}"
						${(proVO.pro_Class_No==proClassVO.pro_Class_No)? 'selected':'' }>${proClassVO.pro_Class_Name}
						</c:forEach>
					</select>
				</td>
				
				<td>
					<a href="<%=request.getContextPath()%>/backdesk/proClass/addProClass.jsp">
					<button type="button" class="btn btn-warning" 
							style="width:100px;heigth:16px;font-size:14px;">新增分類</button>
				</a>
				</td>
				
				
				
				<td width="100"></td>			
				<td><h3>狀態:</h3></td>
				<td> <select size="1" name="pro_Status" style="height:30px" >
								<option value="下架">下架
								<option value="上架">上架
				  		 </select>
				</td>
			</tr>
			
		</table>
  						
	</div><!-- 12 -->
	
	<br>		
		<div class="col-xs-12 col-sm-9" style="padding-left:0px;">
			<div class="form-group" >
    			<label for="exampleFormControlTextarea1" ><h3>商品說明:</h3></label>
    			<textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="pro_Info"><%=(proVO == null) ? "" : proVO.getPro_Info()%></textarea>
  			</div>
		</div>
		<br>
		<div class="col-xs-12 col-sm-6">
		<input type="hidden" name="action" value="insert">
		<button type="submit" class="btn btn-success" style="width:520px;heigth:50px;font-size:24px; ">新增商品</button>
		<button type="button" class="btn " style="width:10px;heigth:10px;" id="new"></button>
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
	<script type="text/javascript">
	$('#new').click(function(){
		$('#pro_Name').val("她們的工具人們");
		$('#pro_Price').val("299");
		$('#pro_Discount').val("90");
		$('#pro_Dis_StartDate').val("2017-12-08");
		$('#pro_Dis_EndDate').val("2017-12-31");
		$('#exampleFormControlTextarea1').val("如果你是工具人,那麼恭喜你,可以在本遊戲中體驗人情冷暖,與看似夥伴實質競爭者的工具人,勾心鬥角,爭奪工具王的稱號。");
	});

	</script>


</body>
</html>