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
    int count = 0;
    
%>
 <style>
.proDiv0{
	
/* 	border:3px orange double; */
	height: 160px;
	width:180px;
 	margin:0px,audio; 
	
	
} 
.proName0{ 
	color:#000;
	font-family: Microsoft JhengHei;
	font-weight:bold;
   	font-size:15px; 
}  
.proPrice0{
 	font-size:16; 
    color:red;
	font-family: Microsoft JhengHei;
	font-weight:bold; 
} 

.proDiscount{
 	color:#000;
	font-family: Microsoft JhengHei;
 	font-size:10px;
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


  <div class="col-xs-12 col-sm-11 col-sm-offset-1">
  
	<c:forEach var="proVO" items="${list}" end="9">
	
	
		<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}" style="text-decoration:none;">
		
		<c:if test="${proVO.pro_Status=='上架'}" >
		
		
		<div style="text-align:center ">
			<div class="col-xs-12 col-sm-12 proDiv0">
		     	<div class="card0"  style="background-color: #fff;">
		     	
			 	    <div class="imgCont0">
			 	    
		  				<img class="card-img-top" style="width:70px;height:70px;"  src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}" alt="Card image cap">
			   	        
			   	    </div>
			   	    
			   	   <div style="z-index:3;position:absolute;left:20px;  top:5px;">
						<img alt="" style="height:50px;width:40px;transform:rotate(10deg);" src="<%=request.getContextPath()%>/res/images/pro_icons/top00<%=count%>.png">
					</div>
		
	  				<div class="card-body">
	   			 		<p class="card-text proName0" style="height:20px;">${proVO.pro_Name}</p>
	   			 		<c:set var="balance" value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
	   			 		 <fmt:parseNumber var="dsPrice" integerOnly="true" 
                       type="number" value="${balance}" />
	   			 		 <p class="card-footer proDiscount" style="height:10px ;">原價:${proVO.pro_Price}點</p>
	   			 		<span class="card-footer proPrice" style="height:14px;font-family: Microsoft JhengHei;color:red;">促銷價:
	   			 			<span style="color:red;font-size:20px;font-family: Microsoft JhengHei;">
	   			 			<c:out value="${dsPrice}" /></span>點</span>
	   			 		
	 			 	</div>
				</div>
			</div>
		</div>
		</c:if>
		
	 	</a>
	 	
	
	 <% 
	 	System.out.println(count);
	 	count++;
	 	
	 %>
 	</c:forEach>  	
 	
  </div>	

 
</body>

</html>