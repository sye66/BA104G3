<%@page import="java.util.*"%>
<%@page import="com.pro.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    

<%
    ProService proSvc = new ProService();
    List<ProVO> list = proSvc.getAll();
    
    pageContext.setAttribute("list",list);
//     ServletContext context = getServletContext();
//     Map<String, String> mapPro_display2 = (Map<String,String>) context.getAttribute("mapPro_display2");
// 	String ProUp =  mapPro_display2.get("up");
// 	System.out.println(ProUp);
%>
 <style>
.proDiv{
	margin:16px;
	border:3px orange double;
	height: 300px;
	margin-left:40px;
} 
.proName{
  	font-size:20px;
} 
.proPrice{
    font-size:20;
    color:red;
 }
 .imgCont{
 	 display:  flex;
     align-items: center;
     justify-content:  center;
     max-width: 110%;
 }
 .proDiscount{
 	font-size:16px;
 	text-decoration:line-through;
 }
 #ontopDiv {
    top: 0;
    width: 100%;
    height: 60px;
    background-color: #ffffff;
    padding: 15px;
    font-size: 16px;
   
}

.float {
	position:fixed;
 	box-shadow:4px 4px 12px 4px rgba(20%,20%,40%,0.5);
 	z-index: 100;
 
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
  
	<c:forEach var="proVO" items="${list}">
		<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}">
<!-- 		目前上架是寫死的 -->
		<c:if test="${proVO.pro_Status=='上架'}" >
			<div class="col-xs-12 col-sm-3 proDiv">
		     	<div class="card" style="width:100%;">
			 	    <div class="imgCont">
		  				<img class="card-img-top" style="width:100%;"  src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}" alt="Card image cap">
			   	    </div>
	  				<div class="card-body">
	   			 		<p class="card-text proName">${proVO.pro_Name}</p>
	   			 		<c:if test="${proVO.pro_Discount==100}">
	   			 			<P>　</P>
	   			 			<p class="card-footer proPrice">價格:$${proVO.pro_Price}</p>
	   			 		</c:if>
	   			 		
	   			 		<c:if test="${proVO.pro_Discount!=100}">
	   			 		<p class="card-footer proDiscount">原價:$${proVO.pro_Price}</p>
	   			 		<p class="card-footer proPrice">折扣價:$${(proVO.pro_Price)*(proVO.pro_Discount)/100}</p>
	   			 		</c:if>
	 			 	</div>
				</div>
			</div>
		
		</c:if>
	 	</a>
 	</c:forEach>  	
 	
 </div>
</div>
 
</body>
</html>