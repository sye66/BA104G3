<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.proorder.model.*"%>
<%@ page import="com.mem.model.*"%><html>
<%@page import="java.util.*"%><html>
<head>
<title>清單</title>
</head>
<body>
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
						
						<c:forEach var="proOrder" items="${list}">
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
									<a href=""><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/resizeApi.png" style="width: 30px;">
									</a>
								</td>
								
								<c:if test="${proOrder.ord_Shipinfo=='已出貨'||proOrder.ord_Shipinfo=='已取消' }">
								<td>
								
<%-- 								<button type="submit" class="btn btn-danger disabled"><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/trash.png" style="height: 25px;">取消</button> --%>
          						</td>
								</c:if>
								
								<c:if test="${proOrder.ord_Shipinfo=='未出貨' }">
									
									<td width="100"><div align="center">
         							    <form name="deleteForm" action="<%=request.getContextPath()%>/pro/proOrderServlet.do" method="POST" >
              							<input type="hidden" name="action"  value="updateProOrderUp">
              							<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
              							<input type="hidden" name="ord_No"  value="${proOrder.ord_No}">
              							<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>">
             							<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>"> 
             							<button type="submit" class="btn btn-danger" id="xx"><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/trash.png" style="height: 25px;">取消</button>
          								</form></div>
       								 </td>
								</c:if>
							</tr>
							
						
						</c:forEach>
						
						</tbody>
					</table>
</body>
</html>