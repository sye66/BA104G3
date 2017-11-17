<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.proorder.model.*"%>
<%-- <%@ page import="javax.servlet.http.HttpSession"%> --%>
<%@ page import="com.mem.model.*"%><html>
<head>
<title>訂單查詢</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>

</style>

<script>
$(function(){
	$("#xx").click(event){
		alert('You clicked the button!')
		swal({
			  title: 'Are you sure?',
			  text: "You won't be able to revert this!",
			  type: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: 'Yes, delete it!'
			}).then(function (result) {
			  if (result.value) {
			    swal(
			      'Deleted!',
			      'Your file has been deleted.',
			      'success'
			    )
			  }
			})

		
		
	})
});






</script>
	
</head>
<body>

<%
	ProOrderService proOrderSvc = new ProOrderService();
// 	String mem_No1 =(String)session.getAttribute("");
	String mem_No = "M000001";	
	proOrderSvc.listProOrder(mem_No);
%>



<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-12">
					<table class="table table-hover">
					
						<caption>訂單查詢</caption>
						<thead>
							<tr>
								<th>訂單編號</th>
								<th>收件人</th>
								<th>電話</th>
								<th>地址</th>
								<th>狀態</th>
								<th>出貨日期</th>
								<th>查詢</th>
								<th>更動</th>
								
							</tr>
						</thead>
						<tbody>
						<c:forEach var="proOrder" items="${listProOrder}">
							<tr>
								<td>${proOrder.ord_No } </td>
								<td>${proOrder.ord_Consignee }</td>
								<td>${proOrder.ord_Address }</td>
								<td>${proOrder.ord_Phone }</td>
								<td>${proOrder.ord_Shipinfo }</td>
								<c:if test="${proOrder.ord_Shipinfo!='已出貨' }">
								<td>無</td>	
								</c:if>
								<c:if test="${proOrder.ord_Shipinfo=='已出貨' }">
								<td>${proOrder.ord_Ship_Date }</td>
								</c:if>
								<td>
									<img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/resizeApi.png" style="width: 30px;">
								</td>
								
								<c:if test="${proOrder.ord_Shipinfo=='已出貨'||proOrder.ord_Shipinfo=='已取消' }">
								<td><button type="submit" class="btn btn-danger disabled"><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/trash.png" style="height: 25px;">取消</button>
          								</td>
								</c:if>
								
								<c:if test="${proOrder.ord_Shipinfo=='未出貨' }">
									
									<td width="100"><div align="center">
         							    <form name="deleteForm" action="<%=request.getContextPath()%>/pro/proOrderServlet.do" method="POST" >
              							<input type="hidden" name="action"  value="updateProOrderUp">
              							<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
              							<input type="hidden" name="ord_No"  value="${proOrder.ord_No }">
              							<input type="hidden" name="ord_Shipinfo"  value="${proOrder.ord_Shipinfo}">
             							<button type="submit" class="btn btn-danger" id="xx"><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/trash.png" style="height: 25px;">取消</button>
          								</form></div>
       								 </td>
								</c:if>
							</tr>
							
						
						</c:forEach>
							
						</tbody>
					</table>



				</div>		
			</div>
		</div>

</body>
</html>