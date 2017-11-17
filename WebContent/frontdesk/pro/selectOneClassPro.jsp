<%@page import="java.util.*"%>
<%@page import="com.pro.model.*"%>
<%@page import="com.proclass.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	ProService proSvc = new ProService();
	List<ProVO> list = proSvc.getAll();
%>
<jsp:useBean id="proClassSvc" scope="page"
	class="com.proclass.model.ProClassService" />



<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title>商品</title>

<style>
/* TOP */
#ontopDiv {
	top: 0;
	width: 100%;
	height: 60px;
	background-color: #ffffff;
	padding: 15px;
	font-size: 16px;
}

.float {
	position: fixed;
	top: 0;
	box-shadow: 4px 4px 12px 4px rgba(20%, 20%, 40%, 0.5);
	z-index: 100;
}
/* 麵包屑 */
.breadcrumb li, .breadcrumb li a {
	color: #f90;
	font-size: 16px;
}


.proDiv {
	margin: 10px;
	border: 3px orange double;
	height: 300px;
	margin-left: 50px;
}

.proName {
	font-size: 20px;
}

.proPrice {
	font-size: 20;
	color: red;
}

.imgCont {
	display: flex;
	align-items: center;
	justify-content: center;
	max-width: 110%;
}

.proDiscount {
	font-size: 16px;
	text-decoration: line-through;
}


/* 跳窗 */

 







</style>

<script type="text/javascript">  
        $(document).ready(function(){ 
            $(".backPro").click(function(){
            	var proCount = $(".proCount").val()*1;
            		if(proCount>1){
            			$(".proCount").val(proCount-1);
            		}
            });	
           
            $(".addPro").click(function(){
            	var proCount = $(".proCount").val()*1; 
            	if(proCount<10){
            		$(".proCount").val(proCount+1);
            	}
      		});	
        }); 
</script>  

</head>
<body>



		<div class="col-xs-12 col-sm-12 " id="ontopDiv">
		<!--搜尋 -->
		<div class="col-xs-12 col-sm-3 col-sm-offset-4">

			<div class="input-group select01">
				<span class="input-group-btn"> <a href=""
					class="btn btn-info dropdown-toggle select01"
					data-toggle="dropdown">分類 <b class="caret"></b></a>
					<ul class="dropdown-menu">
						<c:forEach var="proClassVO" items="${proClassSvc.all}">
							<li><a
								href="<%=request.getContextPath()%>/pro/proClass.do?action=getOneClassPro&pro_Class_No=${proClassVO.pro_Class_No}">${proClassVO.pro_Class_Name}</a></li>
						</c:forEach>
					</ul>
				</span> <input type="text" class="form-control select01" placeholder="請輸入"
					id="bb"> <span class="btn input-group-addon"><i
					class="glyphicon glyphicon-search "></i>搜尋</span>
			</div>
		</div>
		<!--搜尋結束 -->

		<div class="col-xs-12 col-sm-1 ">
			<span><a
				href="<%=request.getContextPath()%>/frontdesk/pro/cart.jsp">購物車</a></span>
		</div>
		<div class="col-xs-12 col-sm-1">
			<span>追蹤商品</span>
		</div>
		<div class="col-xs-12 col-sm-1">
			<span>通知</span>
		</div>
	</div>
	<!--搜尋結束 12 -->
	
	<div class="col-xs-12 col-sm-12">
	
		<div class="col-xs-12 col-sm-2 col-sm-offset-1"></div>
		<!--左2結束 -->

		<div class="col-xs-12 col-sm-6">


			<!--麵包屑 -->
			<div class="col-xs-12 col-sm-12">
				<div class="col-xs-12 col-sm-12 ">
					<br>
					<ol class="breadcrumb">
						<li><a href="#">首頁</a></li>
						<li class="active"><a
							href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp">積分商城</a>
						</li>
						<li class="breadcrumb-item active" aria-current="page">搜尋商品</li>
					</ol>
				</div>
			</div>
			<!--麵包屑結束 -->

			<!--輪播廣告-->
			<div class="col-xs-12 col-sm-12">
				<div id="carousel-id" class="carousel slide" data-ride="carousel">
					<!-- 幻燈片小圓點區 -->
					<ol class="carousel-indicators">
						<li data-target="#carousel-id" data-slide-to="0" class=""></li>
						<li data-target="#carousel-id" data-slide-to="1" class=""></li>
						<li data-target="#carousel-id" data-slide-to="2" class="active"></li>
					</ol>
					<!-- 幻燈片主圖區 -->
					<div class="carousel-inner">
						<div class="item">
							<img src="https://api.fnkr.net/testimg/2800x700/aaaaaa" alt="">
							<div class="container">
								<div class="carousel-caption">
									<h1>CSS可樂好喝超爽快</h1>
									<p>你喝過了嗎？</p>
									<p>
										<a class="btn btn-lg btn-primary" href="#" role="button">Sign
											up today</a>
									</p>
								</div>
							</div>
						</div>
						<div class="item">
							<img src="https://api.fnkr.net/testimg/2800x700/aaaaaa" alt="">
							<div class="container">
								<div class="carousel-caption">
									<h1>CSS可樂的外掛真方便</h1>
									<p>你安裝了嗎？</p>
									<p>
										<a class="btn btn-lg btn-primary" href="#" role="button">更多</a>
									</p>
								</div>
							</div>
						</div>
						<div class="item active">
							<img src="https://api.fnkr.net/testimg/2800x700/aaaaaa" alt="">
							<div class="container">
								<div class="carousel-caption">
									<h1>我是標題喔～自己改文案吧</h1>
									<p>我是內文喔，你可以把字打在這裡呦</p>
									<p>
										<a class="btn btn-lg btn-primary" href="#" role="button">詳細內容</a>
									</p>
								</div>
							</div>
						</div>
					</div>
					<!-- 上下頁控制區 -->
					<a class="left carousel-control" href="#carousel-id"
						data-slide="prev"><span
						class="glyphicon glyphicon-chevron-left"></span></a> <a
						class="right carousel-control" href="#carousel-id"
						data-slide="next"><span
						class="glyphicon glyphicon-chevron-right"></span></a>
				</div>
				<br>
			</div>
			<!--輪播廣告結束-->
			<br>

			<!--商品顯示-->
			<div class="col-xs-12 col-sm-12">
				<c:forEach var="proVO" items="${oneClassPro}">
				     <!-- Button trigger modal -->
					<a data-toggle="modal" data-target="# ${proVO.pro_No}">
