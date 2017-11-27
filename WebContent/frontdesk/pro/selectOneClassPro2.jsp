<%@page import="java.util.*"%>
<%@page import="com.pro.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>      

<%
//     ProService proSvc = new ProService();
//     List<ProVO> list = proSvc.getAll();
//     pageContext.setAttribute("list",list);
//     ServletContext context = getServletContext();
//     Map<String, String> mapPro_display2 = (Map<String,String>) context.getAttribute("mapPro_display2");
// 	String ProUp =  mapPro_display2.get("up");
// 	System.out.println(ProUp);
%>
	<jsp:useBean id="proClassSvc" scope="page" class="com.proclass.model.ProClassService" />

 


<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<title>工具人出租</title>

<style>

.proName{
  	color:#000;
	font-family: Microsoft JhengHei;
	font-weight:bold;
   	font-size:20px; 
} 
.proPrice{
    font-size:20;
    color:red;
	font-family: Microsoft JhengHei;
 }
 .imgCont{
 	 display:  flex;
     align-items: center;
     justify-content:  center;
 }
 .proDiscount{
 
 	color:#000;
	font-family: Microsoft JhengHei;
 	font-size:16px;
 	text-decoration:line-through;
 }
 
.card{
	width:256px;
	box-shadow: 4px 4px 8px 4px rgba(0,0,0,0.2);
    transition: 0.3s;
    border-radius: 5px;
}
.float {
	position:fixed;
	top: 0;
 	box-shadow:4px 4px 12px 4px rgba(20%,20%,40%,0.5);
 	z-index: 100;
 
}
.breadcrumb li,.breadcrumb li a {
    color: #f90;
	font-size: 16px;   
}
</style>



</head>
<body>
<a name="aaa"></a>

<!-- TOP -->
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/proNavbar.jsp" flush="true"/> 
<%-- <jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"></jsp:include> --%>
</div>
<!-- 商城TOP -->
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/selectProTOP.jsp" flush="true" />	
</div>

<div class="col-xs-12 col-sm-6 col-sm-offset-3">
		<!--麵包屑 -->
		<div class="col-xs-12 col-sm-12">

			<br>
			<ol class="breadcrumb">
				<li><a href="<%=request.getContextPath()%>">首頁</a></li>
				<li><a href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp">積分商城</a></li>
				<li class="active">商品搜尋
				</li>

			</ol>

		</div>
		
			
		
		
<div style="text-align:center;">
  
	<c:forEach var="proVO" items="${listPro_ByCompositeQuery}">
		<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}">
		<c:if test="${proVO.pro_Status=='上架'}" >
			<div class="col-xs-12 col-sm-3 proDiv">
		     	<div class="card" style="width:100%;">
			 	    <div class="imgCont">
		  				<img class="card-img-top" style="width:200px;height:200px;"  src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}" alt="Card image cap">
			   	    </div>
	  				<div class="card-body">
	   			 		<p class="card-text proName" style="height:45px;">${proVO.pro_Name}</p>
	   			 		<c:if test="${proVO.pro_Discount==100}">
	   			 			
	   			 			<p class="card-footer proPrice" style="height:28px;">價格:${proVO.pro_Price}點</p>
	   			 			<P style="height:28px;">　</P>
	   			 		</c:if>
	   			 		
	   			 		<c:if test="${proVO.pro_Discount!=100}">
	   			 		<p class="card-footer proDiscount" style="height:28px;">價格:${proVO.pro_Price}點</p>
	   			 		
	   			 			<c:set var="balance" value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
	   			 		 	<fmt:parseNumber var="dsPrice" integerOnly="true" 
                      		 type="number" value="${balance}" />
	   			 		<p class="card-footer proPrice" style="height:28px;">折扣價:<c:out value="${dsPrice}"/>點</p>
	   			 		</c:if>
	 			 	</div>
				</div>
			</div>
		
		</c:if>
	 	</a>
 	</c:forEach>  	
 </div></div>	
 
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
 <div class="col-xs-12 col-sm-12">
 <jsp:include page="/lib/publicfile/include/file/footer2.jsp" flush="true"></jsp:include>
</div>
</body>
</html>