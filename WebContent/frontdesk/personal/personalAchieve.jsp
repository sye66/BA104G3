<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.achieve.model.*"%>
<%@ page import="com.ach_detail.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<% 
	MemVO memVO = (MemVO) session.getAttribute("memVO");
	String mem_No = memVO.getMem_No();
	Ach_DetailService achdSvc = new Ach_DetailService();
	List<Ach_DetailVO> list = achdSvc.getPersonal(mem_No);
	pageContext.setAttribute("list",list);
// 	AchieveService achieveSvc = new AchieveService();
// 	List<Achieve> list = achieveSvc.getThree(ach_No);
	List<AchieveVO> achieveVO =(List<AchieveVO>) request.getAttribute("achieveVO");
	pageContext.setAttribute("achieveVO",achieveVO);
	List<Ach_DetailVO> ach_detailVO =(List<Ach_DetailVO>) request.getAttribute("ach_detailVO");
	pageContext.setAttribute("ach_detailVO",ach_detailVO);
%>

<%--       <%request.getSession().setAttribute("memVO" ,memVO); %> --%>
      
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
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
 				    <h3 class="panel-title">標題</h3>
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
 			</div>
 			
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
					    			<th>會員編號</th>
					    			<th>成就標題</th>
					    			<th>成就時間</th>
					    		</tr>
					    	</thead>
					    	<tbody>
							<c:forEach var="ach_DetailVO" items="${list}">
							<tr>
								<td>${ach_DetailVO.mem_No}&nbsp;&nbsp;</td>
								<td>${ach_DetailVO.ach_No}&nbsp;&nbsp;</td>
								<td>${ach_DetailVO.ach_Time}</td>
							</tr>
							</c:forEach>
							</tbody>
							<div class="panel-body">
								<form method="post"
									action="<%=request.getContextPath()%>/ach_detail/ach_detail.do">
									<button class="btn btn-warning" type="submit" name="action"
										value="achieve_Detail">成就細節</button>
								</form>
							</div>
						</table>
							
					  </div>
				</div>
				<div class="panel panel-info">
					  <div class="panel-heading">
					    <h3 class="panel-title">標題</h3>
					  </div>
					  <div class="panel-body">
					    <table class="table table-hover">
					    	<!-- <caption>我是表格標題</caption> -->
					    	<thead>
					    		<tr>
					    			<th>成就名稱</th>
					    			<th>成就圖片</th>
					    			<th>成就說明</th>
					    		</tr>
					    	</thead>
					    	<tbody>
							<c:forEach var="c" items="${achieveVO}">
							<tr>
								<td>${c.ach_Name}&nbsp;&nbsp;</td>
								<td>
								<img id="img" src="<%=request.getContextPath() %>/achieve/achieveShowImage.do?ach_No=${c.ach_No}">
								</td>
								<td>${c.ach_Explain}</td>
							</tr>
							</c:forEach>
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