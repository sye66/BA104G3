<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.proclass.model.*"%>
<%@page import="java.util.*"%>
<html>

<head>
<title>工具人後台</title>




 
<%
	ProClassVO proClassVO = (ProClassVO) request.getAttribute("proClassVO");
	ProClassService ProClassSvc2 = new ProClassService();
	List<ProClassVO> list = ProClassSvc2.getAll();
	pageContext.setAttribute("list",list);
%>
</head>


<body>
 <jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
 <jsp:include page="/backdesk/pro/proBackLeft.jsp" flush="true" />
	
	
<div class="col-xs-12 col-sm-8 col-sm-offset-1" >
<div class="col-xs-12 col-sm-5 ">
 <br><br>
 <h2>目前的商品分類:</h2>
 <br>
 <table  >
 	
	<tr style="height:40px;">
		<th style="font-size:20px;"align="left">商品分類編號</th>
		<th width="100"></th>
		<th style="font-size:20px;"align="left">商品分類名稱</th>
	</tr>
	
	<%@ include file="page1.file" %> 
	<c:forEach var="proClassVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td style="font-size:20px;"align="left">${proClassVO.pro_Class_No}</td>
			<td width="100"></td>
			<td style="font-size:20px;"align="left">${proClassVO.pro_Class_Name}</td>
			
			
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/proClass.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="修改"> -->
<%-- 			     <input type="hidden" name="pro_Class_No"  value="${proVO.pro_Class_No}"> --%>
<!-- 			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM> -->
<!-- 			</td> -->
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/proClass.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="刪除"> -->
<%-- 			     <input type="hidden" name="pro_Class_No"  value="${proVO.pro_Class_No}"> --%>
<!-- 			     <input type="hidden" name="action" value="delete"></FORM> -->
<!-- 			</td> -->
		</tr>
	</c:forEach>
 </table>
 <hr>
 <%@ include file="page2.file" %>

</div>

<div class="col-xs-12 col-sm-5 " >
		<br><br>
		<h2>添加新的商品分類:</h2>
		<br>
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

	<form action="<%=request.getContextPath()%>/pro/proClass.do" method=post  name="form1">
		
  
			<div class="input-group input-group-lg ">
  					<span class="input-group-addon" id="sizing-addon1">商品分類名稱:</span>
  					<input name="pro_Class_Name" id="proClass" value=" " type="text" class="form-control">
			
			</div>
			<br>
			
		<input type="hidden" name="action" value="insert">
		<input type="submit" class="btn btn-success" value="送出新增" id="buy" style="height:50px;width:200px;font-size:20px;" >
		<input type="button" value="" id="xx" style="height:10px;width:10px;" >
	</form>
	
	
</div>	
</div>
<script type="text/javascript">
	$('#xx').click(function(){
		$('#proClass').val("桌遊");
	});

	</script>
</body>
</html>