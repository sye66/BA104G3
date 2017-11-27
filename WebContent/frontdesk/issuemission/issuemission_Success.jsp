<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Title Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/lib/css/issuemission/animate.css">
    <meta http-equiv="refresh" content="3; URL=<%=request.getContextPath()%>/frontdesk/issuemission/issuemission.jsp">
    <style type="text/css">
        body {
            background-image: url(<%=request.getContextPath()%>/res/images/issuemission/issuemission_Success.jpg);
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            background-size: cover;
            font-family: Microsoft JhengHei;
        }
    </style>
	</head>
	
    <body>
        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
        <%@ include file="/lib/publicfile/include/file/navbar.jsp"%>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12 fadeInLeft animated" style="text-align: center;">
                    <p style="font-family: Microsoft JhengHei; color: white; font-size: 600%;">任務新增成功!</p>
                    <p style="font-family: Microsoft JhengHei; color: white; font-size: 550%;">3秒後轉向發案頁面</p>
                </div>
            </div>
        </div>
        
        
        <script src="https://code.jquery.com/jquery.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    </body>

</html>