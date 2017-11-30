<%@page import="javax.naming.Context"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.proorder.model.*"%>
<%@ page import="com.proordlist.model.*"%>
<%-- <%@ page import="javax.servlet.http.HttpSession"%> --%>
<%@ page import="com.mem.model.*"%><html>
<%@page import="java.util.*"%>


<head>
<title>訂單查詢</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>

</style>


	
</head>
<body>

<%

		ProOrderService proOrderSvc = new ProOrderService();
		List<ProOrderVO> proOrderList =(List<ProOrderVO>) proOrderSvc.getAll();
		List<ProOrderVO> list = new ArrayList<ProOrderVO>();
		for(ProOrderVO p:proOrderList){
			if((p.getOrd_Shipinfo()).equals("未出貨")||(p.getOrd_Shipinfo()).equals("已取消")){
				list.add(p);
			}
		}
		pageContext.setAttribute("list",list);
	
// 		ProOrdListService proOrdListSvc = new ProOrdListService();
// 		List<ProOrdListVO> list2 = (List<ProOrdListVO>) proOrdListSvc.getAll();
// 		pageContext.setAttribute("list2",list2);
		
// 		ServletContext context = getServletContext();
// 		Map<String, String> mapPro_display2 = (Map<String, String>) context.getAttribute("mapPro_display2");
// 		pageContext.setAttribute("mapPro_display2",mapPro_display2);
// 		String up = mapPro_display2.get("up");
// 		System.out.println(up);
%>


<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
<jsp:include page="/backdesk/pro/proBackLeft.jsp" flush="true" />


									

<!-- <div class="container"> -->
		
				<div class="col-xs-12 col-sm-8 ">
					<br>
					<h3>訂單審核:</h3>
					<table class="table table-hover" >
				
						<caption></caption>
						<thead>
							<tr>
								<th style="width:180px;text-align:left;">訂單編號</th>
								<th style="width:180px;text-align:left;">收件人</th>
								<th style="width:180px;text-align:left;">地址</th>
								<th style="width:180px;text-align:left;">電話</th>
								<th style="width:180px;text-align:left;">狀態</th>
								<th style="width:180px;text-align:left;">出貨日期</th>
								<th style="width:180px;text-align:left;">查詢</th>
								<th style="width:180px;text-align:left;">更動</th>
								
							</tr>
						</thead>
						<tbody>
						<%@ include file="page1.file" %> 
						<c:forEach var="proOrder" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
							<tr>
								<td style="width:180px;text-align:left;">${proOrder.ord_No } </td>
								<td style="width:180px;text-align:left;">${proOrder.ord_Consignee }</td>
								<td style="width:180px;text-align:left;">${proOrder.ord_Address }</td>
								<td style="width:180px;text-align:left;">${proOrder.ord_Phone }</td>
								<td style="width:180px;text-align:left;">${proOrder.ord_Shipinfo }</td>
								<td style="width:180px;text-align:left;">${proOrder.ord_Ship_Date }</td>
								
								<td style="width:180px;text-align:left;">
<%-- 									<a href="<%=request.getContextPath()%>/pro/proOrdListServlet.do?action=getOneOrdList&ord_No=${proOrder.ord_No}"> --%>
<%-- 									<img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/resizeApi.png" style="width: 30px;"> --%>
<!-- 									</a> -->
									<div align="left">
         							    <form name="select" action="<%=request.getContextPath()%>/pro/proOrdListServlet.do" method="POST" >
              							<input type="hidden" name="action"  value="getOneOrdList">
              							<input type="hidden" name="ord_No"  value="${proOrder.ord_No}">
<%--               							<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> --%>
              							<input type="hidden" name="requestURL" value="<%=request.getContextPath()%>/backdesk/proOrder/listProOrder_B2.jsp">
             							<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>"> 
             							<button type="submit" class="btn btn-light" id="xx"><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/resizeApi.png" style="width: 20px;"></button>
									</form></div>
								</td>
								
								
								
							
									<c:if test="${proOrder.ord_Shipinfo=='未出貨' }">
									<td width="100">
										<div align="left">
         							    <form name="deleteForm" action="<%=request.getContextPath()%>/pro/proOrderServlet.do" method="POST" >
              							<input type="hidden" name="action"  value="updateProOrderUp">
              							<input type="hidden" name="requestURL" value="<%=request.getContextPath()%>/backdesk/proOrder/listProOrder_B2.jsp">
              							<input type="hidden" name="ord_No"  value="${proOrder.ord_No}">
              							<input type="hidden" name="ord_Shipinfo"  value="已出貨">
             							<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>"> 
             							<button type="submit" class="btn btn-warning" >出貨</button>
          								</form></div>
       								 </td>
								</c:if>
								<c:if test="${proOrder.ord_Shipinfo=='已取消' }">
									<td width="100">
										<div align="left">
         							    <form name="deleteForm" action="<%=request.getContextPath()%>/pro/proOrderServlet.do" method="POST" >
              							<input type="hidden" name="action"  value="updateProOrderUp">
              							<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
              							<input type="hidden" name="ord_No"  value="${proOrder.ord_No}">
              							<input type="hidden" name="ord_Shipinfo"  value="已退款">
             							<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>"> 
             							<button type="submit" class="btn btn-danger" >退款</button>
          								</form></div>
       								 </td>
								</c:if>
								
							</tr>
							
						</c:forEach>
						
						</tbody>
					</table>
<%@include file="page2.file" %>	


<%if(list.size()==0){
			System.out.println(list.size());
			%>	
			<div class="col-xs-12 col-sm-6 col-sm-offset-5">
			<h3>查無資料</h3>
			</div>
		<%} %>	


				</div>		
			
		
<!-- 		</div> -->
<div class="col-xs-12 col-sm-2 ">
<br><br><br>		
<%if (request.getAttribute("oneOrdList")!=null){%>
       <jsp:include page="/frontdesk/proOrder/getOneOrderList.jsp" />
<%} %>
</div>		
<%-- <jsp:include page="/frontdesk/proOrder/getOneOrderList.jsp" flush="true" /> --%>
</body>
</html>