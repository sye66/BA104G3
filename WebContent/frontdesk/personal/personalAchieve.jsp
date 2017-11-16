<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.achieve.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="java.sql.*" %>

<% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); %>
      <%request.getSession().setAttribute("memVO" ,memVO); %>
      
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
 				    			<a href="personalMissionHistory.jsp"><span class="icon icon-pencil"></span>歷史任務</a>
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
 				    			<form METHOD="post">
 				    			<a href="<%=request.getContextPath()%>/personal/personal.do"><span class="icon icon-pencil"></span>成就查詢</a>
 				    			<input type="hidden" name="action" value="personalachieve">
 				    			</form>
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
								<th>會員編號</th>
								<th>成就編號</th>
								<th>成就名稱</th>
								<th>成就圖片</th>
								<th>成就說明</th>

								
							</tr>
							<tr align='center' valign='middle'>
<%-- 								<td><%=empVO.getEmp_No()%></td> --%>
<%-- 								<td><%=empVO.getEmp_Name()%></td> --%>
<%-- 								<td><%=empVO.getEmp_Mail()%></td> --%>
<%-- 								<td><%=empVO.getEmp_Job()%></td> --%>
<%-- 								<td><%=empVO.getEmp_Phone()%></td> --%>
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