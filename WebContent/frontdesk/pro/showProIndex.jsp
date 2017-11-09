<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.pro.model.*"%>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
	ProService proSvc = new ProService();
	List<ProVO> list = proSvc.getAll();
%>
<jsp:useBean id="proClassSvc" scope="page"
	class="com.proclass.model.ProClassService" />

<style type="text/css" media="screen">
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
.breadcrumb li, .breadcrumb li a {
	color: #f90;
	font-size: 16px;
}
</style>

<script>
	window.onscroll = function() {
		if ($(document).scrollTop() > 50)//这个60是距离顶部高度
		{
			$("#ontopDiv").addClass('float');//
		} else {
			$("#ontopDiv").removeClass('float');
		}
	}
	
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
								href="<%=request.getContextPath()%>/pro/proClass.do?action=getOneClassPro&pro_Class_No=${proClassVO.pro_Class_No}">${proClassVO.pro_Class_Name}
								
								</a></li>
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




	<div class="col-xs-12 col-sm-12 "></div>

	<div class="col-xs-12 col-sm-2 col-sm-offset-1">
		<br>
		<div class="panel panel-info left001">
			<div class="panel-heading">
				<h3 class="panel-title">
					<h3>排行榜</h3>
				</h3>
			</div>
			<div class="panel-body">
				<table class="table">
					<tr>
						<td rowspan="3"><img
							src="https://api.fnkr.net/testimg/100x130/00CED1/FFF/?text=img+placeholder">
						</th>
						</td>
						<td colspan="2">XXXXXXX</td>
					</tr>
					<tr>
						<td colspan="2">DDDDDDDDDDDDDD</td>
					</tr>
					<tr>
						<td>$987</td>
						<td><input type="button" name="" value="購買"></td>
					</tr>
					<tr>
						<td rowspan="3"><img
							src="https://api.fnkr.net/testimg/100x130/00CED1/FFF/?text=img+placeholder">
						</th>
						</td>
						<td colspan="2">XXXXXXX</td>
					</tr>
					<tr>
						<td colspan="2">DDDDDDDDDDDDDD</td>
					</tr>
					<tr>
						<td>$987</td>
						<td><input type="button" name="" value="購買"></td>
					</tr>
					<tr>
						<td rowspan="3"><img
							src="https://api.fnkr.net/testimg/100x130/00CED1/FFF/?text=img+placeholder">
						</th>
						</td>
						<td colspan="2">XXXXXXX</td>
					</tr>
					<tr>
						<td colspan="2">DDDDDDDDDDDDDD</td>
					</tr>
					<tr>
						<td>$987</td>
						<td><input type="button" name="" value="購買"></td>
					</tr>
					<tr>
						<td rowspan="3"><img
							src="https://api.fnkr.net/testimg/100x130/00CED1/FFF/?text=img+placeholder">
						</th>
						</td>
						<td colspan="2">XXXXXXX</td>
					</tr>
					<tr>
						<td colspan="2">DDDDDDDDDDDDDD</td>
					</tr>
					<tr>
						<td>$987</td>
						<td><input type="button" name="" value="購買"></td>
					</tr>
					<tr>
						<td rowspan="3"><img
							src="https://api.fnkr.net/testimg/100x130/00CED1/FFF/?text=img+placeholder">
						</th>
						</td>
						<td colspan="2">XXXXXXX</td>
					</tr>
					<tr>
						<td colspan="2">DDDDDDDDDDDDDD</td>
					</tr>
					<tr>
						<td>$987</td>
						<td><input type="button" name="" value="購買"></td>
					</tr>
				</table>
			</div>
		</div>

	</div>
	</div>
	<!-- 左2結束 -->


	<!--麵包屑 -->
	<div class="col-xs-12 col-sm-6">
		<div class="col-xs-12 col-sm-12">

			<br>
			<ol class="breadcrumb">
				<li><a href="<%=request.getContextPath()%>">首頁</a></li>
				<li class="active">積分商城
				</li>

			</ol>


			<!-- 	輪播廣告		 -->
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
		<br>













		<div role="tabpanel">
			<!-- 標籤面板：標籤區 -->
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="#tab1"
					aria-controls="tab1" role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
				<li role="presentation"><a href="#tab2" aria-controls="tab2"
					role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
				<li role="presentation"><a href="#tab3" aria-controls="tab3"
					role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
				<li role="presentation"><a href="#amos" aria-controls="amos"
					role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
			</ul>

			<!-- 標籤面板：內容區 -->
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="tab1">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00ED21/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/002ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/002ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/20CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>
				</div>
				<div role="tabpanel" class="tab-pane" id="tab2">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/02CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/001ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00C1D1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CE11/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>
				</div>
				<div role="tabpanel" class="tab-pane" id="tab3">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/10CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/001ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/0aCED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00aED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>

				</div>
				<div role="tabpanel" class="tab-pane" id="amos">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00aED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CEa1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CEDa/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>

				</div>
			</div>
		</div>

		<div role="tabpanel">
			<!-- 標籤面板：標籤區 -->
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="#tab1"
					aria-controls="tab1" role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
				<li role="presentation"><a href="#tab2" aria-controls="tab2"
					role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
				<li role="presentation"><a href="#tab3" aria-controls="tab3"
					role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
				<li role="presentation"><a href="#amos" aria-controls="amos"
					role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
			</ul>

			<!-- 標籤面板：內容區 -->
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="tab1">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00ED21/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/002ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/002ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/20CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>
				</div>
				<div role="tabpanel" class="tab-pane" id="tab2">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/02CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/001ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00C1D1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CE11/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>
				</div>
				<div role="tabpanel" class="tab-pane" id="tab3">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/10CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/001ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/0aCED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00aED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>

				</div>
				<div role="tabpanel" class="tab-pane" id="amos">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00aED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CEa1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CEDa/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>

				</div>
			</div>
		</div>


	</div>
	<!--中6結束 -->



	<div class="col-xs-12 col-sm-2">
		<br>
		<div class="panel panel-info left001">
			<div class="panel-heading">
				<h3 class="panel-title">熱銷商品222</h3>
			</div>
			<div class="panel-body">
				<table class="table">
					<tr>
						<td rowspan="3"><img
							src="https://api.fnkr.net/testimg/100x130/00CEaa/FFF/?text=img+placeholder">
						</th>
						</td>
						<td colspan="2">XXXXXXX</td>
					</tr>
					<tr>
						<td colspan="2">DDDDDDDDDDDDDD</td>
					</tr>
					<tr>
						<td>$987</td>
						<td><input type="button" name="" value="購買"></td>
					</tr>
					<tr>
						<td rowspan="3"><img
							src="https://api.fnkr.net/testimg/100x130/00aED1/FFF/?text=img+placeholder">
						</th>
						</td>
						<td colspan="2">XXXXXXX</td>
					</tr>
					<tr>
						<td colspan="2">DDDDDDDDDDDDDD</td>
					</tr>
					<tr>
						<td>$987</td>
						<td><input type="button" name="" value="購買"></td>
					</tr>
					<tr>
						<td rowspan="3"><img
							src="https://api.fnkr.net/testimg/100x130/a0CED1/FFF/?text=img+placeholder">
						</th>
						</td>
						<td colspan="2">XXXXXXX</td>
					</tr>
					<tr>
						<td colspan="2">DDDDDDDDDDDDDD</td>
					</tr>
					<tr>
						<td>$987</td>
						<td><input type="button" name="" value="購買"></td>
					</tr>
					<tr>
						<td rowspan="3"><img
							src="https://api.fnkr.net/testimg/100x130/00aaD1/FFF/?text=img+placeholder">
						</th>
						</td>
						<td colspan="2">XXXXXXX</td>
					</tr>
					<tr>
						<td colspan="2">DDDDDDDDDDDDDD</td>
					</tr>
					<tr>
						<td>$987</td>
						<td><input type="button" name="" value="購買"></td>
					</tr>
					<tr>
						<td rowspan="3"><img
							src="https://api.fnkr.net/testimg/100x130/aaaED1/FFF/?text=img+placeholder">
						</th>
						</td>
						<td colspan="2">XXXXXXX</td>
					</tr>
					<tr>
						<td colspan="2">DDDDDDDDDDDDDD</td>
					</tr>
					<tr>
						<td>$987</td>
						<td><input type="button" name="" value="購買"></td>
					</tr>
				</table>
			</div>
		</div>

	</div>
	<!-- 右2結束 -->


	<script src="https://code.jquery.com/jquery.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<!-- 將以下原始碼複製到bootstrap.js檔案連結的下方 -->
	<script>
		$(function() {
			$('.navbar-toggle').on('click', switchNav)
			function switchNav() {
				$('.my-navbar').toggleClass('open');
			}
		})
	</script>
</body>
</html>