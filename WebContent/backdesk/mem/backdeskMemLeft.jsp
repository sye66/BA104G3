<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/lib/css/style.pro.default.css" type="text/css" />
<style>


</style>
    <title>工具人出租</title>
</head>
<body>
	<div class="col-xs-12 col-sm-2  left01" >
	
	<!-- 標籤面板：內容區 -->
		<div role="" class="tab-pane active " id="tab1">
			<div class="list-group">
				<a href="<%=request.getContextPath()%>/backdesk/mem/backdeskMemIndex.jsp" class="list-group-item">&nbsp;&nbsp;會員資料查詢</a> 
				<a href="<%=request.getContextPath()%>/backdesk/mem/backdeskUpdateListAllMem.jsp" class="list-group-item">&nbsp;&nbsp;會員權限修改</a> 
			</div>
	</div><!--rol -->
 	</div><!--2 -->
	<script src="https://code.jquery.com/jquery.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>