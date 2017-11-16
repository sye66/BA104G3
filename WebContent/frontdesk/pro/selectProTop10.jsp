<%@page import="java.util.*"%>
<%@page import="com.pro.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    

<%
    ProService proSvc = new ProService();
    List<ProVO> list = proSvc.getTop10();
    pageContext.setAttribute("list",list);
    int count = 1;
    
%>
 <style>
.proDiv2{
	
	border:3px orange double;
	height: 180px;
	width:200px;
	margin:0px,audio;
	
} 
.proName2{ 
   	font-size:18px; 
}  
.proPrice2{
 	font-size:16; 
    color:red; 
} 
.proDiscount2{ 
  	font-size:14px; 
  	text-decoration:line-through;
  
} 

</style>


<html>
<head>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
<title>商品</title>
</head>
<body>


  <div>
  
	<c:forEach var="proVO" items="${list}" end="9">
	
	
		<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}" style="text-decoration:none;">
		
		<c:if test="${proVO.pro_Status=='上架'}" >
		<h3 style="margin-left:16px; color:red;">TOP:<%=count %></h3>
		<div style="text-align:center ">
			<div class="col-xs-12 col-sm-10 proDiv2">
		     	<div class="card1" style="margin-top:0px ">
		     	
			 	    <div class="imgCont3">
			 	    
		  				<img class="card-img-top" style="width:100px;"  src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}" alt="Card image cap">
			   	        
			   	    </div>
	  				<div class="card-body">
	   			 		<p class="card-text proName2">${proVO.pro_Name}</p>
	   			 		<p class="card-footer proPrice2">折扣價:$${(proVO.pro_Price)*(proVO.pro_Discount)/100}</p>
	   			 		
	 			 	</div>
				</div>
			</div>
		</div>
		</c:if>
		
	 	</a>
	 	
	
	 <% count++; %>
 	</c:forEach>  	
 	
  </div>	

 
</body>

</html>