<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%request.getSession().getAttribute("EmpVO"); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BA104G3:Emp</title>
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/arti_back_style.css" />

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
    		
    		<li class="breadcrumb-item active" aria-current="page">員工管理</li>
  		</ol>
	</nav>
	</div>

<table id="table-1">
   <tr><td><h3>IBM Emp: Home</h3><h4>( MVC )</h4></td></tr>
</table>
<br>

<br>
<div >
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

<ul>
  <li><a href='<%=request.getContextPath()%>/backdesk/emp/listAllEmp.jsp'><font color="blue"><b>查詢所有</b></font></a>員工<br><br></li>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" >
        <b>輸入員工編號 (如E000001):</b>
        <input type="text" name="emp_No">
        <input type="submit" value="送出">
        <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>
<br>
  <jsp:useBean id="empSvc" scope="page" class="com.emp.model.EmpService" />
   

    <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" >
       <b>選擇員工編號:</b>
       <select size="1" name="emp_No">
         <c:forEach var="empVO" items="${empSvc.all}" > 
          <option value="${empVO.emp_No}">${empVO.emp_No}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
  </li>
  <br>
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" >
       <b>選擇員工姓名:</b>
       <select size="1" name="emp_No">
         <c:forEach var="empVO" items="${empSvc.all}" > 
          <option value="${empVO.emp_No}">${empVO.emp_Name}
         </c:forEach>   
       </select>
       <input type="submit" value="送出">
       <input type="hidden" name="action" value="getOne_For_Display">
     </FORM>
  </li>
  <br>
   
</ul>


<h3>員工管理</h3>
<br>
<ul>
  <li><a href='<%=request.getContextPath()%>/backdesk/emp/addEmp.jsp'><font color="blue"><b>新增</b></font></a>一位員工</li>
</ul>
</div>

</body>
</html>