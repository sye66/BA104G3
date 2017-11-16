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
		if ($(document).scrollTop() > 60)//这个60是距离顶部高度
		{
			$("#ontopDiv").addClass('float');//
		} else {
			$("#ontopDiv").removeClass('float');
		}
	}
	
</script>

</head>
<body>
<%

	String mem_No = "M000001";

	ProService proSvc = new ProService();
	List<ProVO> list = proSvc.getAll();
	@SuppressWarnings("unchecked")
	Vector<ProCartVO> buylist =  (Vector<ProCartVO>) session.getAttribute("shoppingcart");
	int count = 0;
	if(buylist != null && (buylist.size() > 0)){
		count = buylist.size();
	}
	
	//追蹤
	int count2 = 0;
	ProTrackService proTrackSvc = new ProTrackService();
	List<ProTrackVO> listProTrack = proTrackSvc.getOnePro(mem_No);
	if(listProTrack != null && (listProTrack.size() > 0)){
		count2 = listProTrack.size();
	
	}
	//清單
	int count3 = 0;
	ProOrderService proOrderSvc = new ProOrderService();
	List<ProOrderVO> listProOrder = proOrderSvc.listProOrder(mem_No);
	if(listProOrder != null && (listProOrder.size() > 0)){
		count3 = listProOrder.size();
		
	}
	
%>
<jsp:useBean id="proClassSvc" scope="page" class="com.proclass.model.ProClassService" />


<!--搜尋12 -->
<div class="col-xs-12 col-sm-12 " id="ontopDiv">
		<!--搜尋 -->
		<div class="col-xs-12 col-sm-4 col-sm-offset-3">
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" name="form1">
				<table >
					<tr style="font-size:20px;text-align:center;">
						<td style="width:200px;"> </td>	
						<td><select size="1" name="pro_Class_No" style="height: 36px;">
         			 		<option value="">分類
        					<c:forEach var="proClassVO" items="${proClassSvc.all}" > 
        					<option value="${proClassVO.pro_Class_No}">${proClassVO.pro_Class_Name}
        					</c:forEach>   
       						</select>
				   		</td>
						<td>
							<input type="text" name="pro_Name" value="" placeholder="請輸入商品關鍵字" style="height: 36px;marager-top:0px;">
						</td>	
						<td>
							<button type="submit" class="btn btn-secondary" style="font-size:16px;"><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/resizeApi.png" style="height: 20px;">搜尋</button>
        					<input type="hidden" name="action" value="listPro_ByCompositeQuery">
						</td>	
					</tr>		
				</table>
			</FORM>	

<!-- 			<div class="input-group select01"> -->
<!-- 				<span class="input-group-btn">  -->
<!-- 				<a href="" class="btn btn-info dropdown-toggle select01" -->
<!-- 					data-toggle="dropdown">分類 <b class="caret"></b></a> -->
<!-- 					<ul class="dropdown-menu"> -->
<%-- 						<c:forEach var="proClassVO" items="${proClassSvc.all}"> --%>
<!-- 							<li><a -->
<%-- 								href="<%=request.getContextPath()%>/pro/proClass.do?action=getOneClassPro&pro_Class_No=${proClassVO.pro_Class_No}">${proClassVO.pro_Class_Name} --%>
								
<!-- 								</a></li> -->
<%-- 						</c:forEach> --%>
<!-- 					</ul> -->
<!-- 				</span>  -->
<!-- 				<input type="text" class="form-control select01" placeholder="請輸入" -->
<!-- 					id="bb"> <span class="btn input-group-addon"><i -->
<!-- 					class="glyphicon glyphicon-search "></i>搜尋</span> -->
<!-- 			</div> -->
		
		
		</div><!--搜尋結束 -->
		<!-- 購物車_通知 -->
		<div class="col-xs-12 col-sm-2 ">
			<!--購物車-->
			<span>&nbsp;&nbsp;&nbsp;
			<a href="<%=request.getContextPath()%>/frontdesk/pro/cart.jsp">
			<img alt="購物車" src="<%=request.getContextPath()%>/res/images/pro_icons/cart01.gif" 
				 style="height: 40px;"></a></span>
			<span class="badge"><%=count%></span>
			<span class="sr-only">unread messages</span>					
			<!--購物車-->
			<!--清單 -->
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="<%=request.getContextPath()%>/pro/proOrderServlet.do?action=getListProOrder ">
				<img alt="清單" src="<%=request.getContextPath()%>/res/images/pro_icons/top03.gif"
					 style="height: 35px;"></a></span>
			<span class="badge"><%=count3%></span>
			<!--清單 -->
			<!--通知 -->				
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="
<%-- 				<%=request.getContextPath()%>/frontdesk/pro/cart.jsp --%>
				">
				<img alt="通知" src="<%=request.getContextPath()%>/res/images/pro_icons/1183340.gif"
					 style="height: 40px;"></a></span>
			<span class="badge" >10</span>
			<!--通知 -->									
		</div>
		<!-- d2  結束-->
		
		<div class="col-xs-12 col-sm-2"><!--空 --></div>
		
	</div><!--搜尋結束 12 -->




	

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