<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html lang="">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>Title Page</title>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/lib/css/issuemission/Button.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
        <!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<style type="text/css">
			h1,p{
				font-family:Microsoft JhengHei;
				font-weight: 900;
			}
		</style>
    </head>
	<body>
	    <div class="container">
	        <div class="row">
	            <div class="col-xs-12 col-sm-12">
	            	<div class="row" style="text-align: center;">
	                	<h1>Oops，積分不足</h1>
	                </div>
	            	<div class="row" style="text-align: center;">
	                	<img src="<%=request.getContextPath()%>/res/images/issuemission/hahahaUCCU.jpg">
	                </div>
	                <div class="row">
		                <div class="col-xs-12 col-sm-6" style="text-align: center">
		                	<h1>老子是最瞧不起課金戰士</h1>
		                    <a href="<%=request.getContextPath()%>/frontdesk/getmission/getMission.jsp">
	                			<div class="issuemission_notenough_gogetmission_button">
		                        	<p>我要自己賺</p>
	                    		</div>
		                    </a>
		                </div>
		                <div class="col-xs-12 col-sm-6"  style="text-align: center">
		                	<h1>騷年啊，看來你需要</h1>
		                    <a href="<%=request.getContextPath()%>/frontdesk/stored_history/stored_historyRecharge_PointCard.jsp">
		                    	<div class="issuemission_notenough_goreserve_button">
		                        	<p>課金大神</p>
		                        </div>
		                    </a>
		                </div>
		            </div>
	            </div>
	        </div>
	    </div>
	    <script src="https://code.jquery.com/jquery.js"></script>
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
    </html>