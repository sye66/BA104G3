<%@page import="java.util.*"%>
<%@page import="com.pro.model.*"%>
<%@page import="com.proclass.model.*"%>
<%@page import="com.mem.model.*"%>
<%@page import="com.protrack.model.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%
	
	Set<ProVO> p01 = new HashSet<ProVO>();
	Set<ProVO> p02 = new HashSet<ProVO>();
	Set<ProVO> p03 = new HashSet<ProVO>();
	Set<ProVO> p04 = new HashSet<ProVO>();
	Set<ProVO> p05 = new HashSet<ProVO>();
	Set<ProVO> p06 = new HashSet<ProVO>();
	Set<ProVO> p07 = new HashSet<ProVO>();
	Set<ProVO> p08 = new HashSet<ProVO>();
	Set<ProVO> p09 = new HashSet<ProVO>();
	Set<ProVO> p10 = new HashSet<ProVO>();
	ProService proSvc = new ProService();
	List<ProVO> list = proSvc.getAll();
	for(ProVO p:list){
	  if(p.getPro_Status().equals("上架")){
		if(p.getPro_Class_No().equals("C0001")){
			p01.add(p);
		}
		if(p.getPro_Class_No().equals("C0002")){
			p02.add(p);
		}
		if(p.getPro_Class_No().equals("C0003")){
			p03.add(p);
		}
		if(p.getPro_Class_No().equals("C0004")){
			p04.add(p);
		}
		if(p.getPro_Class_No().equals("C0005")){
			p05.add(p);
		}
		if(p.getPro_Class_No().equals("C0006")){
			p06.add(p);
		}
		if(p.getPro_Class_No().equals("C0007")){
			p07.add(p);
		}
		if(p.getPro_Class_No().equals("C0008")){
			p08.add(p);
		}
		if(p.getPro_Class_No().equals("C0009")){
			p09.add(p);
		}
		if(p.getPro_Class_No().equals("C0010")){
			p10.add(p);
		}
	  }	
	}
	
	pageContext.setAttribute("p01", p01);
	pageContext.setAttribute("p02", p02);
	pageContext.setAttribute("p03", p03);
	pageContext.setAttribute("p04", p04);
	pageContext.setAttribute("p05", p05);
	pageContext.setAttribute("p06", p06);
	pageContext.setAttribute("p07", p07);
	pageContext.setAttribute("p08", p08);
	pageContext.setAttribute("p09", p09);
	pageContext.setAttribute("p10", p10);

	MemVO memVO = (MemVO) session.getAttribute("memVO");
	if (session.getAttribute("memVO") != null) {
		String mem_No = memVO.getMem_No();
		ProTrackService proTrackSvc = new ProTrackService();
		List<ProTrackVO> list2 = proTrackSvc.getOnePro(mem_No);
		pageContext.setAttribute("list2", list2);
	}

	//     ServletContext context = getServletContext();
	//     Map<String, String> mapPro_display2 = (Map<String,String>) context.getAttribute("mapPro_display2");
	// 	String ProUp =  mapPro_display2.get("up");
	// 	System.out.println(ProUp);
%>
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
</style>

