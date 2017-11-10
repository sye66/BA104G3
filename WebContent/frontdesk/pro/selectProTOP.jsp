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
		if ($(document).scrollTop() > 100)//60是距离顶部高度
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

	<jsp:include page="/frontdesk/pro/selectOneClassPro.jsp" flush="true" />



	</div><!--中6結束 -->

		<div class="col-xs-12 col-sm-2">
		
		
		</div>
		<!--右2結束 -->







	</div>
	<!--大12結束 -->





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