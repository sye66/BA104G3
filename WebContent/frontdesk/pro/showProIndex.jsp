<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.pro.model.*"%>
<%@ page import="com.pro.shoppingcart.*"%>
<%@ page import="com.protrack.model.*" %>
<%@ page import="com.proorder.model.*"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">




</head>
<body>

<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"/>

<jsp:include page="/frontdesk/pro/selectProTOP.jsp" flush="true" />	

<%-- <jsp:include page="<%=request.getContextPath()%>/frontdesk/pro/selectProTOP.jsp" flush="true" />	 --%>




	

	<div class="col-xs-12 col-sm-2 col-sm-offset-1">
		<br><br><br>
		<div class="panel panel-info left001">
			<div class="panel-heading">
				<div class="panel-title">
					<h3 align="center">排行榜</h3>
				</div>
			</div>
			<div class="panel-body">
				<table class="table">
					
					
<jsp:include page="/frontdesk/pro/selectProTop10.jsp" flush="true" />	
			
			
				</table>
			</div>
		</div>

	</div>
	
	<!-- 左2結束 -->


	
	<div class="col-xs-12 col-sm-6">
	<!--麵包屑 -->
		<div class="col-xs-12 col-sm-12">

			<br>
			<ol class="breadcrumb">
				<li><a href="<%=request.getContextPath()%>">首頁</a></li>
				<li class="active">積分商城
				</li>

			</ol>

		</div>
		
			<!-- 	輪播廣告		 -->
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
					<div class="item active">
						<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=P000011" >
							<img src="<%=request.getContextPath()%>/res/images/pro_icons/iX.jpg" alt="" style="height:250px;width:900px;">
						</a>
					</div>
					
					<div class="item">
					<a  href="<%=request.getContextPath()%>/pro/pro.do" >
						<img src="<%=request.getContextPath()%>/res/images/pro_icons/aa02.jpg" alt="" style="height:250px;width:900px;">
					</a>
							
					</div>
					<div class="item ">
					<a  href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=P000028" >
						<img src="<%=request.getContextPath()%>/res/images/pro_icons/aa03.jpg" alt="" style="height:250px;width:900px;">
					</a>
						
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
				</div>
			<br>
		
		<br>





<jsp:include page="/frontdesk/pro/selectAllPro.jsp" flush="true" />







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
		<br><br><br>
		<div class="panel panel-info left001">
			<div class="panel-heading">
				<div class="panel-title"><h3 align="center">特價商品</h3>
				</div>
			</div>
			<div class="panel-body">
				
<jsp:include page="/frontdesk/pro/selectHotPro.jsp" flush="true" />					
			</div>
		</div>

	</div>
	<!-- 右2結束 -->

	
	
</body>
</html>