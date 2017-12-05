<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.emp.model.*"%>
<%@ page import="com.auth.model.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

<style>
  table {
	width: 98%;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
	
  }
  table, th, td ,#bo{
    border: 1px solid #0044BB;
    text-align: center;
     font-size:20px;
  } 
</style>

</head>
<body bgcolor='white'>
<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="backdeskEmpLeft.jsp" flush="true" />
	
	<br>
<br>
<br>

<div class="container" align="center">
	<div class="row">
		<div class="col-xs-12 col-sm-12">
			<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font color='red'>請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<br>

  <jsp:useBean id="empSvc" scope="page" class="com.emp.model.EmpService" />
  <jsp:useBean id="authSvc" scope="page" class="com.auth.model.AuthService" />
 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/comp/comp.do" > 
  
   
	<table>
   		<tr>
    	<td>
	       <b>選擇員工編號:</b>
	       <select size="1" name="emp_No">
	         <c:forEach var="empVO" items="${empSvc.all}" > 
	          <option value="${empVO.emp_No}">${empVO.emp_No}
	         </c:forEach>   
	       </select>
       </td>
       <td>
       		<b>選擇給予權限:</b><br>
       		<c:forEach var="authVO" items="${authSvc.all}" > 
	          <input type="checkbox" name="auth_No" value="${authVO.auth_No}">${authVO.auth_Name}<br>
	          
	         </c:forEach>
       </td>
       </tr>
     </table>
       

<input class="btn btn-primary" type="submit" value="送出">
<input type="hidden" name="action" value="insert">
</FORM>
		</div>
	</div>
</div>



</body>
</html>