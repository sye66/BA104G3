<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.rank.model.*"%>
<%@ page import="com.relation.model.*"%>
<%@ page import="com.artiForm.model.*"%>
<%@ page import="com.relation.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

<jsp:useBean id="RelationSvc" scope="page" class="com.relation.model.RelationService"/>

<% 
	MemVO memVO = (MemVO)session.getAttribute("memVO");
	String mem_No = memVO.getMem_No();
	String mem_No_main = memVO.getMem_No();
	//所有會員
	MemService memSvc = new MemService();
	List<MemVO> getAllMemVO = memSvc.getAll();
	pageContext.setAttribute("getAllMemVO", getAllMemVO);
	//顯示自己排名
	RankService rankSvc = new RankService();
	RankVO rankVO = rankSvc.getOneRank(mem_No);
	pageContext.setAttribute("rankVO",rankVO);
	//顯示自己文章
	ArtiFormService artiSvc = new ArtiFormService();
	Set<ArtiFormVO> set = (Set<ArtiFormVO>)artiSvc.findArtiByMemNo(mem_No_main);
	pageContext.setAttribute("set", set);
	//顯示好友
	RelationService relationSvc = new RelationService();
	List<RelationVO> relationVO = relationSvc.getAllRelationWithMem_No(mem_No);
	pageContext.setAttribute("relationVO", relationVO);
	
%>
      <%request.getSession().setAttribute("memVO" ,memVO); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	
	
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
			<div class="col-xs-12 col-sm-4">
 				<div class="panel panel-primary">
 				  <div class="panel-heading">
 				    <h3 class="panel-title">個人</h3>
 				  </div>
 				  <div class="panel-body">
 				    <table class="table table-hover">
 				    	<tr>
 				    		<td>
 				    			<img id="img" weight="150" height="150" src="<%=request.getContextPath() %>/personalShowPic/personalShowPic.do?mem_No=${memVO.mem_No}">
 				    		</td>
 				    	</tr>
 				    	<tr>
 				    		<td>
 				    			<a href="<%=request.getContextPath()%>/frontdesk/personal/personalMissionHistory.jsp"><span class="icon icon-pencil"></span>歷史查詢</a>
 				    		</td>
 				    	</tr>
 				    	<tr>
 				    		<td>
 				    			<a href="<%=request.getContextPath()%>/frontdesk/mem/memUpdateFile.jsp"><span class="icon icon-pencil">
 				    			</span>修改個人資料</a>
 				    		</td>
 				    	</tr>
 				    	<tr>
 				    		<td>
 				    			<a href="<%=request.getContextPath()%>/frontdesk/personal/personalAchieve.jsp"><span class="icon icon-pencil"></span>成就查詢</a>
 				    		</td>
 				    	</tr>
 				    </table>				
 				  </div>
 				</div>
 			
 			
 				<div class="panel panel-primary">
 				  <div class="panel-heading">
 				    <h3 class="panel-title">其他</h3>
 				  </div>
 				  <div class="panel-body">
 				    <table class="table table-hover">
 				    	<c:forEach var="all" items="${getAllMemVO}">
	 				    	<tr>
	 				    		<td>
	 				    			<a href="<%=request.getContextPath()%>/all/all.do?mem_No=${all.mem_No}">
	 				    			<img id="img" width="50px" height="50px" src="<%=request.getContextPath() %>/personalShowPic/personalShowPic.do?mem_No=${all.mem_No}">
	 				    			</a>
	 				    		</td>	
	 				    	</tr>
 				    	</c:forEach>
 				    </table>				
 				  </div>
 				</div>
 			</div>
			
<%--  				<jsp:include page="/frontdesk/relation/beAddFriendlList.jsp" flush="true" /> --%>
			
 			<div class="col-xs-12 col-sm-8">
 				<div class="panel panel-info">
					  <div class="panel-heading">
					    <h3 class="panel-title">標題</h3>
					  </div>
					  <div class="panel-body">
					    <table class="table table-hover">
					    	<!-- <caption>我是表格標題</caption> -->
					    	<thead>
					    		<tr>
					    			<th>表格標題</th>
					    			<th>表格標題</th>
					    			<th>表格標題</th>
					    		</tr>
					    	</thead>
					    	<tbody>
					    	
					    		<tr>
					    			<td></td>
					    			<td>資料</td>
					    			<td>資料</td>
					    		</tr>
					    		<tr>
					    			<td>資料</td>
					    			<td>資料</td>
					    			<td>資料</td>
					    		</tr>
					    		
					    	</tbody>
					    </table>
					  </div>
					</div>
				<br>
				<hr color="red">
				<br>
				<div class="panel panel-info">
					  <div class="panel-heading">
					    <h3 class="panel-title">看看吧</h3>
					  </div>
					  <div class="panel-body">
					    <table class="table table-hover">
					    	<!-- <caption>我是表格標題</caption> -->
					    	<thead>
					    		<th>
					    			<a href="<%=request.getContextPath()%>/frontdesk/artiForm/listArti_ByMemNo.jsp">
					    			<button class="btn btn-warning">前往個人文章頁面</button></a>
					    		</th>
					    	</thead>
					    	<tbody>
					    	<c:forEach var="artiFormVO" items="${set}">
					    		<tr>
					    			<td>你發表了《${artiFormVO.arti_No}》這篇文章</td>
					    		</tr>
					    		<tr>
					    			<td>有${artiFormVO.arti_Like}個人說你的文章讚!</td>
					    		</tr>
					    	</c:forEach>
					    	</tbody>
					    </table>
					  </div>
					</div>
				<br>
				<hr color="red">
				<br>
				<div class="panel panel-info">
					  <div class="panel-heading">
					    <h3 class="panel-title">個人排名</h3>
					  </div>
					  <div class="panel-body">
					    <table class="table table-hover">
					    	<!-- <caption>我是表格標題</caption> -->
					    	<thead>
					    		<tr>
					    			<img src="<%=request.getContextPath()%>/frontdesk/personal/image/good.png">
					    		</tr>
					    		<tr>
					    			
					    			<th>單日數量排行</th>
					    			<th>單日積分排行</th>
					    		</tr>
					    	</thead>
					    	<tbody>
					    		<tr>
					    			<td>${rankVO.day_Number_Rank}</td>
					    			<td>${rankVO.day_Score_Rank}</td>
					    		</tr>
					    	</tbody>
					    </table>
					  </div>
					</div>
 			</div>
		</div>
	</div>
	
	<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />

</body>
</html>