<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="com.mem.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="MemSvc" scope="page" class="com.mem.model.MemService"/>

<%
	MemService memSvc = new MemService();
	List<MemVO> list = memSvc.getAll();
	pageContext.setAttribute("list" , list);
%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>所有會員資料 - listAllMem.jsp</title>

<style>
  table#table-1 {
	width: 98%;
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
  table {
	width: 98%;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
	
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
    height:200px;
  }
  #img{width:150px;
	heigth:150px}
</style>

</head>
<body>
<%-- 	<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" /> --%>
	<jsp:include page="/backdesk/mem/backdeskMemLeft.jsp" flush="true" />
	
	
	<div id="top" class="container-fluid">
			<div class="row">
				
				<div class="col-xs-12 col-sm-8 col-sm-offset-1" >

<table id="table-1">
	<tr><td>
			<h3>所有會員資料 - listAllMem.jsp</h3>
			<h4><a href="<%=request.getContextPath()%>/backdesk/mem/backdeskMemIndex.jsp""><img src="image/panda.png"
			width="60" height="80"
			border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤處理 --%>

<c:if test="${not empty errorMsgs}">
	<font style="color:#da0">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:#00f">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>照片</th>
		<th>會員編號</th>
		<th>姓名</th>
		<th>暱稱</th>
		<th>生日</th>
		<th>性別</th>
		<th>E-mail</th>

		<th>自我介紹</th>
		<th>帳號狀態</th>
		<th>完成任務數量</th>
		<th>是否能被搜尋</th>
		<th>剩餘積分</th>
		<th>資料修改</th>
		
	</tr>
	<%@ include file="page1.file" %>
	<c:forEach var="memVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">


		<tr>
			<td><a href="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${memVO.mem_No}"><img id="img" src="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${memVO.mem_No}"></a></td>		
			<td>${memVO.mem_No}</td>
			<td>${memVO.mem_Name}</td>
			<td>${memVO.mem_Id}</td>
			<td>${memVO.mem_Bday}</td>
			<td>${memVO.mem_Gend}</td>
			<td>${memVO.mem_Email}</td>

			<td>${memVO.mem_Intro}</td>
			<td>${memVO.mem_State}</td>
			<td>${memVO.mission_Count}</td>
			<td>${memVO.mem_Address}</td>
			<td>${memVO.mem_Search}</td>
			<td>${memVO.mem_Point}</td>
			
			<td>
				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" style="margin-bottom: 0px;">
					<input type="submit" value="修改">
					<input type="hidden" name="mem_No" value="${memVO.mem_No}">
					<input type="hidden" name="action" value="getOne_For_Update" class="btn btn-success btn-block btn-lg">
				</FORM>
			</td>
<!-- 			<td> -->
<%-- 				<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" style="margin-bottom: 0px;"> --%>
<!-- 					<input type="submit" value="刪除"> -->
<%-- 					<input type="hidden" name="mem_No" value="${memVO.mem_No}"> --%>
<!-- 					<input type="hidden" name="action" value="delete"> -->
<!-- 				</FORM> -->
<!-- 			</td> -->
		</tr>
	</c:forEach>
</table>
</div>
</div>
</div>
<%@ include file="page2.file" %>





</body>
</html>