<%-- 					<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=${proVO.pro_No} ">   --%>
					<c:if test="${proVO.pro_Status=='上架'}">
						<p data-toggle="modal" data-target="#$(proVO.pro_No}">
							<div class="col-xs-12 col-sm-3 proDiv">
								<div class="card" style="width: 100%;">
									
									<div class="imgCont">
										<img class="card-img-top" style="width: 100%;"
											src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}"
											alt="Card image cap">
									</div>
									<div class="card-body">
										<p class="card-text proName">${proVO.pro_Name}</p>
										<c:if test="${proVO.pro_Discount==100}">
											<P></P>
											<p class="card-footer proPrice">價格:$${proVO.pro_Price}</p>
										</c:if>
										<c:if test="${proVO.pro_Discount!=100}">
											<p class="card-footer proDiscount">原價:$${proVO.pro_Price}</p>
											<p class="card-footer proPrice">折扣價:$${(proVO.pro_Price)*(proVO.pro_Discount)/100}</p>
										</c:if>
									</div>
								</div>
							</div>
						
						</c:if>
					
					</a>






					<!-- Modal -->
					<div class="modal fade" id=" ${proVO.pro_No}" tabindex="-1"
						role="dialog" aria-labelledby="exampleModalLabel"
						aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header"></div>
								<div class="modal-body">


									<div class="proDiv2">

										<table class="proForm">
											<tbody>
												<tr>
													<td rowspan="4" style="padding: 16px;">
														<div class="imgCont01">
															<img class="card-img-top rounded"
																src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}"
																alt="Card image cap">
														</div>
													</td>
													<td><p class="proName">${proVO.pro_Name}</p></td>
												</tr>
												<tr>
													<td><p class="proInfo">
															<c:forTokens var="alpha" items="${proVO.pro_Info}"
																delims=",">
																<c:forEach var="person" items="${alpha}">
																	<p>✦${person}</p>
																</c:forEach>
															</c:forTokens>
														</p></td>
												</tr>
												<tr>
													<td><c:if test="${proVO.pro_Discount==100}">
															<P></P>
															<p class="proPrice">價格:$${proVO.pro_Price}</p>
														</c:if> <c:if test="${proVO.pro_Discount!=100}">
															<p class="proDiscount">原價:$${proVO.pro_Price}</p>
															<p class="proPrice">折扣價:$${(proVO.pro_Price)*(proVO.pro_Discount)/100}</p>
														</c:if></td>
												</tr>


												<tr>
													<td>
														
													</td>
													<td>

														
														<form METHOD="post" ACTION="<%=request.getContextPath()%>/pro/shoppingCartServlet.do">
															<button type="button" class="backPro" style="width: 40px;height:40px;">-</button>
															<input type="text" class="proCount" name="proCar_Quantity"
																value="1" style="width: 40px;height:40px; text-align: center;" >
															<button type="button" class="addPro" style="width: 40px;height:40px;">+</button>


															<button type="submit" class="btn btn-warning"
																style="width: 180px; margin: 5px; margin-left: 0px; font-size: 20px;">放入購物車</button>
															<input type="hidden" name="proCar_No" value="${proVO.pro_No}"> 
															<input type="hidden" name="proCar_Name" value="${proVO.pro_Name}"> 
															<input type="hidden" name="proCar_Info" value="${proVO.pro_Info}"> 
															<input type="hidden" name="proCar_Price" value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}">
															<input type="hidden" name="requestURL" value="<%=request.getServletPath()+request.getQueryString() %>">
															<input type="hidden" name="action" value="addPro">
														</form>
													<td>
												</tr>
											</tbody>
										</table>

									</div>

									





								</div>
								<div class="modal-footer">
									<FORM METHOD="post"
										ACTION="<%=request.getContextPath()%>/pro/proOrderServlet.do">
										<button type="submit" class="btn btn-Secondary"
											style="width: 180px; margin: 5px; margin-left: 200px; font-size: 20px;">加入追蹤清單</button>
										<input type="hidden" name="pro_No" value="${proVO.pro_No}">
										<input type="hidden" name="requestURL"
											value="<%=request.getServletPath()%>"> <input
											type="hidden" name="whichPage"
											value="<%=request.getParameter("whichPage")%>">
									</FORM>
								</div>
							</div>
						</div>
					</div>








				</c:forEach>
			</div>
			<!--商品顯示結束-->






		</div>
		<!--中6結束 -->

		<div class="col-xs-12 col-sm-2">
		
		
		</div>
		<!--右2結束 -->

<jsp:include page="/frontdesk/pro/cart.jsp" flush="true" />





	</div>
	<!--大12結束 -->








</body>
</html>