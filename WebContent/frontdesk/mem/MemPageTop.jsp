<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel=stylesheet type="text/css" href="css/homepage.css">
		<script type="text/javascript" src="js/*"></script>
		
		
		<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
  
  </style>
  
<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>
  
<style>
    img{
        max-height:200px; 
        max-width:300px;
        cursor: pointer;
        margin:10px;
    }    
</style>
</head>
<body>

<!-- navbar==================================================================================		 -->

<nav class="navbar navbar-default" role="navigation" style="">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
				<span class="sr-only">選單切換</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a href="<%= request.getContextPath() %>/frontdesk/mem/index.jsp"><img src="res/POTM007ca6_1.png"></a>
		</div>
		
		<!-- 手機隱藏選單區 -->
		<div class="collapse navbar-collapse navbar-ex1-collapse">
			<!-- 左選單 -->
			<!-- <ul class="nav navbar-nav">
				<li class="active"><a href="#"></a></li>
				<li><a href="#"></a></li>
				<li><a href="#"></a></li>
				<li><a href="#">暫時空白</a></li>
			</ul> -->
		
			<!-- 搜尋表單 -->
			<form class="navbar-form navbar-left" role="search">
				<div class="form-group">
					<!-- <input type="text" class="form-control" placeholder="請輸入關鍵字"> -->
				</div>
				<!-- <button type="submit" class="btn btn-default">搜尋</button> -->
			</form>
		
			<!-- 右選單 -->
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#"> XXX 您好 </a></li>
				<li><a href="#"><i class="glyphicon glyphicon-log-in"></i> 登入 </a></li>
				<li><a href="memPage.html"><i class="glyphicon glyphicon-user"></i> 會員中心 </a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-font"></i> 繁體中文 <b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a href="#">繁體中文</a></li>
						<li><a href="#">English</a></li>
						<li><a href="#">日本語</a></li>
					</ul>
				</li>
			</ul>
		</div>
		<!-- 手機隱藏選單區結束 -->
	</div>
</nav>
























 <!-- tool men for rent ==========================================================================-->


<div class="container">
	<div class="row">
		<div align="center" class="col-xs-12 col-sm-12 main-bar"><p id="main-bar" align="center" margin="auto"><img src="res/POTM-iloveimg-resized.png">　　Tool Men for Rent</p>
		</div>
	</div>
</div><br>




















 <!-- function ====================================================================================-->


 <div class="container">
 	<div align="center" class="row">
 		<div class="col-xs-12 col-sm-2">

 			<a href="#"><img id="function-btn" src="https://api.fnkr.net/testimg/120x80/B4DCED/FFF/?text=Ranking"><p></p></a>
 			
 		</div>
 		<div class="col-xs-12 col-sm-2">
 			<a href="#"><img id="function-btn" src="https://api.fnkr.net/testimg/120x80/B4DCED/FFF/?text=DashBoard"><p></p></a>
 			
 		</div>
 		<div class="col-xs-12 col-sm-2">
 			<a href="#"><img id="function-btn" src="https://api.fnkr.net/testimg/120x80/B4DCED/FFF/?text=Post Mission"><p></p></a>
 			
 		</div>
 		<div class="col-xs-12 col-sm-2">
 			<a href="#"><img id="function-btn" src="https://api.fnkr.net/testimg/120x80/B4DCED/FFF/?text=Search Mission"><p></p></a>
 			
 		</div>
 		<div class="col-xs-12 col-sm-2">
 			<a href="#"><img id="function-btn" src="https://api.fnkr.net/testimg/120x80/B4DCED/FFF/?text=Forum"><p></p></a>
 			
 		</div>
 		<div class="col-xs-12 col-sm-2">
 			<a href="#"><img id="function-btn" src="https://api.fnkr.net/testimg/120x80/B4DCED/FFF/?text=Mall"><p></p></a>
 			
 		</div>
 	</div>
 </div>



	<!-- <hr color="#996400"> -->


<!-- 麵包屑 -->


<ol class="breadcrumb">
	<li>
		<a href="<%= request.getContextPath() %>/frontdesk/mem/index.jsp">首頁</a>
	</li>
	<li>
		<a href="<%= request.getContextPath() %>/frontdesk/mem/select_page.jsp">會員中心</a>
	</li>
	<!-- <li class="active">媽我上電視了</li> -->
</ol>




</body>
</html>