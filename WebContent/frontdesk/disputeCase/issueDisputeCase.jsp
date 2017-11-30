<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.mem.model.*" %>
<%
	MemVO memVO = (MemVO) request.getSession().getAttribute("memVO");
%>
<c:if test="${(memVO.mem_No) == null}">
	<c:redirect url="${request.getContextPath()}/lib/publicfile/include/file/index.jsp" />
</c:if>

<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>爭議案件</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<style type="text/css">
	        body {
	            background-image: url(<%=request.getContextPath()%>/res/images/disputecase/insult_1920.jpg);
	            background-repeat: no-repeat;
	            background-attachment: fixed;
	            background-position: center;
	            background-size: cover;
	            font-family: Microsoft JhengHei;
	        }
	       label,p {
	       	color: white;
	       }
	    </style>
		<script type="text/javascript">
			$(function (){
			 
			    function format_float(num, pos)
			    {
			        var size = Math.pow(10, pos);
			        return Math.round(num * size) / size;
			    }
			 
			    function preview(input) {
			 
			        if (input.files && input.files[0]) {
			            var reader = new FileReader();
			            
			            reader.onload = function (e) {
			                $('.preview').attr('src', e.target.result);
			                var KB = format_float(e.total / 1024, 2);
			                $('.size').text("檔案大小：" + KB + " KB");
			            }
			 
			            reader.readAsDataURL(input.files[0]);
			        }
			    }
			 
			    $("body").on("change", "#dispute_Attachment", function (){
			        preview(this);
			    })
			})
		</script>	
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
	</head>
	<body>
		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-12">
					<p><font color='white'>請修正以下錯誤:</font></p>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color:white"><p>${message}</p></li>
						</c:forEach>
					</ul>
				</div>
			</div>
		</div>
		</c:if>
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-8 col-sm-offset-2">
					<p style="font-size:450%">抱歉讓你受委屈了</p>
					<p style="font-size:200%">似乎接案人讓您不是很滿意，<span style="background-color: black;color: black;">雖然我們不CARE</span>請在下方填入發生了甚麼事情，我們<span style="background-color: black;color: black;">大概等到明年</span>將在第一時間為您處理</p>

					<%-- 表單開始 --%>
						<form method="post" action="<%=request.getContextPath()%>/disputecase/disputecase.do" enctype="multipart/form-data">
							<input type="hidden" name="action" value="issue_Dispute_Case">
							<input type="hidden" name="dispute_Mem_No" value="<%=memVO.getMem_No()%>">
							<input type="hidden" name="mission_No" value="<%=request.getParameter("mission_No")%>">
							<div class="form-group">
								<label for="dispute_Content">申訴內容</label>
								<input type="text" name="dispute_Content" id="dispute_Content" placeholder="臣等恭營聖旨" class="form-control" height="300px;">
							</div>
							<%-- 圖片 --%>
							<div class="form-group">
								<label for="dispute_Attachment">申訴附件</label>

								<input type="file" name="dispute_Attachment" id="dispute_Attachment" class="form-control">

		        				<img class="preview" style="max-width: 600px; max-height: 600px;">
							</div>
							<div style="text-align: center;">
								<input type="submit" class=" btn btn-danger btn-lg" value="給我弄死他！">
							</div>
						</form>
				</div>
			</div>
		</div>

	</body>
</html>