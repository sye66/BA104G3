<%@page import="java.util.*"%>
<%@page import="com.pro.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    

<%
    ProService proSvc = new ProService();
    List<ProVO> list = proSvc.getAll();
    pageContext.setAttribute("list",list);
%>
<jsp:useBean id="proClassSvc" scope="page" class="com.proclass.model.ProClassService" />
<jsp:useBean id="proSvc2" scope="page" class="com.pro.model.ProService" />

<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商品</title>


</head>
<body>
 	
    <jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/pro/proBackLeft.jsp" flush="true" />
	
<!-- 	<div class="col-xs-12 col-sm-8 col-sm-offset-1"> -->
<!-- 		<br> -->
<!-- 		<nav aria-label="breadcrumb" role="navigation"> -->
<!--   		<ol class="breadcrumb"> -->
<%--     		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/backdesk.jsp">首頁</a></li> --%>
<%--     		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/pro/proBackIndex.jsp">商城管理</a></li> --%>
<!--     		<li class="breadcrumb-item active" aria-current="page">商品查詢</li> -->
<!--   		</ol> -->
<!-- 		</nav> -->
<!-- 	</div> -->


<div class="col-xs-12 col-sm-9">
	<br>
	
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

	
		<ul>
		<br>
			<table>
				<tr>
					<th style="text-align:left;height:30px;">輸入商品編號 (如P000001):</th>
					<th style="text-align:left;height:30px;">選擇商品編號:</th>
					<th style="text-align:left;height:30px;">選擇商品名稱:</th>
				</tr>
				<tr>
				<td style="text-align:left;">
				<FORM METHOD="post" style="width:250px;height:30px;"
					ACTION="<%=request.getContextPath()%>/pro/pro.do">
					<input type="text" name="pro_No">
					<input type="submit" value="送出"> <input type="hidden"
						name="action" value="getOne_For_Display">
				</FORM>
				</td>

			

				<td style="text-align:left;">
				<FORM METHOD="post" style="width:300px;height:30px;"
					ACTION="<%=request.getContextPath()%>/pro/pro.do">
					 <select size="1" name="pro_No">
					
						<c:forEach var="proVO" items="${proSvc2.all}">
							<option value="${proVO.pro_No}">${proVO.pro_No}
						</c:forEach>
					</select> <input type="submit" value="送出"> <input type="hidden"
						name="action" value="getOne_For_Display">
				</FORM>
				</td>

				<td style="text-align:left;">
				<FORM METHOD="post" style="width:350px;height:30px;"
					ACTION="<%=request.getContextPath()%>/pro/pro.do">
					<select size="1" name="pro_No">
						<c:forEach var="proVO" items="${proSvc2.all}">
							<option value="${proVO.pro_No}">${proVO.pro_Name}
						</c:forEach>
					</select> <input type="submit" value="送出"> <input type="hidden"
						name="action" value="getOne_For_Display">
				</FORM>
				</td>
			</tr>
		</table>


		
	</div>




	<div class="col-xs-12 col-sm-9 ">
	<br>
	<table id="tavle01" >
	<tr>
		<th>商品照片</th>
		<th style="width:100px;">商品編號</th>
		<th style="width:100px;">商品名稱</th>
		<th style="width:100px;">商品價格</th>
		<th style="width:100px;">商品說明</th>
		<th style="width:100px;">商品分類</th>
		<th style="width:100px;">商品狀態</th>
		<th style="width:100px;">商品折扣</th>
		<th style="width:100px;">商品折扣開始日期</th>
		<th style="width:100px;">商品折扣結束日期</th>
		<th colspan="2">商品異動</th>
	</tr>
	<h4><%@ include file="page1.file" %></h4> 
	
	<c:forEach var="proVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td><img width="100" height="100" 
			src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}" /></td>
			<td>${proVO.pro_No}</td>
			<td>${proVO.pro_Name}</td>
			<td>${proVO.pro_Price}</td>
			<td>${proVO.pro_Info}</td>
			
			<td>
				<c:forEach var="proClassVO" items="${proClassSvc.all}">
			        <c:if test="${proVO.pro_Class_No==proClassVO.pro_Class_No}">
	                   	${proClassVO.pro_Class_Name}
                    </c:if>
                </c:forEach>
			</td>
			
			<td>${proVO.pro_Status}</td>
			<td>${proVO.pro_Discount}</td>
			<td>${proVO.pro_Dis_StartDate}</td>
			<td>${proVO.pro_Dis_EndDate}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" style="margin-bottom: 0px;">
			     <button type="submit" class="btn btn-warning">修改</button>
			     <input type="hidden" name="pro_No"  value="${proVO.pro_No}">
			     <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
				 <input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  
			     <input type="hidden" name="action"	value="getOne_For_Update">
			    </FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" style="margin-bottom: 0px;">
			     <button type="submit" class="btn btn-danger">刪除</button>
			     <input type="hidden" name="pro_No"  value="${proVO.pro_No}">
			      <input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">
			     <input type="hidden" name="action" value="delete">
			   </FORM>
			</td>
		</tr>
	</c:forEach>
	
</table>

<h4><%@include file="page2.file" %></h4>

</div>

</body>
</html>