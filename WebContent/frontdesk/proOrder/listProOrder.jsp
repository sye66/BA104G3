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
#order01 tr td{
	width:300px;
	height:35px;
	font-size:20px;
	
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
%>
<jsp:useBean id="proOrdListSvc" scope="page" class="com.proordlist.model.ProOrdListService" />
<jsp:useBean id="proSvc" scope="page" class="com.pro.model.ProService" />


<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/proNavbar.jsp" flush="true"/> 
<%-- <jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"/>  --%>
</div>
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
			<h3>訂單查詢:</h3>
			

		</div>
		
			
					
					
					
					
	<div class="col-xs-12 col-sm-8 col-sm-offset-2">
		<div role="tabpanel">
			<!-- 標籤面板：標籤區 -->
			<ul class="nav nav-tabs" role="tablist" style="font-size:20px;">
				<li role="presentation" class="active">
					<a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">所有訂單</a></li>
				<li role="presentation"><a href="#tab2" aria-controls="tab2"
					role="tab" data-toggle="tab">未出貨訂單</a></li>
				<li role="presentation"><a href="#tab3" aria-controls="tab3"
					role="tab" data-toggle="tab">已取消訂單</a></li>
				<li role="presentation"><a href="#tab4" aria-controls="tab4"
					role="tab" data-toggle="tab">已退款訂單</a></li>	
			</ul>

			<!--標籤面板：內容區  -->
<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="tab1">
					
					
<div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
		  <!-- 區塊1 -->
		  <c:forEach var="proOrder" items="${list}">
		  <div class="panel panel-default" >
		    <div class="panel-heading" role="tab" id="panel1" >
		     
		    	<table id="order01">
		    		<tr>
		    			<td><a href="#${proOrder.ord_No}" data-parent="#accordion2" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="${proOrder.ord_No}">
		          			訂單編號:${proOrder.ord_No} </a></td>
		          			<c:if test="${proOrder.ord_Shipinfo=='未出貨' }"><td>&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;無</td></c:if>	
		          			<c:if test="${proOrder.ord_Shipinfo=='已取消' }"><td style="color:red;">&nbsp;&nbsp;&nbsp;等待退款</td></c:if>	
		    				<c:if test="${proOrder.ord_Shipinfo=='已退款' }"><td>&nbsp;&nbsp;&nbsp;退款日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
							<c:if test="${proOrder.ord_Shipinfo=='已出貨' }"><td>&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
		    			<td>&nbsp;&nbsp;&nbsp;狀態:${proOrder.ord_Shipinfo}</td>
		      			<td><c:if test="${proOrder.ord_Shipinfo=='未出貨' }">
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
							<tr><th>收件人</th><th>電話</th><th>地址</th><th>花費點數</th><th>更動</th></tr>
							
					
					
						<tr><td>${proOrder.ord_Consignee }</td>
						<td>${proOrder.ord_Phone }</td>
						<td>${proOrder.ord_Address }</td>
						<td><span style="color:red;">${proOrder.ord_Price }</span>點</td>
						<td>修改</td>
						</tr>
					</thead>
					<tbody id="order002">	
						<tr><th>商品名稱</th><th>商品單價</th><th>商品數量</th></tr>
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
		      			</c:if>
		      			</tr>
		      		</c:forEach>
		      	  </tbody>
		     	</table>
		      </div>
		    </div>
		</div>
	</c:forEach>
</div>
		
	</div>	
					
					
					
				
<div role="tabpanel" class="tab-pane" id="tab2">


<div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
		  <!-- 區塊2 -->
		  <c:forEach var="proOrder" items="${list}">
		  <c:if test="${proOrder.ord_Shipinfo=='未出貨' }">
		  <div class="panel panel-default" >
		    <div class="panel-heading" role="tab" id="panel1" >
		     
		    	<table id="order01">
		    		<tr>
		    			<td><a href="#${proOrder.ord_No}" data-parent="#accordion2" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="${proOrder.ord_No}">
		          			訂單編號:${proOrder.ord_No} </a></td>
		          			<c:if test="${proOrder.ord_Shipinfo=='未出貨' }"><td>&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;無</td></c:if>	
		          			<c:if test="${proOrder.ord_Shipinfo=='已取消' }"><td style="color:red;">&nbsp;&nbsp;&nbsp;等待退款</td></c:if>	
		    				<c:if test="${proOrder.ord_Shipinfo=='已退款' }"><td>&nbsp;&nbsp;&nbsp;退款日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
							<c:if test="${proOrder.ord_Shipinfo=='已出貨' }"><td>&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
		    			<td>&nbsp;&nbsp;&nbsp;狀態:${proOrder.ord_Shipinfo}</td>
		      			<td><c:if test="${proOrder.ord_Shipinfo=='未出貨' }">
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
							<tr><th>收件人</th><th>電話</th><th>地址</th><th>花費點數</th><th>更動</th></tr>
							
					
					
						<tr><td>${proOrder.ord_Consignee }</td>
						<td>${proOrder.ord_Phone }</td>
						<td>${proOrder.ord_Address }</td>
						<td><span style="color:red;">${proOrder.ord_Price }</span>點</td>
						<td>修改</td>
						</tr>
					</thead>
					<tbody id="order002">	
						<tr><th>商品名稱</th><th>商品單價</th><th>商品數量</th></tr>
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
</div>
</div>


