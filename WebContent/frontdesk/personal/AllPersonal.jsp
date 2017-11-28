<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>
    <%@ page import="com.mem.model.*"%>
    <%@ page import="com.rank.model.*"%>
    <%@ page import="com.artiForm.model.*"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%
    	MemVO AllMemVO = (MemVO)request.getAttribute("AllMemVO");
    	String personal_No = AllMemVO.getMem_No();
    	RankService rankSvc = new RankService();
    	RankVO rankVO = rankSvc.getOneRank(personal_No);
    	pageContext.setAttribute("AllMemVO", AllMemVO);
    	pageContext.setAttribute("rankVO",rankVO);
    	ArtiFormService artiSvc = new ArtiFormService();
    	Set<ArtiFormVO> set = (Set<ArtiFormVO>)artiSvc.findArtiByMemNo(personal_No);
    	pageContext.setAttribute("set", set);
    %>
    
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
 				    <h3 class="panel-title">${AllMemVO.mem_Name}的個人小檔案</h3>
 				  </div>
 				  <div class="panel-body">
 				    <table class="table table-hover">
 				    	<tr>
 				    		<td>
 				    			<img id="img" weight="150" height="150" src="<%=request.getContextPath() %>/personalShowPic/personalShowPic.do?mem_No=${AllMemVO.mem_No}">
 				    		</td>
 				    	</tr>
 				    	<tr>
 				    		<td>
 				    			${AllMemVO.mem_Intro}
 				    		</td>
 				    	</tr>
 				    </table>				
 				  </div>
 				</div>
 			</div>
 			<div class="col-xs-12 col-sm-4">
 				<div class="panel panel-primary">
 				  <div class="panel-heading">
 				    <h3 class="panel-title">${AllMemVO.mem_Name}的個人排行</h3>
 				  </div>
 				  <div class="panel-body">
 				    <table class="table table-hover">
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
 			<div class="col-xs-12 col-sm-4">
 				<div class="panel panel-primary">
 				  <div class="panel-heading">
 				    <h3 class="panel-title">${AllMemVO.mem_Name}發表的文章</h3>
 				  </div>
 				  <div class="panel-body">
 				    <table class="table table-hover">
					    	<c:forEach var="artiFormVO" items="${set}">
					    		<tr>
					    			<td>${AllMemVO.mem_Name}發表了《${artiFormVO.arti_No}》這篇文章</td>
					    		</tr>
					    		<tr>
					    			<td>有${artiFormVO.arti_Like}個人說${AllMemVO.mem_Name}的文章讚!</td>
					    		</tr>
					    	</c:forEach>
 				    </table>				
 				  </div>
 				</div>
 			</div>
 		</div>
 	</div>	
	
	<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />

</body>
</html>