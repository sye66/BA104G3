<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.artiReport.model.*"%>
<%@ page import="com.emp.model.*"%>

<jsp:useBean id="artiReportSvc1" scope="session" class="com.artiReport.model.ArtiReportService" />
<%
    EmpVO empVO = (EmpVO) session.getAttribute("empVO");

    ArtiReportService artiReportSvc = new ArtiReportService();
    Set<ArtiReportVO> set = ( Set<ArtiReportVO>) artiReportSvc.findReportByStatus();
    pageContext.setAttribute("set",set);
%>

<html>
<head><title> 分類文章 - listReport_ByStatus.jsp </title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/arti_back_style.css" />

<style>
h3{
    font-size: 48px;
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
    <div class="title"><h3> 這裡是討論區檢舉文章所有待處理清單列表 : </h3></div>
        <div class="widgetcontent padding0 statement">
            <table cellpadding="0" cellspacing="0" border="0" class="stdtable">

                <thead>
                    <tr>
                        <th> 檢舉編號 </th>
                        <th> 會員名稱 </th>
                        <th> 文章標題 </th>
                        <th> 檢舉時間 </th>
                        <th> 後台處理回覆 </th>
                        <th> 檢舉狀態 </th>
                        <th > 後台管理 </th>
                    </tr>
                 </thead>
    <%@ include file="/backdesk/page1.file" %> 
	<c:forEach var="artiReportVO" items="${set}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
	
                 <tbody>
                     <tr>
                             <td> ${artiReportVO.report_No} </td>
                             <td> ${artiReportVO.mem_No} </td>
                             
                             <jsp:useBean id="artiFormSvc" scope="page" class="com.artiForm.model.ArtiFormService"/>
			                 <td>${artiFormSvc.getOneArtiForm(artiReportVO.arti_No).arti_Title }</td>
                             <td> <fmt:formatDate value="${artiReportVO.report_Time}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>

			                  <td>${artiReportVO.rep_Re_Desc}</td>
                             <td> ${artiReportVO.report_Status} </td>
                             
		                     
		                      <td>
                             <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" style="margin-bottom: 0px;">
			                 <input type="hidden" name="report_No"  value="${artiReportVO.report_No}">
			                 <input type="hidden" name="emp_No"  value="${empVO.emp_No}">
			                 <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                 <input type="hidden" name="whichPage" value="<%=whichPage%>">
			                 <button class="btn btn-info" type="submit" name="action" value="getOneReportFMback_For_Display"> 查看檢舉 </button>
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