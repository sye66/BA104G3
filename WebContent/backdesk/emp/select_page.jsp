<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%request.getSession().getAttribute("EmpVO"); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BA104G3:Emp</title>

<style>
 
  ul,li{
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

<ul>
  <li><a href='<%=request.getContextPath()%>/backdesk/emp/listAllEmp.jsp'><font color="blue"><b>查詢所有</b></font></a>員工<br><br></li>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" >
        <b>輸入員工編號 (如E000001):</b>
        <input type="text" name="emp_No">
        <input class="btn btn-primary" type="submit" value="送出">
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
       <input class="btn btn-primary" type="submit" value="送出">
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
       <input class="btn btn-primary" type="submit" value="送出">
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
	</div>
</div>


</body>
</html>