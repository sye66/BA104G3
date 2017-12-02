<%@page import="java.util.*"%>
<%@page import="com.pro.model.*"%>
<%@page import="com.mem.model.*"%>
<%@page import="com.protrack.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     

<%
    ProService proSvc = new ProService();
    List<ProVO> list = proSvc.getAll();
    pageContext.setAttribute("list",list);
    
    
    MemVO memVO = (MemVO)session.getAttribute("memVO");
		if(session.getAttribute("memVO")!=null){
		String mem_No = memVO.getMem_No();
		ProTrackService proTrackSvc = new ProTrackService();
		List<ProTrackVO> list2 = proTrackSvc.getOnePro(mem_No);
		pageContext.setAttribute("list2",list2);
		}
		
   
    
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
	box-shadow: 4px 4px 8px 4px rgba(0,0,256,0.2);
    transition: 0.3s;
    border-radius: 10px;
    
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
		
		<c:if test="${proVO.pro_Status=='上架'}" >
		
			<div class="col-xs-12 col-sm-4 " class="ccc">
				<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}" style="text-decoration:none;">
		     		<div class="card " >
			 		    <div class="imgCont proDiv">
		  					<img class="card-img-top" style="width:150px;height:150px;"  src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}" alt="Card image cap">
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
		
	 			 	</div>
				</div>
				</a>
			
			<c:forEach var="proTrackVO" items="${list2}">
			   	    		<c:if test="${proVO.pro_No==proTrackVO.pro_No}">
			   	    			<div style="z-index:3;position:absolute;left:30px;  top:10px;">
			   	    			<img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/heart.png"
									style="width: 40px;border-radius: 3px;  "></div>
	  						</c:if>
	  					</c:forEach>
	  					
			</div>
		 </c:if>
	 </div>
 	</c:forEach>  	
 </div>
<script src="https://code.jquery.com/jquery.js"></script>
<script type="text/javascript">
$(function(){
	$(".ccc").hover(function(event){
	
			alert(123)
			
			
		});
	});
	
</script>


 
</body>
</html>