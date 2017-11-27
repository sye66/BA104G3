<%@page import="java.util.*"%>
<%@page import="com.pro.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     

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

.proName{
  	font-size:22px;
  	
  	color:#000;
	font-family: Microsoft JhengHei;
	font-weight:bold;
} 
.proPrice{
   font-size:20;
    color:red;
	font-family: Microsoft JhengHei;
	font-weight:bold;
 }
 .imgCont{
 	 display:  flex;
     align-items: center;
     justify-content:  center;
     max-width: 100%;
 }
 .proDiscount{
 	color:#000;
	font-family: Microsoft JhengHei;
 	font-size:18px;
 	text-decoration:line-through;
 }
 
.card{
	width:256px;
	box-shadow: 4px 4px 8px 4px rgba(0,0,0,0.2);
    transition: 0.3s;
    border-radius: 5px;
}
.allPro{
	marager-top:16px;
	
}
</style>

<html>
<head>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
<title>工具人出租</title>
</head>
<body>

<div style="text-align:center;">

 <br><br>
  
 


  
	<c:forEach var="proVO" items="${list}">
	<div class="allPro">
		<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}">
		<c:if test="${proVO.pro_Status=='上架'}" >
			<div class="col-xs-12 col-sm-4 ">
		     	<div class="card" style="width:100%;">
			 	    <div class="imgCont">
		  				<img class="card-img-top" style="width:200px;height:200px;"  src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}" alt="Card image cap">
			   	    </div>
	  				<div class="card-body">
	   			 		<p class="card-text proName" style="height:50px;">${proVO.pro_Name}</p>
	   			 		<c:if test="${proVO.pro_Discount==100}">
	   			 			<p class="card-footer proPrice" style="height:28px;">價格:${proVO.pro_Price}點</p>
	   			 			<P style="height:28px;">　</P>
	   			 		</c:if>
	   			 		
	   			 		<c:if test="${proVO.pro_Discount!=100}">
	   			 		<p class="card-footer proDiscount" style="height:28px ;">原價:${proVO.pro_Price}點</p>
	   			 		
	   			 		 <c:set var="balance" value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
	   			 		 <fmt:parseNumber var="dsPrice" integerOnly="true" 
                       type="number" value="${balance}" />
	   			 		 
	   			 		<p class="card-footer proPrice" style="height:28px;">折扣價:<c:out value="${dsPrice}" />點</p>
	   			 		</c:if>
	   			 		
	   			 		
<%-- 	 			 	<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}" class="button orange addcar">加入購物車</a>  --%>
		
	 			 	</div>
				</div>
			</div>
		 </c:if>
	 	</a>
	 </div>
	 	
 	</c:forEach>  	
 
 </div>

 
</body>
</html>