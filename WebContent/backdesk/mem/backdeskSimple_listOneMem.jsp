<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="MemSvc" scope="page" class="com.mem.model.MemService"/>
<%  MemVO memVO = (MemVO) request.getAttribute("memVO");  %>
<%   memVO = (MemVO) request.getSession().getAttribute("memVO");%>
<!-- MemServlet.java(Controller), 存入req的memVO物件 -->



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>工具人出租</title>

<style>
  table#table-1 {
  margin-top: 10%;
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
	width: 98%;
	background-color: white;
	    font-size:20px;
	margin-bottom: 5px;
  }
  table, th, td ,#bo{
    border: 1px solid #0044BB;
  }
  th, td {
    padding: 5px;
    font-size:20px;
    text-align: center;
  }
  #img{width:150px;
	heigth:200px}
	
</style>

</head>
<body>
	<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/mem/backdeskMemLeft.jsp" flush="true" />
	
	
	<div id="top" class="container-fluid">
			<div class="row">
				
				<div class="col-xs-12 col-sm-8 col-sm-offset-1" >
	
<table id="table-1">
	<tr><td>
			<h3>所有會員資料</h3>
			<h4><a href="<%=request.getContextPath()%>/backdesk/mem/backdeskMemIndex.jsp"><img src="<%=request.getContextPath()%>/lib/publicfile/include/img/logo/logo.png"
			width="60" height="80"
			border="0"><br>回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th id="bo">照片</th>
		<th id="bo">會員編號</th>
		<th id="bo" style="width:10%">姓名</th>
		<th id="bo">暱稱</th>
		<th id="bo">生日</th>
		<th id="bo">性別</th>
		<th id="bo">E-mail</th>
		<th id="bo">詳細</th>

	</tr>
		<tr>
			<td><img id="img" src="<%=request.getContextPath()%>/mem/memShowImage.do?mem_No=${memVO.mem_No}"></td>
			<td>${MemSvc.getOneMem(memVO.mem_No).mem_No}</td>
			<td>${memVO.mem_Name}</td>
			<td>${memVO.mem_Id}</td>
			<td>${memVO.mem_Bday}</td>
			<c:if test="${memVO.mem_Gend==1}">
			<td>男</td>
			</c:if>
			<c:if test="${memVO.mem_Gend==2}">
			<td>女</td>
			</c:if>
			<c:if test="${memVO.mem_Gend==3}">
			<td>不想說</td>
			</c:if>
			<td>${memVO.mem_Email}</td>
			<td><a href="<%=request.getContextPath()%>/backdesk/mem/listOneMem.jsp">
				<input value="詳細" type="submit" class="btn btn-success btn-block btn-lg" tabindex="7"></a></td>
			
		</tr>
</table>
</div>
</div>
</div>

</body>
</html>