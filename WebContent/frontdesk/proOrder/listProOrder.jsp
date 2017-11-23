<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.proorder.model.*"%>
<%-- <%@ page import="javax.servlet.http.HttpSession"%> --%>
<%@ page import="com.mem.model.*"%><html>
<%@page import="java.util.*"%>


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
</style>


	
</head>
<body>

<%
	
	 
	
		List<ProOrderVO> list = (List<ProOrderVO>) session.getAttribute("proOrderlist");
		
		pageContext.setAttribute("list",list);
	
%>

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
<!-- <div class="container"> -->
			<div class="col-xs-12 col-sm-12">
				<div class="col-xs-12 col-sm-6 col-sm-offset-2">
					<h3>訂單查詢:</h3>
					<table class="table table-hover">
				
						<caption></caption>
						<thead>
							<tr>
								<th>訂單編號</th>
								<th>收件人</th>
								<th>地址</th>
								<th>電話</th>
								<th>狀態</th>
								<th>出貨日期</th>
								<th>查詢</th>
								<th>更動</th>
								
							</tr>
						</thead>
						<tbody>
						<%@ include file="page1.file" %> 
						<c:forEach var="proOrder" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
							<c:if test="${proOrder.ord_Shipinfo!='已取消' }">
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
<%-- 									<a href="<%=request.getContextPath()%>/pro/proOrdListServlet.do?action=getOneOrdList&ord_No=${proOrder.ord_No}"> --%>
<%-- 									<img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/resizeApi.png" style="width: 30px;"> --%>
<!-- 									</a> -->
									<div align="center">
         							    <form name="select" action="<%=request.getContextPath()%>/pro/proOrdListServlet.do" method="POST" >
              							<input type="hidden" name="action"  value="getOneOrdList">
              							<input type="hidden" name="ord_No"  value="${proOrder.ord_No}">
<%--               							<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> --%>
              							<input type="hidden" name="requestURL" value="<%=request.getContextPath()%>/pro/proOrderServlet.do?action=getListProOrder">
             							<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>"> 
             							<button type="submit" class="btn btn-light" id="xx"><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/resizeApi.png" style="width: 20px;"></button>
									</form></div>
								</td>
								
								<c:if test="${proOrder.ord_Shipinfo=='已出貨'}">
								<td>
								
<%-- 								<button type="submit" class="btn btn-danger disabled"><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/trash.png" style="height: 25px;">取消</button> --%>
          						</td>
								</c:if>
								
								<c:if test="${proOrder.ord_Shipinfo=='未出貨' }">
									
									<td width="100">
										<div align="center">
         							    <form name="deleteForm" action="<%=request.getContextPath()%>/pro/proOrderServlet.do" method="POST" >
              							<input type="hidden" name="action"  value="updateProOrderUp">
              							<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
              							<input type="hidden" name="ord_No"  value="${proOrder.ord_No}">
<%--               							<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> --%>
             							<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>"> 
             							<button type="submit" class="btn btn-danger" id="xx"><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/trash.png" style="height: 25px;">取消</button>
          								</form></div>
       								 </td>
								</c:if>
							</tr>
							</c:if>
						
						</c:forEach>
						
						</tbody>
					</table>
<%@include file="page2.file" %>	


				</div>		
			
<!-- 		</div> -->
<div class="col-xs-12 col-sm-2 ">
<br><br><br>		
<%if (request.getAttribute("oneOrdList")!=null){%>
       <jsp:include page="/frontdesk/proOrder/getOneOrderList.jsp" />
<%} %>
</div>	</div>		
<%-- <jsp:include page="/frontdesk/proOrder/getOneOrderList.jsp" flush="true" /> --%>
</body>
</html>