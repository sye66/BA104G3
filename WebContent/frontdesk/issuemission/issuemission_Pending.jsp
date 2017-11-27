<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>接案人驗證</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
		<style type="text/css">
			img{
				width: 200px;
			}
		</style>
	</head>
	<body>
		<%-- 抓session 會員MemVO 與任務 MissionVO 塞進Request 丟進QRcodeAccept --%> 
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-12" style="text-align: center;">
					<h1 class="text-center">接案人驗證</h1>
					<%--這裡要補完 --%>
					<img src="<%=request.getContextPath()%>/qrcode/qrcode.do?mem_No=&mission_No=">
					<form action="<%=request.getContextPath()%>/qrcodeaccept/qrcodeaccept.do">
						<input type="hidden" name="action" value="input_By_Type">
						<input type="text" name="validation">
						<input type="submit" value="驗證身分" class="btn btn-primary">
					</form>
				</div>
			</div>
		</div>
		
		
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>