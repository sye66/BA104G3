<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.proclass.model.*"%>

<%-- 萬用複合查詢-可由客戶端select_page.jsp隨意增減任何想查詢的欄位 --%>
<%-- 此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能--%>


<jsp:useBean id="proClassSvc" scope="page" class="com.proclass.model.ProClassService" />


<html>
<head><title>複合查詢 - listPro_ByCompositeQuery.jsp</title>

<style>
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 800px;
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
</style>

</head>
<body bgcolor='white'>

<h4>
☆萬用複合查詢  - 可由客戶端 select_page.jsp 隨意增減任何想查詢的欄位<br>
☆此頁只作為複合查詢時之結果練習，可視需要再增加分頁、送出修改、刪除之功能</h4>

<table>
	<tr>
		<th>商品編號</th>
		<th>商品名稱</th>
		<th>商品說明</th>
		<th>價格</th>
		<th>狀態</th>
		<th>折扣</th>
		<th>種類</th>
	</tr>
	<c:forEach var="proVO" items="${listPro_ByCompositeQuery}">
		<tr align='center' valign='middle'>
			<td>${proVO.pro_No}</td>
			<td>${proVO.pro_Name}</td>
			<td>${proVO.pro_Info}</td>
			<td>${proVO.pro_Price}</td>
			<td>${proVO.pro_Status}</td>
			<td>${proVO.pro_Discount}</td>	
			<td>
				<c:forEach var="proClassVO" items="${proClassSvc.all}">
			        <c:if test="${proVO.pro_Class_No==proClassVO.pro_Class_No}">
	                   	${proClassVO.pro_Class_Name}
                    </c:if>
                </c:forEach>
			</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>