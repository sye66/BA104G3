<%@page import="java.io.OutputStream"%>
<%@page import="com.businessrefinery.barcode.QRCode"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.businessrefinery.barcode.Barcode"%>

<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<title>Title Page</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
	</head>
	<body>
		
		<h1 class="text-center">案件處理成功!</h1>
		
		<input type="text" name="aaa" id="aaa">
		<button id="yahoo">Test</button>

		<script type="text/javascript">
			$("#yahoo").click(function(){
				$.ajax({
					url: 'http://localhost:8081/BA104G3/disputecase/disputecase.do',
					type: 'post',
					data:{
						action: "ajax_test",
						aaa: $("#aaa").val()
					},
					success: function(responce){
						window.alert("done");
					}

				})

			})
		</script>
	</body>
</html>