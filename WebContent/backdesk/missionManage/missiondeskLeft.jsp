<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/lib/css/style.pro.default.css" type="text/css" />

<style>
#tabbbb .list-group a{
    		color: #000;
    		font-size: 20px;
    		font-family: Microsoft JhengHe;
    		background-color: #F5F5F5;
    		 margin-top: 1;
    	}

.left01 {
	border-right:1px solid black;
	border-color:#ccc;
	height:100%;
	padding:0;
}

#tabbbb .list-group  a:hover {
	color:#f90;
	background-color: #34445e;	
}
#tabbbb .list-group  a:focus {
	color: #FB9337;
	background-color: #34445e;
}
</style>
</head>
<body>
<div class="col-xs-12 col-sm-2  left01" >
	<!-- 標籤面板：內容區 -->
		<div role="tabpanel" class="tab-pane active " id="tabbbb">
			<div class="list-group">
				<a href="<%=request.getContextPath()%>/backdesk/missionManage/missionManage.jsp" class="list-group-item">&nbsp;&nbsp;檢舉任務管理</a> 
				<a href="<%=request.getContextPath()%>/backdesk/disputecase/disputecase_Manage.jsp" class="list-group-item">&nbsp;&nbsp;爭議事件處理</a> 
				<a href="#" class="list-group-item">&nbsp;&nbsp;官方任務管理</a> 
			</div>
	</div><!--rol -->
 	</div><!--2 -->
	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>