<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.rank.model.*"%>
<%@ page import="com.mem.model.*"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	RankService rankSvc = new RankService();
	List<RankVO> list = rankSvc.getWNRank();
	
	List<RankVO> list1 = rankSvc.getMNRank();
	List<RankVO> list2 = rankSvc.getSNRank();
	List<RankVO> list3 = rankSvc.getWCRank();
	List<RankVO> list4 = rankSvc.getMCRank();
	List<RankVO> list5 = rankSvc.getSCRank();
	pageContext.setAttribute("list",list);
	pageContext.setAttribute("list1",list1);
	pageContext.setAttribute("list2",list2);
	pageContext.setAttribute("list3",list3);
	pageContext.setAttribute("list4",list4);
	pageContext.setAttribute("list5",list5);
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
		hr{
			color : red;
		}
	</style>
</head>
<body style="background-color : #ffc">

<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true" />
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	
	<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-6">
					<div class="panel panel-primary">
					  <div class="panel-heading">
					    <h3 class="panel-title">任務數量排行榜</h3>
					  </div>
					  <div role="tabpanel">
					    <!-- 標籤面板：標籤區 -->
					    <ul class="nav nav-tabs" role="tablist">
					        <li role="presentation" class="active">
					            <a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">週排行</a>
					        </li>
					        <li role="presentation">
					            <a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">月排行</a>
					        </li>
					        <li role="presentation">
					            <a href="#tab3" aria-controls="tab3" role="tab" data-toggle="tab">季排行</a>
					        </li>
					    </ul>
					
					    <!-- 標籤面板：內容區 -->
					    <div class="tab-content">
					        <div role="tabpanel" class="tab-pane active" id="tab1">
					        	<table>
					        	<c:forEach var="rankVO" items="${list}">
					        		<IMG SRC="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${rankVO.mem_No}" width="200px" height="200px"><br><br><hr color="red"><br><br>
					        	</c:forEach>
					        	</table>
					        </div>
					        <div role="tabpanel" class="tab-pane" id="tab2">
					        	<c:forEach var="rankVO" items="${list1}">
					        		<IMG SRC="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${rankVO.mem_No}" width="200px" height="200px"><br><br><hr color="red"><br><br>
					        	</c:forEach>
					        </div>
					        <div role="tabpanel" class="tab-pane" id="tab3">
					        	<c:forEach var="rankVO" items="${list2}">
					        		<IMG SRC="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${rankVO.mem_No}" width="200px" height="200px"><br><br><hr color="red"><br><br>
					        	</c:forEach>
					        </div>					        
					    </div>
					</div>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6">
					<div class="panel panel-primary">
					  <div class="panel-heading">
					    <h3 class="panel-title">任務積分排行榜</h3>
					  </div>
					  <div role="tabpanel">
					    <!-- 標籤面板：標籤區 -->
					    <ul class="nav nav-tabs" role="tablist">
					        <li role="presentation" class="active">
					            <a href="#tab4" aria-controls="tab1" role="tab" data-toggle="tab">週排行</a>
					        </li>
					        <li role="presentation">
					            <a href="#tab5" aria-controls="tab2" role="tab" data-toggle="tab">月排行</a>
					        </li>
					        <li role="presentation">
					            <a href="#tab6" aria-controls="tab3" role="tab" data-toggle="tab">季排行</a>
					        </li>
					    </ul>
					
					    <!-- 標籤面板：內容區 -->
					    <div class="tab-content">
					        <div role="tabpanel" class="tab-pane active" id="tab4">
					        	<c:forEach var="rankVO" items="${list3}">
					        		<IMG SRC="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${rankVO.mem_No}" width="200px" height="200px"><br><br><hr color="red"><br><br>
					        	</c:forEach>
					        </div>
					        <div role="tabpanel" class="tab-pane" id="tab5">
					        	<c:forEach var="rankVO" items="${list4}">
					        		<IMG SRC="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${rankVO.mem_No}" width="200px" height="200px"><br><br><hr color="red"><br><br>
					        	</c:forEach>
					        </div>
					        <div role="tabpanel" class="tab-pane" id="tab6">
					        	<c:forEach var="rankVO" items="${list5}">
					        		<IMG SRC="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${rankVO.mem_No}" width="200px" height="200px"><br><br><hr color="red"><br><br>
					        	</c:forEach>
					        </div>					        
					    </div>
					</div>
					</div>
				</div>
			</div>
		</div>
		
		<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</html>