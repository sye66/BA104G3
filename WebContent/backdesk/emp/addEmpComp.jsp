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
  table#table-1 {
    box-shadow: 0 17px 50px 0 rgba(0, 0, 0, 0.01), 0 12px 15px 0 rgba(0, 0, 0, 0.1), 0 0px 50px 0   #8A5CB8, 0 12px 15px 0   #5C5CB8;
    border-radius: 20px;
    text-align: center;
    width: 80%;
    height: 60px;
    padding-top: 30px;
    color: #4cae4c;
    margin : 20px;
    margin-left : 20px;
  }
  
  h3{
    width: 80%;
    height: 25px;  
    margin : 20px;
  }
  
  body{margin:40px;}
</style>

</head>
<body bgcolor='white'>
<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="backdeskEmpLeft.jsp" flush="true" />
	
	<div class="col-xs-12 col-sm-8 col-sm-offset-1">
		<br>
		<nav aria-label="breadcrumb" role="navigation">
  		<ol class="breadcrumb">
    		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/backdesk.jsp">首頁</a></li>
    		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/emp/select_page.jsp">員工管理</a></li>
    		<li class="breadcrumb-item active" aria-current="page">員工管理</li>
  		</ol>
	</nav>
	</div>

<table id="table-1">
   <tr><td><h3>員工授權</h3><h4>( MVC )</h4></td></tr>
</table>
<br>

<br>
<div align="center">
<h3>資料查詢:</h3>
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
       

<input type="submit" value="送出">
<input type="hidden" name="action" value="insert">
</FORM>   
   


</div>

</body>
</html>