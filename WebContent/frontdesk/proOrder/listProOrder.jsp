<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.proorder.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.proordlist.model.*"%>
<%@ page import="com.pro.model.*"%>
<%@page import="java.util.*"%>

<html>
<head>
<title>訂單查詢</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
.breadcrumb li, .breadcrumb li a {
	color: #f90;
	font-size: 16px;
}

.orderTop{
	font-size:24px;
	color:#000;
	font-family: Microsoft JhengHei;
	font-weight:bold;
	border:3px;
}
.orderTop:hover{
	color:	#FF9224;
}

.ss{
	border:3px;
}

/* 沒用 */
nav-tabs li a:focus{ 
   color:	#FF9224;
} 


#order01 tr td{
	
	height:35px;
	font-size:20px;
	
}
.ord_No{
	
	width:300px;
}
.ord_Ship_Date , .ord_Date{
	width:250px;
}
.ord_Shipinfo{
	width:223px;
}



#order001{
	background-color: 	#D2E9FF;
}
#order002{
	background-color: #ECFFFF;
}
#order002 td{
	width:250px;
}



</style>


	
</head>
<body>

<%
		List<ProOrderVO> list = (List<ProOrderVO>) session.getAttribute("proOrderlist");
		pageContext.setAttribute("list",list);
		int a = 0;
		int b = 0;
		int c = 0;
		int d = 0;
%>
<jsp:useBean id="proOrdListSvc" scope="page" class="com.proordlist.model.ProOrdListService" />
<jsp:useBean id="proSvc" scope="page" class="com.pro.model.ProService" />

<div class="row">
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/proNavbar.jsp" flush="true"/> 
<%-- <jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"/>  --%>
</div></div>
<!-- 商城TOP -->
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/selectProTOP.jsp" flush="true" />	

</div>
<!--麵包屑 -->
		<div class="col-xs-12 col-sm-8 col-sm-offset-2">

			<br>
			<ol class="breadcrumb">
				<li><a href="<%=request.getContextPath()%>">首頁</a></li>
				<li><a href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp">積分商城</a></li>
				<li class="active">個人訂單
				</li>

			</ol>

		</div>
		<!--麵包屑 結束-->
		
		<div class="col-xs-12 col-sm-8 col-sm-offset-2" >
			<h2>訂單查詢:</h2>
			

		</div>
		
			
					
					
					
					
	<div class="col-xs-12 col-sm-8 col-sm-offset-2">
		<div role="tabpanel" class="ss">
			<!-- 標籤面板：標籤區 -->
			<ul class="nav nav-tabs" role="tablist" >
				<li role="presentation" class="active">
					<a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab" 
						class="orderTop">所有訂單</a></li>
				<li role="presentation"><a href="#tab2" aria-controls="tab2"
					class="orderTop" role="tab" data-toggle="tab">未出貨訂單</a></li>
				<li role="presentation"><a href="#tab3" aria-controls="tab3"
					class="orderTop" role="tab" data-toggle="tab">已取消訂單</a></li>
				<li role="presentation"><a href="#tab4" aria-controls="tab4"
					class="orderTop" role="tab" data-toggle="tab">已退款訂單</a></li>	
			</ul>

			<!--標籤面板：內容區  -->
