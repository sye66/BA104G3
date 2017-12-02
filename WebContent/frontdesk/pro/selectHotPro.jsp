<%@page import="java.util.*"%>
<%@page import="com.pro.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     
    

<%
    ProService proSvc = new ProService();
    List<ProVO> list = proSvc.getHot();
   
    pageContext.setAttribute("list",list);
    
%>
 <style>
.proDiv2{

/* 	border:3px orange double; */
	height: 230px;
	width:170px;
	margin:6px;
	
	
} 
.proName2{ 
   	color:#000;
	font-family: Microsoft JhengHei;
	font-weight:bold;
   	font-size:18px; 
   	height:40px;
}  
.proPrice2{
 	font-size:16; 
    color:red; 
} 
/*  .imgCont{ */
/*  	 display:  flex; */
/*      align-items: center; */
/*      justify-content:  center; */
/*      max-width: 80%; */
/*  } */
.proDiscount2{ 
  	font-size:14px; 
  	font-family: Microsoft JhengHei;
/*   	text-decoration:line-through; */
  
} 
.card2{
	height:220px;
	box-shadow: 4px 4px 8px 4px rgba(0,0,0,0.2);
    transition: 0.3s;
    border-radius: 5px;
}
</style>


<html>
<head>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
<title>工具人出租</title>
</head>
<body>

<div style="text-align:center;">
  
  <div class="col-xs-12 col-sm-12 ">
	<c:forEach var="proVO" items="${list}" end="3">
		<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}">
		<c:if test="${proVO.pro_Discount!=100}">
		<c:if test="${proVO.pro_Status=='上架'}" >
			<div class="col-xs-12 col-sm-12 proDiv2">
		     	<div class="card2" style="background-color: #fff;">
			 	    <div class="imgCont2">
			 	    	<br>
		  				<img class="card-img-top" style="width:100px;"  src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}" alt="Card image cap">
			   	    </div>
	  				<div class="card-body">
	   			 		<p class="card-text proName2">${proVO.pro_Name}</p>
	   			 		 <c:set var="balance" value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
	   			 		 <fmt:parseNumber var="dsPrice" integerOnly="true" 
                       type="number" value="${balance}" />
	   			 		 
	   			 		<span class="card-footer proPrice" style="height:14px;font-family: Microsoft JhengHei;color:red;">促銷價:
	   			 			<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">
	   			 			<c:out value="${dsPrice}" /></span>點</span>
	   			 		<br>
	 			 	</div>
				</div>
			</div>
		</c:if>
		</c:if>
	 	</a>
 	</c:forEach>  	
 	
</div>
</div>
 
</body>
</html>