<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.artiForm.model.*"%>
<%@ page import="com.emp.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    EmpVO empVO = (EmpVO) session.getAttribute("empVO");
    String emp_No = empVO.getEmp_No();
    session.setAttribute("emp_No", emp_No);

    ArtiFormService artiSvc = new ArtiFormService();
    Set<ArtiFormVO> set = artiSvc.getAll();
    pageContext.setAttribute("set",set);    
%>

<jsp:useBean id="artiFormDAO" scope="page" class="com.artiForm.model.ArtiFormDAO" />

<html>
<head>
<title>所有文章資料 - listAllArtiForm.jsp</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/arti_back_style.css" />
<style>

  body{margin:40px;}
  
  a{
   font-size: 24px;
   color: #F00;
  }

</style>

</head>
<body bgcolor='white'>

<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/artiForm/backdeskLeft_ArtiForm.jsp" flush="true" />


<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

 	

<div class="widgetbox">

        <div class="title">
        <h3> 這裡是討論區文章資料查詢 -- LIST ALL :   //      <a href="/BA104G3/frontdesk/artiForm/addArtiForm.jsp">Add</a> a new Article.</h3><br/>
        </div>

        <div class="widgetcontent padding0 statement">
            <table cellpadding="0" cellspacing="0" border="0" class="stdtable">

                <thead>
                    <tr>
                        <th> 文章編號 </th>
                        <th> 會員名稱 </th>
                        <th> 人氣 </th>
                        <th> 文章標題 </th>
                        <th> 發文時間 </th>
                        <th> 類別 </th>
                        <th> 狀態 </th>
                        <th colspan="2"> 後台管理 </th>
                    </tr>
                 </thead>
                 <%@ include file="/backdesk/page1.file" %> 
	             <c:forEach var="artiFormVO" items="${set}" varStatus="s" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" >
	
                 <tbody>
                     <tr>
                         <td>${artiFormVO.arti_No} </td>
                             <td> ${artiFormVO.mem_No} </td>
                             <td> ${artiFormVO.arti_Like} </td>
                             <td> ${artiFormVO.arti_Title} </td>
                             <td> <fmt:formatDate value="${artiFormVO.arti_Time}" pattern="yyyy-MM-dd HH:mm:ss.SSS"/> </td>
                             <td> ${artiClassSvc.getOneClass(artiFormVO.arti_Cls_No).arti_Cls_Name} </td>
                             <td> ${artiFormVO.arti_Status} </td>
                             
                             <td>
                             <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" style="margin-bottom: 0px;">
			                 <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			                 <input type="hidden" name="emp_No"  value="${empVO.emp_No}">
			                 <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                 <input type="hidden" name="whichPage" value="<%=whichPage%>">
			                 <button class="btn btn-danger" type="submit" name="action" value="deleteArtiFMBack"> 刪除文章 </button>
 			                 <input type="hidden" name="whichPage" value="<%=whichPage%>"> 
			                 </FORM>
			                 </td>
			                 
                             <td>
			                 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" style="margin-bottom: 0px;">
			                 <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			                 <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                 <input type="hidden" name="whichPage" value="<%=whichPage%>">
			                 <button class="btn btn-info" type="submit" name="action" value="getOneArti_For_Back"> 查看文章 </button>
 			                 <input type="hidden" name="whichPage" value="<%=whichPage%>"> 
			                 </FORM>
		                     </td>
                         </tr>
                     </tbody>
                     </c:forEach>
                 </table>
             </div><!--widgetcontent-->
         </div><!--widgetbox-->
         <hr>
         <br>
         
 <%@ include file="/backdesk/page2.file" %> 

</body>
</html>