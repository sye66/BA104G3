<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.proorder.model.*"%>
<%@ page import="com.proordlist.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.pro.model.*"%>
<%@page import="java.util.*"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<% 
	MemVO memVO =(MemVO) session.getAttribute("memVO");
	String proOrdNo ="";
	if(session.getAttribute("memVO")!=null){

		String mem_No =	memVO.getMem_No();
		ProOrderService proOrderSvc = new ProOrderService();
		List<ProOrderVO> list = proOrderSvc.listProOrder(mem_No);
		ProOrderVO proOrder = list.get(0);
		proOrdNo = proOrder.getOrd_No();
		pageContext.setAttribute("proOrder",proOrder);
	}
%>

<jsp:useBean id="proOrdListSvc" scope="page" class="com.proordlist.model.ProOrdListService" />
<jsp:useBean id="proSvc" scope="page" class="com.pro.model.ProService" />

<%
	List<ProOrdListVO> proOrdList = proOrdListSvc.getOneProOrdListVO(proOrdNo);
	pageContext.setAttribute("proOrdList",proOrdList);

%>
<html>
<head>
<title>工具人出租</title>
</head>
<body>
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
		<div class="col-xs-12 col-sm-6 col-sm-offset-3">

			<br>
			<ol class="breadcrumb">
				<li><a href="<%=request.getContextPath()%>">首頁</a></li>
				<li><a href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp">積分商城</a></li>
  				<li class="breadcrumb-item active">完成訂購</li>
			

			</ol>

		</div>
		<!--麵包屑 結束-->
<!-- 進度條 -->
<div class="col-xs-12 col-sm-12">
<div class="col-xs-12 col-sm-6  col-sm-offset-3" >
		<table>
			<tr>
				<td>&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/res/images/pro_icons/resizeApi(1).png"></td>
				<td style="font-size:20px;text-align:center;height:24px;">購物車明細&nbsp;&nbsp;</td>
				<td><img src="<%=request.getContextPath()%>/res/images/pro_icons/arrows.png">&nbsp;&nbsp;</td>
				
				<td><img src="<%=request.getContextPath()%>/res/images/pro_icons/resizeApi(2).png"></td>
				<td style="font-size:20px;text-align:center;height:24px;">填寫訂單&nbsp;&nbsp;</td>
				<td><img src="<%=request.getContextPath()%>/res/images/pro_icons/arrows.png">&nbsp;&nbsp;</td>
				
				<td><img src="<%=request.getContextPath()%>/res/images/pro_icons/resizeApi(3).png" style="height:48px;width:48px;"></td>
				<td style="font-size:20px;text-align:center;height:24px;">完成訂購</td>
			</tr>
		</table>
		<br>
	</div>

</div>	
<!-- 進度條 -->
<div class="col-xs-12 col-sm-6  col-sm-offset-3">
	<table class="table table-hover">
		<tr style="background-color:#ACD6FF ;"><th>訂單編號</th><th>訂單日期</th><th>花費點數</th><th>訂單狀態</th>
		</tr>
		<tr style="background-color:#ACD6FF ;"><td>${proOrder.ord_No }</td>
			<td>${proOrder.ord_Date }</td>
			<td><span style="color:red;">${proOrder.ord_Price }</span>點</td>
			<td>${proOrder.ord_Shipinfo }</td>
		</tr>			
	
	
		<tr style="background-color:#ACD6FF ;"><th>收件人</th><th>電話</th><th>地址</th><th></th>
		</tr>
		<tr style="background-color:#ACD6FF ;"><td>${proOrder.ord_Consignee }</td>
			<td>${proOrder.ord_Phone }</td>
			<td>${proOrder.ord_Address }</td>
			<td></td>
		</tr>
		</table>
		<hr>					
		<table class="table table-hover">	
		<tr style="background-color:#ACD6FF ;"><th>商品名稱</th><th>數量</th><th>單價</th><th></th>
		</tr>
		<c:forEach var="proOrdListVO" items="${proOrdList}">
			<tr style="background-color:#ACD6FF ;">
			<c:forEach var="proVO" items="${proSvc.all}">
			<c:if test="${proOrdListVO.pro_No==proVO.pro_No }">
			<td>${proVO.pro_Name }</td>
			</c:if>
			</c:forEach>
			<td>${proOrdListVO.ordPro_Count }</td>
			<td>${proOrdListVO.ordPro_Price}</td>
			<td></td>
			
		</tr>
		
		</c:forEach>	
	</table>	

</div>
<div class="col-xs-12 col-sm-6  col-sm-offset-3">
<br><br><br><br>
<table>
	
	<tr>
		<td ><a href="<%=request.getContextPath()%>/frontdesk/getmission/getMission.jsp" style="color:000;">
			<button type="button" class="btn btn-success" 
			style="width:200px;height:50px;font-size:26px;color:000;">
			去接任務</button></a></td>
		<td width="120"></td>
		<td ><a href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp" style="color:000;">
			<button type="button" class="btn btn-warning" 
			style="width:200px;height:50px;font-size:26px;color:000;">繼續購物</button></a></td>
	
	</tr>




</table>

</div>















<div class="col-xs-12 col-sm-12">
<br><br><br><br><br><br>
		<jsp:include page="/lib/publicfile/include/file/footer2.jsp" flush="true"></jsp:include>
</div>
</body>
</html>