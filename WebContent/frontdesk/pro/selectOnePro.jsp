<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.pro.model.*"%>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style>
.proForm{  
    margin:20px;
    padding:0px;
	height: 500px; 
	width:550px;
}  
.proName{ 
	font-weight:900;
	font-size:30px; 
} 
.proPrice{ 
	font-size:20; 
	color:red; 
} 
.imgCont01{ 
	display:  flex; 
	align-items: center; 
	justify-content:  center; 
	max-width: 400px; 
} 
.proDiv{ 
	width:650px;
	border:3px orange double;
	margin:20px;
    padding:0px;
    height: 550px; 
}
.proDiscount{
 	font-size:16px;
 	text-decoration:line-through;
 } 
 
</style>
<script type="text/javascript">  
  
        $(document).ready(function(){ 
            $("#backPro").click(function(){
            	var proCount = $("#proCount").val()*1;
            		if(proCount>1){
            			$("#proCount").val(proCount-1);
            		}
            });	
           
            $("#addPro").click(function(){
            	var proCount = $("#proCount").val()*1; 
            	if(proCount<10){
            		$("#proCount").val(proCount+1);
            	}
      		});	
        }); 
</script>  

<script>

	

</script>

</head>
<body>
<%System.out.print(request.getServletContext()); %>>
 	<div class="proDiv">
 
	<table  class="proForm">	
		<tbody>
			<tr>
				<td rowspan="4" style="padding:16px;">
				<div class="imgCont01">
		  		  <img class="card-img-top rounded" src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}" alt="Card image cap">
			    </div>
			    </td>
			    <td><p class="proName">${proVO.pro_Name}</p></td>
			</tr>
			<tr>
				<td><p class="proInfo">
				<c:forTokens var="alpha" items="${proVO.pro_Info}" delims=",">
					<c:forEach var="person" items="${alpha}">
                       <p>✦${person}</p>
					</c:forEach>
				</c:forTokens>
				</p></td>
			</tr>
			<tr>
				<td><c:if test="${proVO.pro_Discount==100}">
	   			 	<P>　</P>
	   			 	<p class="proPrice">價格:$${proVO.pro_Price}</p>
	   			 </c:if>
	   			 <c:if test="${proVO.pro_Discount!=100}">
	   			 	<p class="proDiscount">原價:$${proVO.pro_Price}</p>
	   			 	<p class="proPrice">折扣價:$${(proVO.pro_Price)*(proVO.pro_Discount)/100}</p>
	   			 </c:if></td>
			</tr>
			
			
			<tr>
				<td>
				
				<form METHOD="post"   ACTION="<%=request.getContextPath()%>/pro/shoppingCartServlet.do" >
							
				<button type="button" id="backPro"  style="width: 30px;">-</button>
				<input type="text" id="proCount" name="proCar_Quantity" value="1"  style="width: 30px;text-align:center">	
				<button type="button" id="addPro"  style="width: 30px;">+</button>
				
						
				
						<button type="submit" class="btn btn-warning" style="width: 180px; margin:5px;margin-left:0px;font-size:20px;">放入購物車</button>
						<input type="hidden" name="proCar_No"  value="${proVO.pro_No}">
						<input type="hidden" name="proCar_Name"  value="${proVO.pro_Name}">
						<input type="hidden" name="proCar_Info"  value="${proVO.pro_Info}">
						<input type="hidden" name="proCar_Price"  value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}">
						<input type="hidden" name="action"	value="addPro">	
					</form>
				<td>
			</tr>
		</tbody>
	</table>
	
</div>	

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/proOrderServlet.do">
	<button type="submit" class="btn btn-Secondary" style="width: 180px;margin:5px; margin-left:200px;font-size:20px;">加入追蹤清單</button>
						<input type="hidden" name="pro_No"  value="${proVO.pro_No}">
						<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
						<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  
					</FORM> 

</body>
</html>