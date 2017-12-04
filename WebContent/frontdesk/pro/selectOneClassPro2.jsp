<%@page import="java.util.*"%>
<%@page import="com.pro.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	//     ProService proSvc = new ProService();
	//     List<ProVO> list = proSvc.getAll();
	//     pageContext.setAttribute("list",list);
	//     ServletContext context = getServletContext();
	//     Map<String, String> mapPro_display2 = (Map<String,String>) context.getAttribute("mapPro_display2");
	// 	String ProUp =  mapPro_display2.get("up");
	// 	System.out.println(ProUp);
%>
<jsp:useBean id="proClassSvc" scope="page"
	class="com.proclass.model.ProClassService" />




<html>
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<title>工具人出租</title>

<style>
.proName {
	color: #000;
	font-family: Microsoft JhengHei;
	font-weight: bold;
	font-size: 18px;
	height: 40px;
}

.proPrice {
	font-size: 16;
	color: red;
	font-family: Microsoft JhengHei;
	font-weight: bold;
}

.imgCont {
	display: flex;
	align-items: center;
	justify-content: center;
	max-width: 100%;
}

.proDiscount {
	color: #000;
	font-family: Microsoft JhengHei;
	font-size: 14px;
	/*  	text-decoration:line-through; */
}

.card {
	height: 220px;
	box-shadow: 4px 4px 8px 4px rgba(0, 0, 0, 0.2);
	transition: 0.3s;
	border-radius: 5px;
}

.allPro {
	marager-top: 16px;
}

.card {
	height: 220px;
	box-shadow: 4px 4px 8px 4px rgba(0, 0, 0, 0.2);
	transition: 0.3s;
	border-radius: 5px;
}

.float {
	position: fixed;
	top: 0;
	box-shadow: 4px 4px 12px 4px rgba(20%, 20%, 40%, 0.5);
	z-index: 100;
}

.breadcrumb li, .breadcrumb li a {
	color: #f90;
	font-size: 16px;
}
</style>



</head>
<body>
	<a name="aaa"></a>

	<!-- TOP -->
	<div class="col-xs-12 col-sm-12 ">
		<jsp:include page="/frontdesk/pro/proNavbar.jsp" flush="true" />
		<%-- <jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"></jsp:include> --%>
	</div>
	<!-- 商城TOP -->
	<div class="col-xs-12 col-sm-12 ">
		<jsp:include page="/frontdesk/pro/selectProTOP.jsp" flush="true" />
	</div>

	<div class="col-xs-12 col-sm-6 col-sm-offset-3">
		<!--麵包屑 -->
		<div class="col-xs-12 col-sm-12">

			<br>
			<ol class="breadcrumb">
				<li><a href="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">首頁</a></li>
				<li><a
					href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp">積分商城</a></li>
				<li class="active">商品搜尋</li>

			</ol>

		</div>




		<div style="text-align: center;">

			<c:forEach var="proVO" items="${listPro_ByCompositeQuery}">
				<a
					href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}">
					<c:if test="${proVO.pro_Status=='上架'}">
						<div class="col-xs-12 col-sm-3" style="margin: 6px; width: 23%;">
							<div class="card">
								<div class="imgCont">
									<img class="card-img-top" style="width: 100px; height: 100px;"
										src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}"
										alt="Card image cap">
								</div>



								<c:if test="${proVO.pro_Discount==90}">
									<div
										style="z-index: 3; position: absolute; left: 150px; top: -5px;">
										<img alt="" style="height: 40px; width: 40px;"
											src="<%=request.getContextPath()%>/res/images/pro_icons/d001.png">
									</div>
								</c:if>
								<c:if test="${proVO.pro_Discount==80}">
									<div
										style="z-index: 3; position: absolute; left: 150px; top: -5px;">
										<img alt="" style="height: 40px; width: 40px;"
											src="<%=request.getContextPath()%>/res/images/pro_icons/d002.png">
									</div>
								</c:if>
								<c:if test="${proVO.pro_Discount==70}">
									<div
										style="z-index: 3; position: absolute; left: 150px; top: -5px;">
										<img alt="" style="height: 40px; width: 40px;"
											src="<%=request.getContextPath()%>/res/images/pro_icons/d003.png">
									</div>
								</c:if>
								<c:if test="${proVO.pro_Discount==50}">
									<div
										style="z-index: 3; position: absolute; left: -30px; top: -20px;">
										<img alt="" style="height: 80px; width: 150px;"
											src="<%=request.getContextPath()%>/res/images/pro_icons/d005.png">
									</div>
								</c:if>



								<div class="card-body">
									<p class="card-text proName">${proVO.pro_Name}</p>
									<c:if test="${proVO.pro_Discount==100}">
										<p class="card-footer proPrice">
											價格: <span
												style="color: red; font-size: 24px; font-family: Microsoft JhengHei;">${proVO.pro_Price}</span>點
										</p>
										<P style="height: 20px;"></P>
									</c:if>


									<c:if test="${proVO.pro_Discount!=100}">
										<p class="card-footer proDiscount" style="height: 20px;text-decoration:line-through;">原價:${proVO.pro_Price}點</p>

										<c:set var="balance"
											value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
										<fmt:parseNumber var="dsPrice" integerOnly="true"
											type="number" value="${balance}" />

										<span class="card-footer proPrice"
											style="height: 14px; font-family: Microsoft JhengHei; color: red;">折扣價:
											<span
											style="color: red; font-size: 24px; font-family: Microsoft JhengHei;">
												<c:out value="${dsPrice}" />
										</span>點
										</span>
									</c:if>
								</div>
							</div>
						</div>

					</c:if>
				</a>
			</c:forEach>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<div class="col-xs-12 col-sm-12">
		<jsp:include page="/lib/publicfile/include/file/footer2.jsp"
			flush="true"></jsp:include>
	</div>
</body>
</html>