<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="tab1">
					
					
<div class="panel-group" id="accordion1" role="tablist" aria-multiselectable="true">
		  <!-- 區塊1 -->
		  <c:forEach var="proOrder" items="${list}">
		  <div class="panel panel-default" >
		    <div class="panel-heading" role="tab" id="panel1" style="padding:1px;">
		     
		    	<table id="order01">
		    		
		    		<c:if test="${proOrder.ord_Shipinfo=='未出貨' }"><tr style="background-color:#FFF8D7 ;"></c:if>	
		          	<c:if test="${proOrder.ord_Shipinfo=='已取消' }"><tr style="background-color:#FFD2D2 ;"></c:if>	
		    		<c:if test="${proOrder.ord_Shipinfo=='已退款' }"><tr style="background-color:#D2E9FF ;"></c:if>
					<c:if test="${proOrder.ord_Shipinfo=='已出貨' }"><tr style="background-color:#E8FFC4 ;"></c:if>
		    		
		    		 <%a++ ;%>
		    		
		    			<td class="ord_No"><a href="#${proOrder.ord_No}1" data-parent="#accordion1" 
		    			    data-toggle="collapse" role="button" aria-expanded="true" 
		    			    aria-controls="${proOrder.ord_No}1" style="color:#2828FF;">
		          			訂單編號:${proOrder.ord_No}&nbsp;&nbsp;</a></td>
		          		<td class="ord_Date">訂單日期:${proOrder.ord_Date}</td>	
		          			<c:if test="${proOrder.ord_Shipinfo=='未出貨' }"><td class="ord_Ship_Date">&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;無</td></c:if>	
		          			<c:if test="${proOrder.ord_Shipinfo=='已取消' }"><td class="ord_Ship_Date" style="color:red;">&nbsp;&nbsp;&nbsp;等待退款</td></c:if>	
		    				<c:if test="${proOrder.ord_Shipinfo=='已退款' }"><td class="ord_Ship_Date">&nbsp;&nbsp;&nbsp;退款日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
							<c:if test="${proOrder.ord_Shipinfo=='已出貨' }"><td class="ord_Ship_Date">&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
		    			<td class="ord_Shipinfo">&nbsp;&nbsp;&nbsp;狀態:${proOrder.ord_Shipinfo}</td>
		      			<td class="ord_Shipinfo"><c:if test="${proOrder.ord_Shipinfo=='未出貨' }">
							
							<form  name="deleteForm" action="<%=request.getContextPath()%>/pro/proOrderServlet.do" method="POST" >
              				<input type="hidden" name="action"  value="updateProOrderUp">
              				<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
              				<input type="hidden" name="ord_No"  value="${proOrder.ord_No}">
              				<input type="hidden" name="ord_Shipinfo" value="已取消">
             				<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>"> 
             				
             				<div style="text-align: center;vertical-align: middle;">
             				<button type="submit" class="btn btn-danger">取消</button>
             			
             				</div>
             				</form>
             				</c:if></td>
		    		</tr>
		    	</table>
		    </div>
		    
		    <div id="${proOrder.ord_No }1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel1">
		      <div class="panel-body">
		      <table class="table table-hover">
					<thead id="order001">
							<tr><th>收件人</th><th>電話</th><th>地址</th><th>總花費點數</th>
<!-- 							<th>更動</th> -->
							</tr>
							
					
					
						<tr><td>${proOrder.ord_Consignee }</td>
						<td>${proOrder.ord_Phone }</td>
						<td>${proOrder.ord_Address }</td>
						<td>總共<span style="color:red;">${proOrder.ord_Price }</span>點</td>
<!-- 						<td>修改</td> -->
						</tr>
					</thead>
				
					<tbody id="order002">	
						<tr><th>商品名稱</th><th>商品單價</th><th>商品數量</th><th>小計</th></tr>
		      		<c:forEach var="proOrdListVO" items="${proOrdListSvc.all}">	
		      			<tr>
		      			<c:if test="${proOrdListVO.ord_No==proOrder.ord_No }">
		      				<c:forEach var="proVO" items="${proSvc.all}">
		      					<c:if test="${proVO.pro_No==proOrdListVO.pro_No}">
									<td>${proVO.pro_Name }</td>		      					
		      					</c:if>
		      				</c:forEach>	
		      				<td>${proOrdListVO.ordPro_Price}</td>
		      				<td>${proOrdListVO.ordPro_Count }</td>
		      				<td><span style="color:red;">${proOrdListVO.ordPro_Price*proOrdListVO.ordPro_Count}</span>點</td>
		      			</c:if>
		      			</tr>
		      		</c:forEach>
		      	  </tbody>
		     	</table>
		      </div>
		    </div>
		</div>
	</c:forEach>
	<br><br><br><br><br><br>
	<c:if test="<%=a==0 %>">
		  	<div class="col-xs-12 col-sm-6 col-sm-offset-5" >
		  	<br>
		  	<h2>無訂單資料</h2>
		  	<br><br><br><br><br><br>
		  	</div>
	</c:if>
	
	
	
</div>
		
	</div>	
					
					
					
				
<div role="tabpanel" class="tab-pane" id="tab2">


