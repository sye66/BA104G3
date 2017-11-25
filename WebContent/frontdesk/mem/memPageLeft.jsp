<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>工具人出租</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/homepage.css">
<%-- 		<script type="text/javascript" src="<%=request.getContextPath()%>/lib/js/mem/homepage.js"></script> --%>
		
<%--		
		<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
  
  </style>
  
<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>
  
<style>
    img{
        max-height:200px; 
        max-width:300px;
        cursor: pointer;
        margin:10px;
    }    
</style> --%>

<style>
#noUnderLine{text-decoration:none;}
</style>
</head>
<body>

<!-- 請放內容 ==================================================================================-->
<br><br>
		<div class="container">
	<div class="row">
        <div class="col-xs-12 col-sm-3">
            <div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
                <!-- 區塊1 -->
                <div class="panel panel-info">
                    <div class="panel-heading" role="tab" id="panel1">
                        <h4 class="panel-title">
			        <a id="noUnderLine" href="#aaa" data-parent="#accordion2" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="aaa">
			         <h2> 會員資料管理</h2>
			        </a>
			      </h4>
                    </div>
                    <div id="aaa" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="panel1">
                        <div class="panel-body">
                        <c:if test="${memVO.mem_State == 0 }">
                        	<h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/mem/memAuthentication.jsp">會員驗證</a></h3>
                        </c:if>
                            <h3><a id="noUnderLine" href="<%= request.getContextPath() %>/frontdesk/mem/memUpdateFile.jsp">修改會員資料</a></h3>
                            <h3><a id="noUnderLine" href="#">忘記密碼</a></h3>
                        </div>
                    </div>
                </div>
                 <!-- 區塊2 -->
                <div class="panel panel-info">
                    <div class="panel-heading" role="tab" id="panel2">
                        <h4 class="panel-title">
			        <a id="noUnderLine" href="#bbb" data-parent="#accordion2" data-toggle="collapse" role="button" class="collapsed" aria-expanded="false" aria-controls="bbb">
			           <h2> 儲值</h2>
			        </a>
			      </h4>
                    </div>
                    <div id="bbb" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel2">
                        <div class="panel-body">
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/stored_history/stored_historyRecharge_PointCard.jsp">點數卡儲值</a></h3>
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/stored_history/rechage_credit.jsp">信用卡儲值</a></h3>
                        </div>
                    </div>
                </div>
                <!-- 區塊3 -->
                <div class="panel panel-info">
                    <div class="panel-heading" role="tab" id="panel3">
                        <h4 class="panel-title">
			        <a id="noUnderLine" href="#ccc" data-parent="#accordion2" data-toggle="collapse" role="button" class="collapsed" aria-expanded="false" aria-controls="ccc">
			           <h2> 歷史紀錄查詢</h2>
			        </a>
			      </h4>
                    </div>
                    <div id="ccc" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel3">
                        <div class="panel-body">
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/stored_history/stored_historyReview.jsp">儲值歷史紀錄</a></h3>
                            <h3><a id="noUnderLine" href="#">接案歷史紀錄</a></h3>
                        </div>
                    </div>
                </div>
                <!-- 區塊4 -->
                <div class="panel panel-info">
                    <div class="panel-heading" role="tab" id="panel4">
                        <h4 class="panel-title">
			        <a id="noUnderLine" href="#ddd" data-parent="#accordion2" data-toggle="collapse" role="button" class="collapsed" aria-expanded="false" aria-controls="ddd">
			           <h2> 疑難困惑解答區</h2>
			        </a>
			      </h4>
                    </div>
                    <div id="ddd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel4">
                        <div class="panel-body">
                            <h3><a id="noUnderLine" href="#">ＦＡＱ</a></h3>
                            <h3><a id="noUnderLine" href="#">免責條款</a></h3>
                        </div>
                    </div>
                </div>
                <!-- 區塊5 -->
                <div class="panel panel-info">
                    <div class="panel-heading" role="tab" id="panel5">
                        <h4 class="panel-title">
			        <a id="noUnderLine" href="#eee" data-parent="#accordion2" data-toggle="collapse" role="button" class="collapsed" aria-expanded="false" aria-controls="eee">
			           <h2> 好友</h2>
			        </a>
			      </h4>
                    </div>
                    <div id="eee" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel5">
                        <div class="panel-body">
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/follow_tm/followTm.jsp">關注工具人按鈕</a></h3>
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/follow_tm/followTmList.jsp">關注工具人列表</a></h3>
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/relation/addRelationship.jsp">加好友按鈕</a></h3>
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/relation/beAppliedRelationship.jsp">好友申請</a></h3>
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/relation/friendlList.jsp">好友列表</a></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
</body>
</html>