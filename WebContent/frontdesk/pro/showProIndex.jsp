<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.pro.model.*"%>
<%@ page import="com.pro.shoppingcart.*"%>
<%@ page import="com.protrack.model.*" %>
<%@ page import="com.proorder.model.*"%>


<html>
<head>
<title>工具人出租</title>




</head>
<body >
<!-- TOP -->
<div class="row">
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/proNavbar.jsp" flush="true"/> 
<%-- <jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"></jsp:include> --%>
</div></div>
<!-- 商城TOP -->
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/selectProTOP.jsp" flush="true" />	
</div>


<a name="aaa"></a>
	
<div class="col-xs-12 col-sm-12" style="background-color: #fef1ce;">
<!-- <div class="col-xs-12 col-sm-12" > -->
	<div class="col-xs-12 col-sm-2 col-sm-offset-2">
		<br><br><br><br><br><br><br><br>
		<div class="panel panel-danger left001" >
			<div class="panel-heading" >
				<div class="panel-title" >
				<div style="z-index:3;position:absolute;left:5px;  top:66px;">
					<img alt="" style="height:100px;width:270px;" src="<%=request.getContextPath()%>/res/images/pro_icons/top01.png">
				</div>
				</div>
			</div>
			<div class="panel-body" style="background-color: #fef1ce;border:5px solid #f2dede;">
	<div class="row">
					
					
<jsp:include page="/frontdesk/pro/selectProTop10.jsp" flush="true" />	
			
		</div>	
				
			</div>
		</div>

	</div>
	
	<!-- 左2結束 -->


	
	<div class="col-xs-12 col-sm-6" >
	<!--麵包屑 -->
		<div class="col-xs-12 col-sm-12" style="background-color: #fef1ce;">

			<br>
			<ol class="breadcrumb" style="background-color: #fef1ce;">
				<li><a href="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">首頁</a></li>
				<li class="active">積分商城
				</li>

			</ol>

		</div><!--麵包屑 -->
		
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
		</div><!-- 	輪播廣告		 -->
			<br>
		
		<br>

		<div class="col-xs-12 col-sm-12" >
		<br>
		<img alt="" style="height:50px;width:100%;" src="<%=request.getContextPath()%>/res/images/pro_icons/lin01.png">
		<br>
		<div class="panel panel-info ">
			<div class="panel-heading">
				<div class="panel-title" style="height:30px;">
					<img alt="" style="height:30px;" src="<%=request.getContextPath()%>/res/images/pro_icons/g003.png">
					</div>
				<div style="position:absolute;left:750px;top:25px; ">
<%-- 					<img alt="" style="height:40px;" src="<%=request.getContextPath()%>/res/images/pro_icons/s01.png"> --%>
				</div>
			</div>
			<div class="panel-body" style="background-color: #fef1ce;">
				
				<jsp:include page="/frontdesk/pro/selectHotPro.jsp" flush="true" />					
			</div>
		</div>
</div>


<div class="col-xs-12 col-sm-12" >

	<div style="text-align:center ">





	</div>
</div>





<!-- 所有商品 -->
<!-- <div class="col-xs-12 col-sm-12" > -->

<!-- <div style="text-align:center "> -->
<%-- <jsp:include page="/frontdesk/pro/selectAllPro.jsp" flush="true" /> --%>
<!-- </div> -->
<!-- </div> -->
<!-- 所有商品 -->

<!-- 熱門 -->
<div class="col-xs-12 col-sm-12">
<img alt="" style="height:50px;width:100%;" src="<%=request.getContextPath()%>/res/images/pro_icons/lin01.png">


		<div role="tabpanel">
<!-- 			標籤面板：標籤區 -->
			<ul class="nav nav-tabs"  role="tablist">
				<li role="presentation" class="active"><a href="#tab1"
					aria-controls="tab1" role="tab" data-toggle="tab"><h4>食品</h4></a></li>
				<li role="presentation"><a href="#tab2" aria-controls="tab2"
					role="tab" data-toggle="tab"><h4>3C產品</h4></a></li>
				<li role="presentation"><a href="#tab3" aria-controls="tab3"
					role="tab" data-toggle="tab"><h4>運動</h4></a></li>
				<li role="presentation"><a href="#tab4" aria-controls="tab4"
					role="tab" data-toggle="tab"><h4>餐卷</h4></a></li>
				<li role="presentation"><a href="#tab5" aria-controls="tab5"
					role="tab" data-toggle="tab"><h4>圖書</h4></a></li>	
			</ul>

		<!-- 標籤面板：內容區 --> 
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="tab1">
					<table class="table table-hover" style="font-size:16px;border:1px solid #CCC">


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
				<div role="tabpanel" class="tab-pane" id="tab4">
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
				
				
				<div role="tabpanel" class="tab-pane" id="tab5">
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
<!-- 熱門 --> 

	</div><!--中6結束 -->


	<div class="col-xs-12 col-sm-2">
		
	</div>
	<!-- 右2結束 -->

	
</div>
	
<div class="col-xs-12 col-sm-12">
	

	<jsp:include page="/lib/publicfile/include/file/footer2.jsp" flush="true"></jsp:include>
</div>	
</body>
</html>