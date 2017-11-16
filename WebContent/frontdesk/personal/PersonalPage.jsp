<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mem.model.*"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">


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
					    Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
					    tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
					    quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
					    consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
					    cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
					    proident, sunt in culpa qui officia deserunt mollit anim id est laborum.	
					  </div>
				</div>
 			</div>
		</div>
	</div>

</body>
</html>