<div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
		  <!-- 區塊2 -->
		  <c:forEach var="proOrder" items="${list}">
		  <c:if test="${proOrder.ord_Shipinfo=='未出貨' }">
		   <%b++;%>
		  
		  <div class="panel panel-default" >
		    <div class="panel-heading" role="tab" id="panel1" style="padding:1px;">
		     
		    	<table id="order01">
		    		<tr style="background-color:#FFF8D7 ;">
		    			<td class="ord_No"><a href="#${proOrder.ord_No}2" style="color:#2828FF;" data-parent="#accordion2" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="${proOrder.ord_No}2">
		          			訂單編號:${proOrder.ord_No} </a></td>
		          		<td class="ord_Date">訂單日期:${proOrder.ord_Date}</td>	
		          			<c:if test="${proOrder.ord_Shipinfo=='未出貨' }"><td class="ord_Ship_Date">&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;無</td></c:if>	
		          			<c:if test="${proOrder.ord_Shipinfo=='已取消' }"><td class="ord_Ship_Date" style="color:red;">&nbsp;&nbsp;&nbsp;等待退款</td></c:if>	
		    				<c:if test="${proOrder.ord_Shipinfo=='已退款' }"><td class="ord_Ship_Date">&nbsp;&nbsp;&nbsp;退款日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
							<c:if test="${proOrder.ord_Shipinfo=='已出貨' }"><td class="ord_Ship_Date">&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
		    			<td class="ord_Shipinfo">&nbsp;&nbsp;&nbsp;狀態:${proOrder.ord_Shipinfo}</td>
		      			<td class="ord_Shipinfo"><c:if test="${proOrder.ord_Shipinfo=='未出貨' }">
							<form name="deleteForm" action="<%=request.getContextPath()%>/pro/proOrderServlet.do" method="POST" >
              				<input type="hidden" name="action"  value="updateProOrderUp">
              				<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
              				<input type="hidden" name="ord_No"  value="${proOrder.ord_No}">
              				<input type="hidden" name="ord_Shipinfo" value="已取消">
             				<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>"> 
             				<button type="submit" class="btn btn-danger"  style="marager-bottom:0px;">取消</button>
             				</form></c:if></td>
		    		</tr>
		    	</table>
		    </div>
		    
		    <div id="${proOrder.ord_No}2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel1">
		      <div class="panel-body">
		      <table class="table table-hover">
					<thead id="order001">
							<tr><th>收件人</th><th>電話</th><th>地址</th><th>花費點數</th>
<!-- 							<th>更動</th> -->
							</tr>
							
					
					
						<tr><td>${proOrder.ord_Consignee }</td>
						<td>${proOrder.ord_Phone }</td>
						<td>${proOrder.ord_Address }</td>
						<td><span style="color:red;">${proOrder.ord_Price }</span>點</td>
<!-- 						<td>修改</td> -->
						</tr>
					</thead>
					<tbody id="order002">	
						<tr><th>商品名稱</th><th>商品單價</th><th>商品數量</th><th></th></tr>
		      		<c:forEach var="proOrdListVO" items="${proOrdListSvc.all}">	
		      			<tr>
		      			<c:if test="${proOrdListVO.ord_No==proOrder.ord_No }">
		      				<c:forEach var="proVO" items="${proSvc.all}">
		      					<c:if test="${proVO.pro_No==proOrdListVO.pro_No}">
									<td>${proVO.pro_Name }</td>		      					
		      					</c:if>
		      				</c:forEach>	
		      				<td>${proOrdListVO.ordPro_Price}</td>
		      				<td>${proOrdListVO.ordPro_Count }</td>
		      				<td></td>
		      			</c:if>
		      			</tr>
		      		</c:forEach>
		      	  </tbody>
		     	</table>
		      </div>
		    </div>
		</div>
		</c:if>
	</c:forEach>
	<br><br><br><br><br><br>
	<c:if test="<%=b==0 %>">
		  	<div class="col-xs-12 col-sm-6 col-sm-offset-5" >
		  	<br>
		  	<h2>無訂單資料</h2>
		  	<br><br><br><br><br><br>
		  	</div>
	</c:if>
	
	
	
</div>
</div>


<div role="tabpanel" class="tab-pane" id="tab3">

