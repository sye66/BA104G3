<%@page import="java.util.*"%>
<%@page import="com.getmission.model.*"%>
<%@page import="com.getmission.controller.*"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.getmission.model.*"%>

<%
GetMissionService getMissionService = new GetMissionService(); 

List<GetMissionVO> listMemMissionPending = getMissionService.findByMem("M000002",1);
List<GetMissionVO> listMemMission = getMissionService.findByMem("M000002",1);
%>
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
	                    <li><a href="<%=request.getContextPath()%>/lib/css/issuemission/SanderTemplate.css">會員中心</a></li>
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
	<!-- MissionControlPanel -->
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-8 mg20">
				<%-- 任務管理面板 --%>
					<div role="tabpanel">
					    <!-- 標籤面板：標籤區 -->
					    <ul class="nav nav-tabs" role="tablist">
					        <li role="presentation" class="active">
					            <a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">已發任務一覽</a>
					        </li>
					        <li role="presentation">
					            <a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">接案人申請列表</a>
					        </li>
					        <li role="presentation">
					            <a href="#tab3" aria-controls="tab3" role="tab" data-toggle="tab">待結案與評價</a>
					        </li>
					    </ul>
					
					    <!-- 標籤面板：內容區 -->
					    <div class="tab-content">
					        <div role="tabpanel" class="tab-pane active" id="tab1">
						        <table class="table table-condensed">
						        	<thead>
						        		<tr>
						        			<td><p>任務編號</p></td>
						        			<td><p>任務名稱</p></td>
						        			<td><p>發出日期</p></td>
						        		</tr>
						        	</thead>
						        	<tbody>
						        		<%for(GetMissionVO getMissionVO : listMemMissionPending){ %>
						        		<tr>
						        			<td><p><%=getMissionVO.getMission_No() %></p></td>
						        			<td><p><%=getMissionVO.getMission_Name() %></p></td>
						        			<td><p><%=getMissionVO.getMission_Release_Time() %></p></td>
						        		</tr>
						        		<%}%>
						        	</tbody>
						        </table>
					        </div>
					        <div role="tabpanel" class="tab-pane" id="tab2">
					        	<p>頭條標籤的內容</p>
					        </div>
					        <div role="tabpanel" class="tab-pane" id="tab3">
					        	<p>最新標籤的內容</p>
					        </div>
					    </div>
					</div>
				</div>
				<%-- 發案按鈕區 --%>
				<div class="col-xs-12 col-sm-4">
					
				</div>
			</div>
		</div>
	<hr>
	<!-- Google Map -->
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-12">
					<iframe width="100%" height="450" frameborder="0" style="border:0" src="https://www.google.com/maps/embed/v1/place?q=place_id:ChIJy02Q7MEjaDQRVuRcRdQpwc0&key=AIzaSyDmUVPrJAUSF9tcavKLw-7m3UWiTTjGtds" allowfullscreen></iframe>
				</div>
			</div>
		</div>
		<hr>
    <!-- =============================================================== -->
	<!-- Footer -->
		<footer><div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-4 middlesection">
					<h3>關注我們</h3>
					<img src="${pageContext.request.contextPath}/res/images/issuemission/QRcodeHigh.png" class="qrcode">
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