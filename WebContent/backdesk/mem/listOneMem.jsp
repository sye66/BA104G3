<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


  MemVO memVO = (MemVO) request.getAttribute("memVO"); //MemServlet.java(Controller), 存入req的memVO物件



<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>單一會員資料 - listOneMem.jsp</title>

<style>
  table#table-1 {
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
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
  #img{width:150px;
	heigth:200px}
</style>

</head>
<body>

	
<h4> Script 方法取值 : </h4>
<table id="table-1">
	<tr><td>
			<h3>所有會員資料 - listOneMem.jsp</h3>
			<h4><a href="<%= request.getContextPath() %>/mem/select_page.jsp"><img src="image/panda.png"
			width="60" height="80"
			border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>照片</th>
		<th>會員編號</th>
		<th>會員密碼</th>
		<th>姓名</th>
		<th>暱稱</th>
		<th>生日</th>
		<th>市話號碼</th>
		<th>手機號碼</th>
		<th>性別</th>
		<th>E-mail</th>

		<th>自我介紹</th>
		<th>會員認證號碼</th>
		<th>帳號狀態</th>
		<th>定位經度</th>
		<th>定位緯度</th>
		<th>定位IP</th>
		<th>註冊日期</th>
		<th>完成任務數量</th>
		<th>通訊地址</th>
		<th>是否能被搜尋</th>
		<th>剩餘積分</th>
	</tr>
		<tr>
			<td><img id="img" src="<%=request.getContextPath()%>/mem/memShowImage.do?mem_No=${memVO.mem_No}"></td>
			<td>${memVO.mem_No}</td>
			<td>${memVO.mem_Pw}</td>
			<td>${memVO.mem_Name}</td>
			<td>${memVO.mem_Id}</td>
			<td>${memVO.mem_Bday}</td>
			<td>${memVO.mem_Tel}</td>
			<td>${memVO.mem_Pho}</td>
			<td>${memVO.mem_Gend}</td>
			<td>${memVO.mem_Email}</td>
			
			<td>${memVO.mem_Intro}</td>
			<td>${memVO.mem_Code}</td>
			<td>${memVO.mem_State}</td>
			<td>${memVO.mem_Gps_Lat}</td>
			<td>${memVO.mem_Gps_Lng}</td>
			<td>${memVO.mem_Ip}</td>
			<td>${memVO.mem_Date}</td>
			<td>${memVO.mission_Count}</td>
			<td>${memVO.mem_Address}</td>
			<td>${memVO.mem_Search}</td>
			<td>${memVO.mem_Point}</td>
			
		</tr>
</table>


</body>
</html>