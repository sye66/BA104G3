<%@page import="java.util.*"%>
<%@page import="com.pro.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    

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
<title>商品</title>

<style>
.proDiv{
	margin:10px;
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
	top: 0;
 	box-shadow:4px 4px 12px 4px rgba(20%,20%,40%,0.5);
 	z-index: 100;
 
}
.breadcrumb li,.breadcrumb li a {
    color: #f90;
	font-size: 16px;   
}
</style>

<script>
	window.onscroll = function() {
		if ($(document).scrollTop() > 60)//这个60是距离顶部高度
		{
			$("#ontopDiv").addClass('float');//
		} else {
			$("#ontopDiv").removeClass('float');
		}
	}
	
</script>

</head>
<body>
<!--搜尋 12-->
	<div class="col-xs-12 col-sm-12 " id="ontopDiv">
		<!--搜尋 -->
		<div class="col-xs-12 col-sm-4 col-sm-offset-3">
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" name="form1">
				<table >
					<tr style="font-size:20px;text-align:center;">
			      	    <td style="width:200px;"></td>	
						<td><select size="1" name="pro_Class_No" style="height: 36px;">
         					   <option value="">分類
        					   <c:forEach var="proClassVO" items="${proClassSvc.all}" > 
        					   <option value="${proClassVO.pro_Class_No}">${proClassVO.pro_Class_Name}
        				 	   </c:forEach>   
       						</select>
						</td>
						<td>
							<input type="text" name="pro_Name" value="" placeholder="請輸入商品關鍵字" style="height: 36px;marager-top:0px;">
						</td>	
						<td>
							<button type="submit" class="btn btn-secondary" style="font-size:16px;"><img alt="" src="../res/images/pro_icons/resizeApi.png" style="height: 20px;">搜尋</button>
        					<input type="hidden" name="action" value="listPro_ByCompositeQuery">
						</td>	
					</tr>		
				</table>
			</FORM>	
		</div><!--搜尋結束 -->
		<!-- 購物車_通知 -->
		<div class="col-xs-12 col-sm-2 ">
				<span>&nbsp;&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/frontdesk/pro/cart.jsp"><img alt="購物車" src="../res/images/pro_icons/cart01.gif" style="height: 40px;"></a></span>
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>					
			<span><a href="
<%-- 				<%=request.getContextPath()%>/frontdesk/pro/cart.jsp --%>
				">
				<img alt="通知" src="../res/images/pro_icons/1183340.gif" style="height: 40px;"></a></span>					
		</div><!-- 購物車_通知 結束-->
		<div class="col-xs-12 col-sm-3"><!--空 --></div>
		
	</div><!--搜尋結束 12 -->


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
 </div></div>	
 
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
 
 
</body>
</html>