<html>
<head>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
<title>工具人出租</title>
</head>
<body>

	





	<!--  </div> -->


	<div role="tabpanel" style="border: 5px solid #FF8000">
		<!-- 			標籤面板：標籤區 -->
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active" >
			<a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab"><h4>食品</h4></a></li>
			<li role="presentation">
			<a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab"><h4>3C產品</h4></a></li>
			<li role="presentation"><a href="#tab3" aria-controls="tab3"
				role="tab" data-toggle="tab"><h4>運動</h4></a></li>
			<li role="presentation"><a href="#tab4" aria-controls="tab4"
				role="tab" data-toggle="tab"><h4>餐卷</h4></a></li>
			<li role="presentation"><a href="#tab5" aria-controls="tab5"
				role="tab" data-toggle="tab"><h4>圖書</h4></a></li>
		</ul>

		<!-- 標籤面板：內容區 -->

		<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="tab1" style="background-color :#f0f0f0">
				<table class="table table-hover"
					style="font-size: 16px; border: 10px solid red">
					<tbody>
						<tr>

							<c:forEach var="proVO" items="${p01}" end="3">
								<div class="allPro">
										
												<div class="col-xs-12 col-sm-3 "
													style="margin: 6px; width: 23%;">
													
													
													<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}"
														style="text-decoration: none;">
														<div class="card " style="background-color: #fff;">
															<div class="imgCont ">
																<img class="card-img-top"
																	style="width: 100px; height: 100px;"
																	src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}"
																	alt="Card image cap">
															</div>
															<div class="card-body" style="text-align:center;">
																<p class="card-text proName">${proVO.pro_Name}</p>
																<c:if test="${proVO.pro_Discount==100}">
																	<p class="card-footer proPrice">價格:
																	<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">${proVO.pro_Price}</span>點</p>
																	<P style="height: 20px;"></P>
																</c:if>

																<c:if test="${proVO.pro_Discount!=100}">
																	<p class="card-footer proDiscount"
																		style="height: 20px;">原價:${proVO.pro_Price}點</p>

																	<c:set var="balance"
																		value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
																	<fmt:parseNumber var="dsPrice" integerOnly="true"
																		type="number" value="${balance}" />

																	<span class="card-footer proPrice" style="height:14px;font-family: Microsoft JhengHei;color:red;">折扣價:
	   			 													<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">
	   			 													<c:out value="${dsPrice}" /></span>點</span>
																</c:if>
																<c:if test="${proVO.pro_Discount==90}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d001.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==80}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d002.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==70}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d003.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==50}">
																	<div style="z-index:3;position:absolute;left:100px;  top:-10px;">
																		<img alt="" style="height:50px;width:100px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d005.png">
																	</div>
																</c:if>
															</div>
														</div>
													</a>

													<c:forEach var="proTrackVO" items="${list2}">
														<c:if test="${proVO.pro_No==proTrackVO.pro_No}">
															<div
																style="z-index: 3; position: absolute; left: 40px; top:70px;">
																<img alt=""
																	src="<%=request.getContextPath()%>/res/images/pro_icons/heart.png"
																	style="width: 30px; border-radius: 3px;">
															</div>
														</c:if>
													</c:forEach>
												</div>
								</div>
							</c:forEach>
						
						</tr>
					</tbody>
				</table>
			</div>
			<div role="tabpanel" class="tab-pane" id="tab2" style="background-color :#f0f0f0">
					<table class="table table-hover"
					style="font-size: 16px; border: 2px solid #CCC">
					<tbody>
						<tr>

							<c:forEach var="proVO" items="${p02}" end="3">
								<div class="allPro">
										
												<div class="col-xs-12 col-sm-3 "
													style="margin: 6px; width: 23%;">
													
													
													<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}"
														style="text-decoration: none;">
														<div class="card " style="background-color: #fff;">
															<div class="imgCont ">
																<img class="card-img-top"
																	style="width: 100px; height: 100px;"
																	src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}"
																	alt="Card image cap">
															</div>
															<div class="card-body" style="text-align:center;">
																<p class="card-text proName">${proVO.pro_Name}</p>
																<c:if test="${proVO.pro_Discount==100}">
																	<p class="card-footer proPrice">價格:
																	<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">${proVO.pro_Price}</span>點</p>
																	<P style="height: 20px;"></P>
																</c:if>

																<c:if test="${proVO.pro_Discount!=100}">
																	<p class="card-footer proDiscount"
																		style="height: 20px;">原價:${proVO.pro_Price}點</p>

																	<c:set var="balance"
																		value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
																	<fmt:parseNumber var="dsPrice" integerOnly="true"
																		type="number" value="${balance}" />

																	<span class="card-footer proPrice" style="height:14px;font-family: Microsoft JhengHei;color:red;">折扣價:
	   			 													<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">
	   			 													<c:out value="${dsPrice}" /></span>點</span>
																</c:if>

																
																<c:if test="${proVO.pro_Discount==90}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d001.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==80}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d002.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==70}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d003.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==50}">
																	<div style="z-index:3;position:absolute;left:100px;  top:-10px;">
																		<img alt="" style="height:50px;width:100px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d005.png">
																	</div>
																</c:if>
																
															</div>
														</div>
													</a>

													<c:forEach var="proTrackVO" items="${list2}">
														<c:if test="${proVO.pro_No==proTrackVO.pro_No}">
															<div
																style="z-index: 3; position: absolute; left: 40px; top:70px;">
																<img alt=""
																	src="<%=request.getContextPath()%>/res/images/pro_icons/heart.png"
																	style="width: 30px; border-radius: 3px;">
															</div>
														</c:if>
													</c:forEach>
											
												</div>
											

								</div>
							</c:forEach>
						
						</tr>
					</tbody>
				</table>
			</div>
			<div role="tabpanel" class="tab-pane" id="tab3" style="background-color :#f0f0f0">
					<table class="table table-hover"
					style="font-size: 16px; border: 2px solid #CCC">
					<tbody>
						<tr>

							<c:forEach var="proVO" items="${p03}" end="3">
								<div class="allPro">
									<c:if test="${proVO.pro_Status=='上架'}">
										
												<div class="col-xs-12 col-sm-3 "
													style="margin: 6px; width: 23%;">
													
													
													<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}"
														style="text-decoration: none;">
														<div class="card " style="background-color: #fff;">
															<div class="imgCont ">
																<img class="card-img-top"
																	style="width: 100px; height: 100px;"
																	src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}"
																	alt="Card image cap">
															</div>
															<div class="card-body" style="text-align:center;">
																<p class="card-text proName">${proVO.pro_Name}</p>
																<c:if test="${proVO.pro_Discount==100}">
																	<p class="card-footer proPrice">價格:
																	<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">${proVO.pro_Price}</span>點</p>
																	<P style="height: 20px;"></P>
																</c:if>

																<c:if test="${proVO.pro_Discount!=100}">
																	<p class="card-footer proDiscount"
																		style="height: 20px;">原價:${proVO.pro_Price}點</p>

																	<c:set var="balance"
																		value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
																	<fmt:parseNumber var="dsPrice" integerOnly="true"
																		type="number" value="${balance}" />

																	<span class="card-footer proPrice" style="height:14px;font-family: Microsoft JhengHei;color:red;">折扣價:
	   			 													<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">
	   			 													<c:out value="${dsPrice}" /></span>點</span>
																</c:if>

															</div>
														</div>
													</a>

													<c:forEach var="proTrackVO" items="${list2}">
														<c:if test="${proVO.pro_No==proTrackVO.pro_No}">
															<div
																style="z-index: 3; position: absolute; left: 40px; top:70px;">
																<img alt=""
																	src="<%=request.getContextPath()%>/res/images/pro_icons/heart.png"
																	style="width: 30px; border-radius: 3px;">
															</div>
														</c:if>
													</c:forEach>
											
																<c:if test="${proVO.pro_Discount==90}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d001.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==80}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d002.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==70}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d003.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==50}">
																	<div style="z-index:3;position:absolute;left:100px;  top:-10px;">
																		<img alt="" style="height:50px;width:100px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d005.png">
																	</div>
																</c:if>
												</div>
											

									</c:if>
								</div>
							</c:forEach>
						
						</tr>
					</tbody>
				</table>

			</div>
			<div role="tabpanel" class="tab-pane" id="tab4" style="background-color :#f0f0f0">
					<table class="table table-hover"
					style="font-size: 16px; border: 2px solid #CCC">
					<tbody>
						<tr>

							<c:forEach var="proVO" items="${p04}" end="3">
								<div class="allPro">
												<div class="col-xs-12 col-sm-3 "
													style="margin: 6px; width: 23%;">
													
													
													<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}"
														style="text-decoration: none;">
														<div class="card " style="background-color: #fff;">
															<div class="imgCont ">
																<img class="card-img-top"
																	style="width: 100px; height: 100px;"
																	src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}"
																	alt="Card image cap">
															</div>
															<div class="card-body" style="text-align:center;">
																<p class="card-text proName">${proVO.pro_Name}</p>
																<c:if test="${proVO.pro_Discount==100}">
																	<p class="card-footer proPrice">價格:
																	<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">${proVO.pro_Price}</span>點</p>
																	<P style="height: 20px;"></P>
																</c:if>

																<c:if test="${proVO.pro_Discount!=100}">
																	<p class="card-footer proDiscount"
																		style="height: 20px;">原價:${proVO.pro_Price}點</p>

																	<c:set var="balance"
																		value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
																	<fmt:parseNumber var="dsPrice" integerOnly="true"
																		type="number" value="${balance}" />

																	<span class="card-footer proPrice" style="height:14px;font-family: Microsoft JhengHei;color:red;">折扣價:
	   			 													<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">
	   			 													<c:out value="${dsPrice}" /></span>點</span>
																</c:if>

																<c:if test="${proVO.pro_Discount==90}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d001.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==80}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d002.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==70}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d003.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==50}">
																	<div style="z-index:3;position:absolute;left:100px;  top:-10px;">
																		<img alt="" style="height:50px;width:100px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d005.png">
																	</div>
																</c:if>
															</div>
														</div>
													</a>

													<c:forEach var="proTrackVO" items="${list2}">
														<c:if test="${proVO.pro_No==proTrackVO.pro_No}">
															<div
																style="z-index: 3; position: absolute; left: 40px; top:70px;">
																<img alt=""
																	src="<%=request.getContextPath()%>/res/images/pro_icons/heart.png"
																	style="width: 30px; border-radius: 3px;">
															</div>
														</c:if>
													</c:forEach>
											
												</div>
								</div>
							</c:forEach>
						
						</tr>
					</tbody>
				</table>
			</div>


			<div role="tabpanel" class="tab-pane" id="tab5" style="background-color :#f0f0f0">
					<table class="table table-hover"
					style="font-size: 16px; border: 2px solid #FF800">
					<tbody>
						<tr>

							<c:forEach var="proVO" items="${p05}" end="3">
								<div class="allPro">
												<div class="col-xs-12 col-sm-3 "
													style="margin: 6px; width: 23%;">
													
													
													<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}"
														style="text-decoration: none;">
														<div class="card " style="background-color: #fff;">
															<div class="imgCont ">
																<img class="card-img-top"
																	style="width: 100px; height: 100px;"
																	src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}"
																	alt="Card image cap">
															</div>
															<div class="card-body" style="text-align:center;">
																<p class="card-text proName">${proVO.pro_Name}</p>
																<c:if test="${proVO.pro_Discount==100}">
																	<p class="card-footer proPrice">價格:
																	<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">${proVO.pro_Price}</span>點</p>
																	<P style="height: 20px;"></P>
																</c:if>

																<c:if test="${proVO.pro_Discount!=100}">
																	<p class="card-footer proDiscount"
																		style="height: 20px;">原價:${proVO.pro_Price}點</p>

																	<c:set var="balance"
																		value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
																	<fmt:parseNumber var="dsPrice" integerOnly="true"
																		type="number" value="${balance}" />

																	<span class="card-footer proPrice" style="height:14px;font-family: Microsoft JhengHei;color:red;">折扣價:
	   			 													<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">
	   			 													<c:out value="${dsPrice}" /></span>點</span>
																</c:if>

																<c:if test="${proVO.pro_Discount==90}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d001.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==80}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d002.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==70}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d003.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==50}">
																	<div style="z-index:3;position:absolute;left:100px;  top:-10px;">
																		<img alt="" style="height:50px;width:100px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d005.png">
																	</div>
																</c:if>
															</div>
														</div>
													</a>

													<c:forEach var="proTrackVO" items="${list2}">
														<c:if test="${proVO.pro_No==proTrackVO.pro_No}">
															<div
																style="z-index: 3; position: absolute; left: 40px; top:70px;">
																<img alt=""
																	src="<%=request.getContextPath()%>/res/images/pro_icons/heart.png"
																	style="width: 30px; border-radius: 3px;">
															</div>
														</c:if>
													</c:forEach>
											
												</div>
								</div>
							</c:forEach>
						
						</tr>
					</tbody>
				</table>
			</div>

		</div>
	</div>