<div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
		  <!-- 區塊3 -->
		  <c:forEach var="proOrder" items="${list}">
		  <c:if test="${proOrder.ord_Shipinfo=='已取消' }">
		  <%c++; %>
		  
		  <div class="panel panel-default" >
		    <div class="panel-heading" role="tab" id="panel1" style="padding:1px;">
		     
		    	<table id="order01">
		    		<tr style="background-color:#FFD2D2 ;">
		    			<td class="ord_No"><a href="#${proOrder.ord_No}3" style="color:#2828FF;" data-parent="#accordion2" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="${proOrder.ord_No}3">
		          			訂單編號:${proOrder.ord_No}</a></td>
		          		<td class="ord_Date">訂單日期:${proOrder.ord_Date}</td>	
		          			<c:if test="${proOrder.ord_Shipinfo=='未出貨' }"><td class="ord_Ship_Date">&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;無</td></c:if>	
		          			<c:if test="${proOrder.ord_Shipinfo=='已取消' }"><td class="ord_Ship_Date" style="color:red;">&nbsp;&nbsp;&nbsp;等待退款</td></c:if>	
		    				<c:if test="${proOrder.ord_Shipinfo=='已退款' }"><td class="ord_Ship_Date">&nbsp;&nbsp;&nbsp;退款日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
							<c:if test="${proOrder.ord_Shipinfo=='已出貨' }"><td class="ord_Ship_Date">&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
		    			<td class="ord_Shipinfo">&nbsp;&nbsp;&nbsp;狀態:${proOrder.ord_Shipinfo}</td>
		      			<td class="ord_Shipinfo"><c:if test="${proOrder.ord_Shipinfo=='未出貨' }">
							<form name="deleteForm" action="<%=request.getContextPath()%>/pro/proOrderServlet.do" method="POST" >
              				<input type="hidden" name="action"  value="updateProOrderUp">
              				<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
              				<input type="hidden" name="ord_No"  value="${proOrder.ord_No}">
              				<input type="hidden" name="ord_Shipinfo" value="已取消">
             				<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>"> 
             				<button type="submit" class="btn btn-danger"  style="marager-bottom:0px;">取消</button>
             				</form></c:if></td>
		    		</tr>
		    	</table>
		    </div>
		    
		    <div id="${proOrder.ord_No}3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel1">
		      <div class="panel-body">
		      <table class="table table-hover">
					<thead id="order001">
							<tr><th>收件人</th><th>電話</th><th>地址</th><th>花費點數</th>
<!-- 							<th>更動</th> -->
							</tr>
							
					
					
						<tr><td>${proOrder.ord_Consignee }</td>
						<td>${proOrder.ord_Phone }</td>
						<td>${proOrder.ord_Address }</td>
						<td><span style="color:red;">${proOrder.ord_Price }</span>點</td>
<!-- 						<td>修改</td> -->
						</tr>
					</thead>
					<tbody id="order002">	
						<tr><th>商品名稱</th><th>商品單價</th><th>商品數量</th><th></th></tr>
		      		<c:forEach var="proOrdListVO" items="${proOrdListSvc.all}">	
		      			<tr>
		      			<c:if test="${proOrdListVO.ord_No==proOrder.ord_No }">
		      				<c:forEach var="proVO" items="${proSvc.all}">
		      					<c:if test="${proVO.pro_No==proOrdListVO.pro_No}">
									<td>${proVO.pro_Name }</td>		      					
		      					</c:if>
		      				</c:forEach>	
		      				<td>${proOrdListVO.ordPro_Price}</td>
		      				<td>${proOrdListVO.ordPro_Count }</td>
		      				<td></td>
		      			</c:if>
		      			</tr>
		      		</c:forEach>
		      	  </tbody>
		     	</table>
		      </div>
		    </div>
		</div>
		</c:if>
	</c:forEach>
	<br><br><br><br><br><br>
	
	<c:if test="<%=c==0 %>">
		  	<div class="col-xs-12 col-sm-6 col-sm-offset-5" >
		  	<br>
		  	<h2>無訂單資料</h2>
		  	<br><br><br><br><br><br>
		  	</div>
	</c:if>
</div>
</div>


<div role="tabpanel" class="tab-pane" id="tab4">


