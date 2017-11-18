<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<html>

<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>工具人</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/lib/css/style.pro.default.css" type="text/css" />

</head>
<body>
	<div class="row ">
		<div class="col-xs-12 col-sm-12 top1">
			<div class="col-xs-12 col-sm-10">
				<div class="left">
					<h1 class="logo">
						&nbsp;ToolMan.<span>Admin</span>
					</h1>
				</div>
			</div>
			<form id="login-form" method="post" action="<%=request.getContextPath()%>/loginhandler/loginhandler.do">
			<div class="col-xs-12 col-sm-1" id="name1">XXX 你好!</div>
			<div class="col-xs-12 col-sm-1" id="name2">
				<br> <button type="submit" name="action" value="logout">登出</button></div>
				</form>
		</div>
	</div>
	<div class="row">
		<div class="col-xs-12 col-sm-12 ">
			
				<!-- 標籤面板：標籤區 -->
				<div class="header">
					<ul class="nav nav-tabs headermenu">
						<li><a
							href="<%=request.getContextPath()%>/backdesk/backdesk.jsp"><span
								class="icon icon-flatscreen"></span>首頁</a></li>
						<li><a href="#"><span class="icon icon-pencil"></span>會員管理</a></li>
						<li><a href="#"><span class="icon icon-pencil"></span>任務管理</a></li>
						<li><a href="#"><span class="icon icon-pencil"></span>討論區管理</a></li>
						<li><a href="#"><span class="icon icon-pencil"></span>排程器管理</a></li>
						<li><a
							href="<%=request.getContextPath()%>/backdesk/pro/proBackIndex.jsp"><span
								class="icon icon-pencil"></span>商城管理</a></li>
						<li><a href="<%=request.getContextPath()%>/backdesk/emp/select_page.jsp"><span class="icon icon-pencil"></span>員工管理</a></li>
					</ul>
				</div><!--header-->
			</div>
		</div>
	

	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>


</html>