<br>
	<div role="tabpanel" style="border: 5px solid #FF8000">
		<!-- 			標籤面板：標籤區 -->
		<ul class="nav nav-tabs" role="tablist">
			<li role="presentation" class="active" >
			<a href="#tab6" aria-controls="tab6" role="tab" data-toggle="tab"><h4>家電</h4></a></li>
			<li role="presentation">
			<a href="#tab7" aria-controls="tab7" role="tab" data-toggle="tab"><h4>精品</h4></a></li>
			<li role="presentation"><a href="#tab8" aria-controls="tab8"
				role="tab" data-toggle="tab"><h4>日常用品</h4></a></li>
			<li role="presentation"><a href="#tab9" aria-controls="tab9"
				role="tab" data-toggle="tab"><h4>電腦周邊</h4></a></li>
			<li role="presentation"><a href="#tab10" aria-controls="tab10"
				role="tab" data-toggle="tab"><h4>廚具</h4></a></li>
		</ul>

		<!-- 標籤面板：內容區 -->

		<div class="tab-content">
			<div role="tabpanel" class="tab-pane active" id="tab6" style="background-color :#f0f0f0">
				<table class="table table-hover"
					style="font-size: 16px; border: 10px solid red">
					<tbody>
						<tr>

							<c:forEach var="proVO" items="${p06}" end="3">
								<div class="allPro">
										
												<div class="col-xs-12 col-sm-3 "
													style="margin: 6px; width: 23%;">
													
													
													<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}"
														style="text-decoration: none;">
														<div class="card " style="background-color: #fff;">
															<div class="imgCont ">
																<img class="card-img-top"
																	style="width: 100px; height: 100px;"
																	src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}"
																	alt="Card image cap">
															</div>
															<div class="card-body" style="text-align:center;">
																<p class="card-text proName">${proVO.pro_Name}</p>
																<c:if test="${proVO.pro_Discount==100}">
																	<p class="card-footer proPrice">價格:
																	<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">${proVO.pro_Price}</span>點</p>
																	<P style="height: 20px;"></P>
																</c:if>

																<c:if test="${proVO.pro_Discount!=100}">
																	<p class="card-footer proDiscount"
																		style="height: 20px;">原價:${proVO.pro_Price}點</p>

																	<c:set var="balance"
																		value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
																	<fmt:parseNumber var="dsPrice" integerOnly="true"
																		type="number" value="${balance}" />

																	<span class="card-footer proPrice" style="height:14px;font-family: Microsoft JhengHei;color:red;">折扣價:
	   			 													<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">
	   			 													<c:out value="${dsPrice}" /></span>點</span>
																</c:if>

																<c:if test="${proVO.pro_Discount==90}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d001.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==80}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d002.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==70}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d003.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==50}">
																	<div style="z-index:3;position:absolute;left:100px;  top:-10px;">
																		<img alt="" style="height:50px;width:100px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d005.png">
																	</div>
																</c:if>
															</div>
														</div>
													</a>

													<c:forEach var="proTrackVO" items="${p02}">
														<c:if test="${proVO.pro_No==proTrackVO.pro_No}">
															<div
																style="z-index: 3; position: absolute; left: 40px; top:70px;">
																<img alt=""
																	src="<%=request.getContextPath()%>/res/images/pro_icons/heart.png"
																	style="width: 30px; border-radius: 3px;">
															</div>
														</c:if>
													</c:forEach>
												</div>
								</div>
							</c:forEach>
						
						</tr>
					</tbody>
				</table>
			</div>
			<div role="tabpanel" class="tab-pane" id="tab7" style="background-color :#f0f0f0">
					<table class="table table-hover"
					style="font-size: 16px; border: 2px solid #CCC">
					<tbody>
						<tr>

							<c:forEach var="proVO" items="${p07}" end="3">
								<div class="allPro">
										
												<div class="col-xs-12 col-sm-3 "
													style="margin: 6px; width: 23%;">
													
													
													<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}"
														style="text-decoration: none;">
														<div class="card " style="background-color: #fff;">
															<div class="imgCont ">
																<img class="card-img-top"
																	style="width: 100px; height: 100px;"
																	src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}"
																	alt="Card image cap">
															</div>
															<div class="card-body" style="text-align:center;">
																<p class="card-text proName">${proVO.pro_Name}</p>
																<c:if test="${proVO.pro_Discount==100}">
																	<p class="card-footer proPrice">價格:
																	<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">${proVO.pro_Price}</span>點</p>
																	<P style="height: 20px;"></P>
																</c:if>

																<c:if test="${proVO.pro_Discount!=100}">
																	<p class="card-footer proDiscount"
																		style="height: 20px;">原價:${proVO.pro_Price}點</p>

																	<c:set var="balance"
																		value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
																	<fmt:parseNumber var="dsPrice" integerOnly="true"
																		type="number" value="${balance}" />

																	<span class="card-footer proPrice" style="height:14px;font-family: Microsoft JhengHei;color:red;">折扣價:
	   			 													<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">
	   			 													<c:out value="${dsPrice}" /></span>點</span>
																</c:if>

																<c:if test="${proVO.pro_Discount==90}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d001.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==80}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d002.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==70}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d003.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==50}">
																	<div style="z-index:3;position:absolute;left:100px;  top:-10px;">
																		<img alt="" style="height:50px;width:100px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d005.png">
																	</div>
																</c:if>
															</div>
														</div>
													</a>

													<c:forEach var="proTrackVO" items="${list2}">
														<c:if test="${proVO.pro_No==proTrackVO.pro_No}">
															<div
																style="z-index: 3; position: absolute; left: 40px; top:70px;">
																<img alt=""
																	src="<%=request.getContextPath()%>/res/images/pro_icons/heart.png"
																	style="width: 30px; border-radius: 3px;">
															</div>
														</c:if>
													</c:forEach>
											
												</div>
											

								</div>
							</c:forEach>
						
						</tr>
					</tbody>
				</table>
			</div>
			<div role="tabpanel" class="tab-pane" id="tab8" style="background-color :#f0f0f0">
					<table class="table table-hover"
					style="font-size: 16px; border: 2px solid #CCC">
					<tbody>
						<tr>

							<c:forEach var="proVO" items="${p08}" end="3">
								<div class="allPro">
									<c:if test="${proVO.pro_Status=='上架'}">
										
												<div class="col-xs-12 col-sm-3 "
													style="margin: 6px; width: 23%;">
													
													
													<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}"
														style="text-decoration: none;">
														<div class="card " style="background-color: #fff;">
															<div class="imgCont ">
																<img class="card-img-top"
																	style="width: 100px; height: 100px;"
																	src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}"
																	alt="Card image cap">
															</div>
															<div class="card-body" style="text-align:center;">
																<p class="card-text proName">${proVO.pro_Name}</p>
																<c:if test="${proVO.pro_Discount==100}">
																	<p class="card-footer proPrice">價格:
																	<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">${proVO.pro_Price}</span>點</p>
																	<P style="height: 20px;"></P>
																</c:if>

																<c:if test="${proVO.pro_Discount!=100}">
																	<p class="card-footer proDiscount"
																		style="height: 20px;">原價:${proVO.pro_Price}點</p>

																	<c:set var="balance"
																		value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
																	<fmt:parseNumber var="dsPrice" integerOnly="true"
																		type="number" value="${balance}" />

																	<span class="card-footer proPrice" style="height:14px;font-family: Microsoft JhengHei;color:red;">折扣價:
	   			 													<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">
	   			 													<c:out value="${dsPrice}" /></span>點</span>
																</c:if>

																<c:if test="${proVO.pro_Discount==90}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d001.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==80}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d002.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==70}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d003.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==50}">
																	<div style="z-index:3;position:absolute;left:100px;  top:-10px;">
																		<img alt="" style="height:50px;width:100px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d005.png">
																	</div>
																</c:if>
															</div>
														</div>
													</a>

													<c:forEach var="proTrackVO" items="${list2}">
														<c:if test="${proVO.pro_No==proTrackVO.pro_No}">
															<div
																style="z-index: 3; position: absolute; left: 40px; top:70px;">
																<img alt=""
																	src="<%=request.getContextPath()%>/res/images/pro_icons/heart.png"
																	style="width: 30px; border-radius: 3px;">
															</div>
														</c:if>
													</c:forEach>
											
												</div>
											

									</c:if>
								</div>
							</c:forEach>
						
						</tr>
					</tbody>
				</table>

			</div>
			<div role="tabpanel" class="tab-pane" id="tab9" style="background-color :#f0f0f0">
					<table class="table table-hover"
					style="font-size: 16px; border: 2px solid #CCC">
					<tbody>
						<tr>

							<c:forEach var="proVO" items="${p09}" end="3">
								<div class="allPro">
												<div class="col-xs-12 col-sm-3 "
													style="margin: 6px; width: 23%;">
													
													
													<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}"
														style="text-decoration: none;">
														<div class="card " style="background-color: #fff;">
															<div class="imgCont ">
																<img class="card-img-top"
																	style="width: 100px; height: 100px;"
																	src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}"
																	alt="Card image cap">
															</div>
															<div class="card-body" style="text-align:center;">
																<p class="card-text proName">${proVO.pro_Name}</p>
																<c:if test="${proVO.pro_Discount==100}">
																	<p class="card-footer proPrice">價格:
																	<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">${proVO.pro_Price}</span>點</p>
																	<P style="height: 20px;"></P>
																</c:if>

																<c:if test="${proVO.pro_Discount!=100}">
																	<p class="card-footer proDiscount"
																		style="height: 20px;">原價:${proVO.pro_Price}點</p>

																	<c:set var="balance"
																		value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
																	<fmt:parseNumber var="dsPrice" integerOnly="true"
																		type="number" value="${balance}" />

																	<span class="card-footer proPrice" style="height:14px;font-family: Microsoft JhengHei;color:red;">折扣價:
	   			 													<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">
	   			 													<c:out value="${dsPrice}" /></span>點</span>
																</c:if>

																<c:if test="${proVO.pro_Discount==90}">
																	<div style="z-index:3;position:absolute;left:160px;  top:-15px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d001.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==80}">
																	<div style="z-index:3;position:absolute;left:160px;  top:-15px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d002.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==70}">
																	<div style="z-index:3;position:absolute;left:160px;  top:-15px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d003.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==50}">
																	<div style="z-index:3;position:absolute;left:100px;  top:-10px;">
																		<img alt="" style="height:50px;width:100px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d005.png">
																	</div>
																</c:if>
															</div>
														</div>
													</a>

													<c:forEach var="proTrackVO" items="${list2}">
														<c:if test="${proVO.pro_No==proTrackVO.pro_No}">
															<div
																style="z-index: 3; position: absolute; left: 40px; top:70px;">
																<img alt=""
																	src="<%=request.getContextPath()%>/res/images/pro_icons/heart.png"
																	style="width: 30px; border-radius: 3px;">
															</div>
														</c:if>
													</c:forEach>
											
												</div>
								</div>
							</c:forEach>
						
						</tr>
					</tbody>
				</table>
			</div>


			<div role="tabpanel" class="tab-pane" id="tab10" style="background-color :#f0f0f0">
					<table class="table table-hover"
					style="font-size: 16px; border: 2px solid #FF800">
					<tbody>
						<tr>

							<c:forEach var="proVO" items="${p10}" end="3">
								<div class="allPro">
												<div class="col-xs-12 col-sm-3 "
													style="margin: 6px; width: 23%;">
													
													
													<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No}"
														style="text-decoration: none;">
														<div class="card " style="background-color: #fff;">
															<div class="imgCont ">
																<img class="card-img-top"
																	style="width: 100px; height: 100px;"
																	src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}"
																	alt="Card image cap">
															</div>
															<div class="card-body" style="text-align:center;">
																<p class="card-text proName">${proVO.pro_Name}</p>
																<c:if test="${proVO.pro_Discount==100}">
																	<p class="card-footer proPrice">價格:
																	<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">${proVO.pro_Price}</span>點</p>
																	<P style="height: 20px;"></P>
																</c:if>

																<c:if test="${proVO.pro_Discount!=100}">
																	<p class="card-footer proDiscount"
																		style="height: 20px;">原價:${proVO.pro_Price}點</p>

																	<c:set var="balance"
																		value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
																	<fmt:parseNumber var="dsPrice" integerOnly="true"
																		type="number" value="${balance}" />

																	<span class="card-footer proPrice" style="height:14px;font-family: Microsoft JhengHei;color:red;">折扣價:
	   			 													<span style="color:red;font-size:24px;font-family: Microsoft JhengHei;">
	   			 													<c:out value="${dsPrice}" /></span>點</span>
																</c:if>

																<c:if test="${proVO.pro_Discount==90}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d001.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==80}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d002.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==70}">
																	<div style="z-index:3;position:absolute;left:140px;  top:-10px;">
																		<img alt="" style="height:40px;width:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d003.png">
																	</div>
																</c:if>
																
															</div>
														</div>
													</a>

													<c:forEach var="proTrackVO" items="${list2}">
														<c:if test="${proVO.pro_No==proTrackVO.pro_No}">
															<div
																style="z-index: 3; position: absolute; left: 40px; top:70px;">
																<img alt=""
																	src="<%=request.getContextPath()%>/res/images/pro_icons/heart.png"
																	style="width: 30px; border-radius: 3px;">
															</div>
														</c:if>
													</c:forEach>
													<c:if test="${proVO.pro_Discount==50}">
																	<div style="z-index:3;position:absolute;left:100px;  top:-10px;">
																		<img alt="" style="height:50px;width:100px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d005.png">
																	</div>
																</c:if>
												</div>
								</div>
							</c:forEach>
						
						</tr>
					</tbody>
				</table>
			</div>

		</div>
	</div>
	

</body>
</html>