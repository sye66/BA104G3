<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="com.mem.model.*"%>
 <%@ page import="java.util.*"%>
 <%@ page import="com.getmission.model.*"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <% 
 	MemVO memVO = (MemVO) session.getAttribute("memVO");
 	String mem_No = memVO.getMem_No();
 	GetMissionService gmSvc = new GetMissionService();
 	List<GetMissionVO> list = gmSvc.findIssuerCase(mem_No);
 	pageContext.setAttribute("list",list);
 	List<GetMissionVO> list1 = gmSvc.successGetMission(mem_No);
 	pageContext.setAttribute("list1",list1);
 %>
 
<%--  <%request.getSession().setAttribute("memVO" ,memVO); %> --%>
 <jsp:useBean id="getMissionSvc" scope="page" class="com.getmission.model.GetMissionService" />
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
 				    <h3 class="panel-title">個人版面</h3>
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
 				<div class="panel panel-default">
					  <div class="panel-heading">
					    <h3 class="panel-title">發案</h3>
					  </div>
					  <div class="panel-body">
					    <table>
					    		<c:forEach var="getMissionVO" items="${list}">
					    		<tr>
					    			<td>幫幫我!!  :${getMissionVO.mission_Name}<td>
					    			<td><div class="panel-body">
										<form method="post"
											action="<%=request.getContextPath()%>/getmission/getmission.do"
											name="getmission1">
											<button class="btn btn-warning" type="submit" name="action"
												value="mission_Detail">任務細節</button>

											<input type="hidden" name="mission_No"
												value="${getMissionVO.mission_No}"> <input
												type="hidden" name="requestURL"
												value="/frontdesk/getmission/getMission.jsp">
										</form>
									</div></td>
					    		</tr>
					    		</c:forEach>	
					    </table>	
					  </div>
				</div>
				<div class="panel panel-default">
					  <div class="panel-heading">
					    <h3 class="panel-title">接案</h3>
					  </div>
					  <div class="panel-body">
					    <table>
					    		<c:forEach var="getMissionVO1" items="${list1}">
					    		<tr>
					    			<td>我接的案喔!!  :${getMissionVO1.mission_Name}<td>
					    			<td><div class="panel-body">
										<form method="post"
											action="<%=request.getContextPath()%>/getmission/getmission.do"
											name="getmission1">
											<button class="btn btn-warning" type="submit" name="action"
												value="mission_Detail">任務細節</button>
												
												<input type="hidden" name="mission_No"
												value="${getMissionVO1.mission_No}"> <input
												type="hidden" name="requestURL"
												value="/frontdesk/getmission/getMission.jsp">
										</form>
									</div></td>
					    		</tr>
					    		</c:forEach>	
					    </table>	
					  </div>
				</div>
 			</div>
		</div>
	</div>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	
	<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />

</body>
</html>