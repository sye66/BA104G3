<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>工具人出租</title>

</head>
<body>


		
		<div id="top" class="container">
			<div class="row">
				
				<div class="col-xs-12 col-sm-9 col-sm-offset-1">


<table id="table-1">
	<tr><td><h3>工具人後台會員中心</h3></td></tr>
</table>


<h1>資料查詢 : </h1>

<%-- 錯誤處理 --%>

<c:if test="${not empty errorMsgs}">
	<font style="color:#da0">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:#00f">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul><br><br>
	<li><h1><a href='listAllMem.jsp'>List</a> 所有會員 <br><br></h1></li>
	
</ul>


<h3>會員資料單筆查詢</h3>
<br>
<ul>
	<li>
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do">
			<b>請輸入會員編號(如M000001) :</b>
			<input type="text" name="mem_No">
			<input type="hidden" name="action" value="getOne_For_Display">
			<input type="submit" value="送出">
		</FORM>
	</li>
<br>	
	<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService"/>
	
	<li>
		<FORM METHOD="post" action="<%=request.getContextPath()%>/mem/mem.do">
			<b>選擇會員編號 :</b>
			<select size="1" name="mem_No">
				<c:forEach var="memVO" items="${memSvc.all}">
					<option value="${memVO.mem_No}">${memVO.mem_No}
				</c:forEach>
			</select>
			<input type="hidden" name="action" value="getOne_For_Display">
			<input type="submit" value="送出">
		</FORM>
	</li>
<br>	
	<li>
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do">
			<b>選擇會員姓名</b>
			<select size="1" name="mem_No">
				<c:forEach var="memVO" items="${memSvc.all}">
					<option value="${memVO.mem_No}">${memVO.mem_Name}
				</c:forEach>
			</select>
			<input type="hidden" name="action" value="getOne_For_Display">
			<input type="submit" value="送出">
		</FORM>
</ul>


	</div>
			</div>
		</div>


</body>

<style>
  table#table-1 {
	width: 450px;
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
  #img{width:150px;
	heigth:200px}
</style>


<style type="text/css">
	#top{margin-top: auto;
		 margin-left: auto}
</style>

</html>