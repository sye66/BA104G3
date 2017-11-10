<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.pro.model.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>工具人</title>
</head>
<body>
	
	
	
	<div class="col-xs-12 col-sm-1"></div>
	<div class="col-xs-12 col-sm-6">
	<br><br>
		<h3>資料查詢:</h3>
		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
			<font color='red'>請修正以下錯誤:
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li>${message}</li>
					</c:forEach>
				</ul>
			</font>
		</c:if>
	<br><br>
		<ul>
			<li><a href='listAllPro.jsp'>查詢全部商品</a></li>
			<li>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/pro/pro.do">
					<b>輸入商品編號 (如P000001):</b> <input type="text" name="pro_No">
					<input type="submit" value="送出"> <input type="hidden"
						name="action" value="getOne_For_Display">
				</FORM>
			</li>

			<jsp:useBean id="proSvc" scope="page" class="com.pro.model.ProService" />

			<li>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/pro/pro.do">
					<b>選擇商品編號:</b> <select size="1" name="pro_No">
						<c:forEach var="proVO" items="${proSvc.all}">
							<option value="${proVO.pro_No}">${proVO.pro_No}
						</c:forEach>
					</select> <input type="submit" value="送出"> <input type="hidden"
						name="action" value="getOne_For_Display">
				</FORM>
			</li>

			<li>
				<FORM METHOD="post"
					ACTION="<%=request.getContextPath()%>/pro/pro.do">
					<b>選擇商品名稱:</b> <select size="1" name="pro_No">
						<c:forEach var="proVO" items="${proSvc.all}">
							<option value="${proVO.pro_No}">${proVO.pro_Name}
						</c:forEach>
					</select> <input type="submit" value="送出"> <input type="hidden"
						name="action" value="getOne_For_Display">
				</FORM>
			</li>
		</ul>



		<ul>
			<li><a href='addPro.jsp'>新增商品</a></li>
		</ul>
	</div>

</body>
</html>