<%@page import="java.util.*"%>
<%@page import="com.pro.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     
    

<%
    ProService proSvc = new ProService();
    List<ProVO> list = proSvc.getTop10();
    pageContext.setAttribute("list",list);
    int count = 1;
    
%>
 <style>
.proDiv0{
	
/* 	border:3px orange double; */
	height: 180px;
	width:200px;
 	margin:0px,audio; 
	
	
} 
.proName0{ 
   	font-size:18px; 
}  
.proPrice0{
 	font-size:16; 
    color:red; 
} 
.proDiscount0{ 
  	font-size:14px; 
  	text-decoration:line-through;
  
} 
.card0{
	
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


  <div class="col-xs-12 col-sm-12">
  
	<c:forEach var="proVO" items="${list}" end="9">
	
	
		<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}" style="text-decoration:none;">
		
		<c:if test="${proVO.pro_Status=='上架'}" >
		<h3 style="margin-left:16px; color:red;">TOP:<%=count %></h3>
		<div style="text-align:center ">
			<div class="col-xs-12 col-sm-12 proDiv0">
		     	<div class="card0"  >
		     	
			 	    <div class="imgCont0">
			 	    
		  				<img class="card-img-top" style="width:100px;"  src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}" alt="Card image cap">
			   	        
			   	    </div>
	  				<div class="card-body">
	   			 		<p class="card-text proName0">${proVO.pro_Name}</p>
	   			 		<c:set var="balance" value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
	   			 		 <fmt:parseNumber var="dsPrice" integerOnly="true" 
                       type="number" value="${balance}" />
	   			 		 
	   			 		<p class="card-footer proPrice" style="height:28px;">折扣價:$<c:out value="${dsPrice}" /></p>
	   			 		
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