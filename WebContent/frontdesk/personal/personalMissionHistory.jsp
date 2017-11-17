<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="com.mem.model.*"%>
 <%@ page import="com.getmission.model.*"%>
 <% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); %>
 <%request.getSession().setAttribute("memVO" ,memVO); %>
 <jsp:useBean id="getMissionSvc" scope="page" class="com.getmission.model.GetMissionService" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	
	
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
 				    			<a href="<%=request.getContextPath()%>/personal/personal.do" name="action" value="personalMissionHistory"><span class="icon icon-pencil"></span>歷史任務</a>
 				    		</td>
 				    	</tr>
 				    	<tr>
 				    		<td>
 				    			<a href="#"><span class="icon icon-pencil"></span>技能修改</a>
 				    		</td>
 				    	</tr>
 				    	<tr>
 				    		<td>
 				    			<a href="#"><span class="icon icon-pencil"></span>更換頭像</a>
 				    		</td>
 				    	</tr>
 				    	<tr>
 				    		<td>
 				    			<a href="<%=request.getContextPath()%>/personal/personal.do" name="action" value="personalAchieve"><span class="icon icon-pencil"></span>成就查詢</a>
 				    		</td>
 				    	</tr>
 				    </table>				
 				  </div>
 				</div>
 			</div>
 			<div class="col-xs-12 col-sm-8">
 				<div class="panel panel-default">
					  <div class="panel-heading">
					    <h3 class="panel-title">標題</h3>
					  </div>
					  <div class="panel-body">
					    <table>
					    	<tr>
					    		<td>
					    		<c:forEach var="getMissionVO" items="${getMissionSvc.all}">
					    			<c:if test="${memVO.mem_No==getMissionVO.issuer_Mem_No}">
					    				${getMissionVO.issuer_Mem_No}
					    			</c:if>
					    		</c:forEach>	
					    		</td>
					    	</tr>
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
	
	<footer>
		<div class="cli-xs-12 col-sm-12 footer">
		
		</div>
	</footer>

</body>
</html>