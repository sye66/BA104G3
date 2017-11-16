<%@page import="java.util.*"%>
<%@page import="com.pro.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    

<%
    ProService proSvc = new ProService();
    List<ProVO> list = proSvc.getHot();
   
    pageContext.setAttribute("list",list);
    
%>
 <style>
.proDiv2{
	margin:10px;
	border:3px orange double;
	height: 180px;
	width:200px;
	margin:16px;
	
} 
.proName2{ 
   	font-size:18px; 
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
  	text-decoration:line-through;
  
} 
.card{
	
	box-shadow: 4px 4px 8px 4px rgba(0,0,0,0.2);
    transition: 0.3s;
    border-radius: 5px;
}
</style>


<html>
<head>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
<title>商品</title>
</head>
<body>

<div style="text-align:center;">
  <div>
  
	<c:forEach var="proVO" items="${list}" end="10">
		<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}">
		<c:if test="${proVO.pro_Discount!=100}">
		<c:if test="${proVO.pro_Status=='上架'}" >
			<div class="col-xs-12 col-sm-10 proDiv2">
		     	<div class="card" >
			 	    <div class="imgCont2">
		  				<img class="card-img-top" style="width:100px;"  src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}" alt="Card image cap">
			   	    </div>
	  				<div class="card-body">
	   			 		<p class="card-text proName2">${proVO.pro_Name}</p>
	   			 		<p class="card-footer proPrice2">折扣價:$${(proVO.pro_Price)*(proVO.pro_Discount)/100}</p>
	   			 		
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