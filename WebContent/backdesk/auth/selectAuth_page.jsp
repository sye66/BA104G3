<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

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
	</style>
	
</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3> Auth: Home</h3><h4>( MVC )</h4></td></tr>
</table>

<p>This is the Home page for Auth: Home</p>



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

<ul>
  <li><a href='<%=request.getContextPath()%>/backdesk/auth/listAllAuth.jsp'>List</a> all Auths. <br><br></li>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/auth/auth.do" >
        <b>輸入權限編號 (如AU000001):</b>
        <input type="text" name="auth_No">
        <input type="submit" value="送出">
        <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>

  <jsp:useBean id="authSvc" scope="page" class="com.emp.model.EmpService" />
   

    <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/auth/auth.do" >
       <b>選擇權限編號:</b>
       <select size="1" name="auth_No">
         <c:forEach var="authVO" items="${authSvc.all}" > 
          <option value="${authVO.auth_No}">${authVO.auth_No}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>
  
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/auth/auth.do" >
       <b>選擇權限姓名:</b>
       <select size="1" name="auth_No">
         <c:forEach var="authVO" items="${authSvc.all}" > 
          <option value="${authVO.auth_No}">${authVO.auth_Name}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="getOne_For_Display">
     </FORM>
  </li>
  
   
</ul>


<h3>權限管理</h3>

<ul>
  <li><a href='<%=request.getContextPath()%>/backdesk/auth/addAuth.jsp'>Add</a> a new Emp.</li>
</ul>


</body>
</html>