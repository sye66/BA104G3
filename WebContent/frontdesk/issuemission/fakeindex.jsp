<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Title Page</title>
	
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <!-- TODO記得要放專案路徑 -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/lib/css/issuemission/SanderTemplate.css">
    <!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
    <style type="text/css">
	/* 對齊div用 */
    	/*div{border: 1px solid grey;}*/
    /* 字體from Google	 */
    	/* @import url(//fonts.googleapis.com/earlyaccess/notosanstc.css);
    	font-family: 'Noto Sans TC', sans-serif; */
    </style>

</head>



<body>
    <!-- 導覽列(NavBar) -->
    	<!-- 我選擇的是沒有固定(fixed)的，搜尋欄位已經被手動刪掉 -->
	    <nav class="navbar navbar-default navbarreset" role="navigation">
	        <div class="container" style="margin-top: 0;">
	            <div class="navbar-header">
	                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
	                    <span class="sr-only">選單切換</span>
	                    <span class="icon-bar"></span>
	                    <span class="icon-bar"></span>
	                    <span class="icon-bar"></span>
	                </button>
	                <a class="navbar-brand" href="#">這裡放Logo</a>
	            </div>
	            <!-- 手機隱藏選單區 -->
	            <div class="collapse navbar-collapse navbar-ex1-collapse">
	                <!-- 右選單 -->
	                <ul class="nav navbar-nav navbar-right">
	                    <li><a href="#">陳柏炘 您好</a></li>
	                    <li><a href="#">登出</a></li>
	                    <li><a href="#">會員中心</a></li>
	                    <li class="dropdown">
	                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">繁體中文 <b class="caret"></b></a>
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
    <!-- =============================================================== -->
    <!-- 標籤列 -->
	    <!-- 第一版設計(未使用) -->
		    <!-- 
			<div class="container">
				<div class="row">
					<div class="col-xs-12 col-sm-2"><div class="css_button">test</div></div>
					<div class="col-xs-12 col-sm-2"><div class="css_button">test</div></div>
					<div class="col-xs-12 col-sm-2"><div class="css_button">test</div></div>
					<div class="col-xs-12 col-sm-2"><div class="css_button">test</div></div>
					<div class="col-xs-12 col-sm-2"><div class="css_button">test</div></div>
					<div class="col-xs-12 col-sm-2"><div class="css_button">test</div></div>
				</div>
			</div>
			-->
	    <!-- 第二版設計(使用) -->
            <div class="col-xs-12 col-sm-12 mt40 mb20 z10">
                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-sm-2">
                            <div class="css_button">排行榜</div>
                        </div>
                        <div class="col-xs-12 col-sm-2">
                            <div class="css_button">發案區</div>
                        </div>
                        <div class="col-xs-12 col-sm-2">
                            <div class="css_button">接案區</div>
                        </div>
                        <div class="col-xs-12 col-sm-2">
                            <div class="css_button">討論區</div>
                        </div>
                        <div class="col-xs-12 col-sm-2">
                            <div class="css_button">積分商城</div>
                        </div>
                        <div class="col-xs-12 col-sm-2">
                            <div class="css_button">Dashboard</div>
                        </div>
                    </div>
                </div>
            </div>
	<!-- =============================================================== -->
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-12">
				<a href="<%=request.getContextPath()%>/frontdesk/issuemission/MissionIssue.jsp">
					<img src="<%=request.getContextPath()%>/res/images/issuemission/EnterPng.png" style="height: 100px;width: 100px;">
				</a>
			</div>
		</div>
	</div>
    <!-- =============================================================== -->
	<!-- Footer -->
		<footer><div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-4 middlesection">
					<h3>關注我們</h3>
					<img src="images/QRcodeHigh.png" class="qrcode">
				</div>
				<div class="col-xs-12 col-sm-8">
					<h3>聯絡我們</h3>
					<br><br>
					<p>三德葛格與他快樂的小夥伴資訊開發公司</p>
					<p><span class="glyphicon glyphicon-map-marker">	320桃園市中壢區中大路300號</span></p>
					<p><span class="glyphicon glyphicon-phone">    0908-118-882</span></p>
					<p><span class="glyphicon glyphicon-envelope">    sanderxavalon@gmail.com</span></p>
				</div>
			</div>
		</div></footer>
	<!-- disclaim -->
		<div class="containerodd">
			<div class="container containerodd">
				<div class="row">
					<div class="col-xs-12 col-sm-12 middlesection mt40"><p>All Rights Reserved 2017 © toolmanforrent.com.tw</p>
					</div>
				</div>
			</div>
		</div>
	<!-- =============================================================== -->
	<!-- =============================================================== -->
	<!-- =============================================================== -->




    <script src="https://code.jquery.com/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>

</html>