<div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
		  <!-- 區塊4 -->
		  <c:forEach var="proOrder" items="${list}">
		  <c:if test="${proOrder.ord_Shipinfo=='已退款' }">
		 	<%c++ ;%>
		  
		  
		  <div class="panel panel-default" >
		    <div class="panel-heading" role="tab" id="panel1" style="padding:1px;">
		     
		    	<table id="order01">
		    		<tr style="background-color:#D2E9FF ;">
		    			<td class="ord_No"><a href="#${proOrder.ord_No}" style="color:#2828FF;" data-parent="#accordion2" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="${proOrder.ord_No}">
		          			訂單編號:${proOrder.ord_No} </a></td>
		          		<td class="ord_Date">訂單日期:${proOrder.ord_Date}</td>	
		          			<c:if test="${proOrder.ord_Shipinfo=='未出貨' }"><td class="ord_Ship_Date">&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;無</td></c:if>	
		          			<c:if test="${proOrder.ord_Shipinfo=='已取消' }"><td class="ord_Ship_Date"style="color:red;">&nbsp;&nbsp;&nbsp;等待退款</td></c:if>	
		    				<c:if test="${proOrder.ord_Shipinfo=='已退款' }"><td class="ord_Ship_Date">&nbsp;&nbsp;&nbsp;退款日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
							<c:if test="${proOrder.ord_Shipinfo=='已出貨' }"><td class="ord_Ship_Date">&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
		    			<td class="ord_Shipinfo">&nbsp;&nbsp;&nbsp;狀態:${proOrder.ord_Shipinfo}</td>
		      			<td class="ord_Shipinfo"><c:if test="${proOrder.ord_Shipinfo=='未出貨' }">
							<form name="deleteForm" action="<%=request.getContextPath()%>/pro/proOrderServlet.do" method="POST" >
              				<input type="hidden" name="action"  value="updateProOrderUp">
              				<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
              				<input type="hidden" name="ord_No"  value="${proOrder.ord_No}">
              				<input type="hidden" name="ord_Shipinfo" value="已取消">
             				<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>"> 
             				<button type="submit" class="btn btn-danger"  style="marager-bottom:0px;">取消</button>
             				</form></c:if></td>
		    		</tr>
		    	</table>
		    </div>
		    
		    <div id="${proOrder.ord_No }" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel1">
		      <div class="panel-body">
		      <table class="table table-hover">
					<thead id="order001">
							<tr><th>收件人</th><th>電話</th><th>地址</th><th>花費點數</th>
							<th></th>
							</tr>
							
					
					
						<tr><td>${proOrder.ord_Consignee }</td>
						<td>${proOrder.ord_Phone }</td>
						<td>${proOrder.ord_Address }</td>
						<td><span style="color:red;">${proOrder.ord_Price }</span>點</td>
						<td></td>
						</tr>
					</thead>
					<tbody id="order002">	
						<tr><th>商品名稱</th><th>商品單價</th><th>商品數量</th><th></th></tr>
		      		<c:forEach var="proOrdListVO" items="${proOrdListSvc.all}">	
		      			<tr>
		      			<c:if test="${proOrdListVO.ord_No==proOrder.ord_No }">
		      				<c:forEach var="proVO" items="${proSvc.all}">
		      					<c:if test="${proVO.pro_No==proOrdListVO.pro_No}">
									<td>${proVO.pro_Name }</td>		      					
		      					</c:if>
		      				</c:forEach>	
		      				<td>${proOrdListVO.ordPro_Price}</td>
		      				<td>${proOrdListVO.ordPro_Count }</td>
		      				<td></td>
		      			</c:if>
		      			</tr>
		      		</c:forEach>
		      	  </tbody>
		     	</table>
		      </div>
		    </div>
		</div>
		</c:if>
	</c:forEach>
	<br><br><br><br><br><br>
	
	<c:if test="<%=d==0 %>">
		  	<div class="col-xs-12 col-sm-6 col-sm-offset-5" >
		  	<br>
		  	<h2>無訂單資料</h2>
		  	<br><br><br><br><br><br>
		  	</div>
		  </c:if>
	
</div>
</div>





</div>
</div>
</div>		
			
			
			<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script>
		    $(function(){
		        $('[data-toggle="tooltip"]').tooltip();
		    })
		</script>

		<script>
		    $(function(){
		        $('[data-toggle="popover"]').popover({
		        	html:true
		        });
		    })
		</script>			
		<script>
		    $(function(){
		      
		    	
		    	
		    	
		    })
		</script>				
			
			

<div class="col-xs-12 col-sm-12">
		<jsp:include page="/lib/publicfile/include/file/footer2.jsp" flush="true"></jsp:include>
</div>
</body>
</html>