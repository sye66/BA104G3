<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.achieve.model.*"%>
<%@ page import="java.sql.*" %>

<%
  AchieveVO achieveVO = (AchieveVO) request.getAttribute("achieveVO");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>成就資料新增 - addAchieve.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/selectAchieve_page.jsp"><img src="images/pot.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/achieve/achieve.do" name="form1" enctype="multipart/form-data">
<table>
	
	<tr>
		<td>成就名稱:</td>
		<td><input type="TEXT" name="ach_Name" size="45"
			 value="<%= (achieveVO==null)? "ABDFABH" : achieveVO.getAch_Name()%>" /></td>
	</tr>
	<tr>
		<td>成就圖片:</td>
		<img id="theImage" src="<%=request.getContextPath()%>/achieve/achieve.do?ach_No=${achieveVO.ach_No} "
                      style="height:111px;width:120px;"/>
		<td>
		<input type="file" name="ach_Picture" size="45" id="getPicture" onchange="onLoadBinaryFile()" 
    		value="<%= (achieveVO==null)? "吳永志" : achieveVO.getAch_Picture()%>" />	
	</tr>
	<tr>
		<td>成就說明:</td>
		<td><input type="TEXT" name="ach_Explain" size="45"
			 value="<%= (achieveVO==null)? "manager" : achieveVO.getAch_Explain()%>" /></td>
	</tr>
	
</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>
</body>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/build/jquery.datetimepicker.full.min.js"></script>
<script type="text/javascript">
        function onLoadBinaryFile() {
            var theFile = document.getElementById("getPicture");

            // 確定選取了一個二進位檔案，而非其他格式。
            if (theFile.files.length != 0 && theFile.files[0].type.match(/image.*/)) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    var theImg = document.getElementById("theImage");
                    theImg.src = e.target.result;
                };
                reader.onerror = function (e) {
                    alert("例外狀況，無法讀取二進位檔");
                };

                // 讀取二進位檔案。
                reader.readAsDataURL(theFile.files[0]);
            }
            else {
                alert("請選取一個二進位檔");
            }
        }
    </script>


</html>