<div role="tabpanel" class="tab-pane" id="tab3">

<div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
		  <!-- 區塊1 -->
		  <c:forEach var="proOrder" items="${list}">
		  <c:if test="${proOrder.ord_Shipinfo=='已取消' }">
		  <div class="panel panel-default" >
		    <div class="panel-heading" role="tab" id="panel1" >
		     
		    	<table id="order01">
		    		<tr>
		    			<td><a href="#${proOrder.ord_No}" data-parent="#accordion2" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="${proOrder.ord_No}">
		          			訂單編號:${proOrder.ord_No} </a></td>
		          			<c:if test="${proOrder.ord_Shipinfo=='未出貨' }"><td>&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;無</td></c:if>	
		          			<c:if test="${proOrder.ord_Shipinfo=='已取消' }"><td style="color:red;">&nbsp;&nbsp;&nbsp;等待退款</td></c:if>	
		    				<c:if test="${proOrder.ord_Shipinfo=='已退款' }"><td>&nbsp;&nbsp;&nbsp;退款日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
							<c:if test="${proOrder.ord_Shipinfo=='已出貨' }"><td>&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
		    			<td>&nbsp;&nbsp;&nbsp;狀態:${proOrder.ord_Shipinfo}</td>
		      			<td><c:if test="${proOrder.ord_Shipinfo=='未出貨' }">
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
							<tr><th>收件人</th><th>電話</th><th>地址</th><th>花費點數</th><th>更動</th></tr>
							
					
					
						<tr><td>${proOrder.ord_Consignee }</td>
						<td>${proOrder.ord_Phone }</td>
						<td>${proOrder.ord_Address }</td>
						<td><span style="color:red;">${proOrder.ord_Price }</span>點</td>
						<td>修改</td>
						</tr>
					</thead>
					<tbody id="order002">	
						<tr><th>商品名稱</th><th>商品單價</th><th>商品數量</th></tr>
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
</div>
</div>


<div role="tabpanel" class="tab-pane" id="tab4">


<div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
		  <!-- 區塊4 -->
		  <c:forEach var="proOrder" items="${list}">
		  <c:if test="${proOrder.ord_Shipinfo=='已退款' }">
		  <div class="panel panel-default" >
		    <div class="panel-heading" role="tab" id="panel1" >
		     
		    	<table id="order01">
		    		<tr>
		    			<td><a href="#${proOrder.ord_No}" data-parent="#accordion2" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="${proOrder.ord_No}">
		          			訂單編號:${proOrder.ord_No} </a></td>
		          			<c:if test="${proOrder.ord_Shipinfo=='未出貨' }"><td>&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;無</td></c:if>	
		          			<c:if test="${proOrder.ord_Shipinfo=='已取消' }"><td style="color:red;">&nbsp;&nbsp;&nbsp;等待退款</td></c:if>	
		    				<c:if test="${proOrder.ord_Shipinfo=='已退款' }"><td>&nbsp;&nbsp;&nbsp;退款日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
							<c:if test="${proOrder.ord_Shipinfo=='已出貨' }"><td>&nbsp;&nbsp;&nbsp;出貨日期:&nbsp;${proOrder.ord_Ship_Date}</td></c:if>
		    			<td>&nbsp;&nbsp;&nbsp;狀態:${proOrder.ord_Shipinfo}</td>
		      			<td><c:if test="${proOrder.ord_Shipinfo=='未出貨' }">
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
							<tr><th>收件人</th><th>電話</th><th>地址</th><th>花費點數</th><th>更動</th></tr>
							
					
					
						<tr><td>${proOrder.ord_Consignee }</td>
						<td>${proOrder.ord_Phone }</td>
						<td>${proOrder.ord_Address }</td>
						<td><span style="color:red;">${proOrder.ord_Price }</span>點</td>
						<td>修改</td>
						</tr>
					</thead>
					<tbody id="order002">	
						<tr><th>商品名稱</th><th>商品單價</th><th>商品數量</th></tr>
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
			
			
			

<div class="col-xs-12 col-sm-12">
		<jsp:include page="/lib/publicfile/include/file/footer2.jsp" flush="true"></jsp:include>
</div>
</body>
</html>