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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">




</head>
<body>

<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/proNavbar.jsp" flush="true"/> 
</div>
<!-- 商城TOP -->
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/selectProTOP.jsp" flush="true" />	
</div>




	

	<div class="col-xs-12 col-sm-2 col-sm-offset-1">
		<br><br><br>
		<div class="panel panel-info left001">
			<div class="panel-heading">
				<div class="panel-title">
					<h3 align="center">排行榜</h3>
				</div>
			</div>
			<div class="panel-body" >
	<div class="row">
					
					
<jsp:include page="/frontdesk/pro/selectProTop10.jsp" flush="true" />	
			
		</div>	
				
			</div>
		</div>

	</div>
	
	<!-- 左2結束 -->


	
	<div class="col-xs-12 col-sm-6">
	<!--麵包屑 -->
		<div class="col-xs-12 col-sm-12">

			<br>
			<ol class="breadcrumb">
				<li><a href="http://localhost:8081/BA104G3/lib/publicfile/include/file/index.jsp">首頁</a></li>
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


<!-- 所有商品 -->
<div class="col-xs-12 col-sm-12" >

<div style="text-align:center ">
<jsp:include page="/frontdesk/pro/selectAllPro.jsp" flush="true" />
</div>
</div><!-- 所有商品 -->

<!-- 熱門 -->
<!-- <div class="col-xs-12 col-sm-12"> -->
<!-- 		<div role="tabpanel"> -->
			<!-- 標籤面板：標籤區 -->
<!-- 			<ul class="nav nav-tabs" role="tablist"> -->
<!-- 				<li role="presentation" class="active"><a href="#tab1" -->
<!-- 					aria-controls="tab1" role="tab" data-toggle="tab"><h2>熱門</h2></a></li> -->
<!-- 				<li role="presentation"><a href="#tab2" aria-controls="tab2" -->
<!-- 					role="tab" data-toggle="tab"><h2>熱門</h2></a></li> -->
<!-- 				<li role="presentation"><a href="#tab3" aria-controls="tab3" -->
<!-- 					role="tab" data-toggle="tab"><h2>熱門</h2></a></li> -->
<!-- 				<li role="presentation"><a href="#amos" aria-controls="amos" -->
<!-- 					role="tab" data-toggle="tab"><h2>熱門</h2></a></li> -->
<!-- 			</ul> -->

		<!-- 標籤面板：內容區 --> 
<!-- 			<div class="tab-content"> -->
<!-- 				<div role="tabpanel" class="tab-pane active" id="tab1"> -->
<!-- 					<table class="table table-hover"> -->


<!-- 						<tbody> -->
<!-- 							<tr> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/00ED21/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/002ED1/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/002ED1/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/20CED1/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 							</tr> -->

<!-- 						</tbody> -->
<!-- 					</table> -->
<!-- 				</div> -->
<!-- 				<div role="tabpanel" class="tab-pane" id="tab2"> -->
<!-- 					<table class="table table-hover"> -->


<!-- 						<tbody> -->
<!-- 							<tr> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/02CED1/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/001ED1/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/00C1D1/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/00CE11/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 							</tr> -->

<!-- 						</tbody> -->
<!-- 					</table> -->
<!-- 				</div> -->
<!-- 				<div role="tabpanel" class="tab-pane" id="tab3"> -->
<!-- 					<table class="table table-hover"> -->


<!-- 						<tbody> -->
<!-- 							<tr> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/10CED1/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/001ED1/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/0aCED1/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/00aED1/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 							</tr> -->

<!-- 						</tbody> -->
<!-- 					</table> -->

<!-- 				</div> -->
<!-- 				<div role="tabpanel" class="tab-pane" id="amos"> -->
<!-- 					<table class="table table-hover"> -->


<!-- 						<tbody> -->
<!-- 							<tr> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/00aED1/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/00CED1/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/00CEa1/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 								<td><div> -->
<!-- 										<a href=""> <img -->
<!-- 											src="https://api.fnkr.net/testimg/170x200/00CEDa/FFF/?text=img+placeholder">XXXXXX -->
<!-- 										</a> -->
<!-- 										<p>SSSS</p> -->
<!-- 										<p> -->
<!-- 											$987 <input type="button" name="" value="購買"> -->
<!-- 										</p> -->

<!-- 									</div></td> -->
<!-- 							</tr> -->

<!-- 						</tbody> -->
<!-- 					</table> -->

<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!--  </div> -->
<!-- 熱門 --> 

	</div><!--中6結束 -->


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
<div class="col-xs-12 col-sm-12">
	<footer class="text-center">
      <div class="footer-above">
        <div class="container">
          <div class="row">
            <div class="footer-col col-md-4">
              <h2>Location</h2>
              <p>桃園市平鎮區
                <br>中央路300號</p>
              <br><br>
              <h2>Contact us</h2>
              <p>03-3345678</p>
            </div>
            <div class="footer-col col-md-4">
              <h3>Around the Web</h3>
              <ul class="list-inline">
                <li class="list-inline-item">
                  <a class="btn-social btn-outline" href="">
                    <i class="fa fa-fw fa-facebook"></i>
                  </a>
                </li>
                <li class="list-inline-item">
                  <a class="btn-social btn-outline" href="">
                    <i class="fa fa-fw fa-google-plus"></i>
                  </a>
                </li>
                <li class="list-inline-item">
                  <a class="btn-social btn-outline" href="">
                    <i class="fa fa-fw fa-twitter"></i>
                  </a>
                </li>
              </ul>
            </div>
            <div class="footer-col col-md-4">
              <h3>QR code</h3>
              <p>
                <img src="<%=request.getContextPath()%>/lib/publicfile/include/img/QRcode/static_qr_code_100.jpg"></p>
            </div>
          </div>
        </div>
      </div>
      <div class="footer-below">
        <div class="container">
          <div class="row">
            <div class="col-lg-12">
              Copyright &copy; POTM 2017
            </div>
          </div>
        </div>
      </div>
    </footer>

    <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
    <div class="scroll-top d-lg-none">
      <a class="btn btn-primary js-scroll-trigger" href="#page-top">
        <i class="fa fa-chevron-up"></i>
      </a>
    </div>

<%-- 	<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include> --%>
</div>	
</body>
</html>