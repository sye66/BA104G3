<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="com.mem.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="MemSvc" scope="session" class="com.mem.model.MemService"/>

<%
	MemService memSvc = new MemService();
	request.getSession().getAttribute("memVO");
	request.getAttribute("memVO");
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
  table, th, td,tr ,#bo{
   border: 1px solid #0044BB;
       text-align: center;
     font-size:20px;
  }
  th, td {
    padding: 5px;
    text-align: center;
    height:200px;
  }
  #img{width:150px;
	heigth:150px}
	#hh {
	 height:100px}
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
			<h4><a href="<%=request.getContextPath()%>/backdesk/mem/backdeskMemIndex.jsp""><img src="<%=request.getContextPath()%>/lib/publicfile/include/img/logo/logo.png"
			width="60" height="80"
			border="0"><br>回首頁</a></h4>
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
		<th id="bo">照片</th>
		<th id="bo">會員編號</th>
		<th id="bo" style="width:10%">姓名</th>
		<th id="bo" style="width:10%">暱稱</th>
		<th id="bo">生日</th>
		<th id="bo" style="width:5%">性別</th>
		<th id="bo">E-mail</th>

		<th id="bo">自我介紹</th>
		<th id="bo">帳號狀態</th>
		<th id="bo">完成任務數量</th>
		<th id="bo">是否能被搜尋</th>
		<th id="bo">剩餘積分</th>
		
	</tr>
	<%@ include file="page1.file" %>
	<c:forEach var="memVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">


		<tr>
			<td><a href="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${memVO.mem_No}"><img id="img" src="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${memVO.mem_No}"></a></td>		
			<td>${memVO.mem_No}</td>
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
			<td>${memVO.mem_Intro}</td>
			
			<c:if test="${memVO.mem_State==0}">
			<td>尚未驗證</td>
			</c:if>
			<c:if test="${memVO.mem_State==1}">
			<td>一般會員</td>
			</c:if>
			<c:if test="${memVO.mem_State==9}">
			<td>停權</td>
			</c:if>
			
			<td>${memVO.mission_Count}</td>
			
			<c:if test="${memVO.mem_Search==0}">
			<td>否</td>
			</c:if>
			<c:if test="${memVO.mem_Search==1}">
			<td>可</td>
			</c:if>
			
			<td>${memVO.mem_Point}</td>
			
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

<%@ include file="page2.file" %>
</div>
</div>
</div>




</body>
</html>