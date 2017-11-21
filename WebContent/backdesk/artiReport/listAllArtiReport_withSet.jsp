<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.artiReport.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
  ArtiReportService artiReportSvc = new ArtiReportService();
  Set<ArtiReportVO> set= (Set<ArtiReportVO>) request.getAttribute("artiReportSet");
  pageContext.setAttribute("set",set);
  
%>
<jsp:useBean id="artiReportDAO" scope="page" class="com.artiReport.model.ArtiReportDAO" />

<html>
<head>
<title>所有回覆文章資料 - listAllArtiReport.jsp</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/arti_back_style.css" />
<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
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

<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">

<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/artiForm/backdeskLeft_ArtiForm.jsp" flush="true" />

	<tr><td>
		 <h3>所有檢舉文張列表 - listAllArtiReply.jsp</h3>
		 <h4><a href="selectReport_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0"> [Article Report HOME] </a></h4>
	</td></tr>
</table>

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
    <div class="title"><h3> 所有檢舉文章列表 : </h3></div>
        <div class="widgetcontent padding0 statement">
            <table cellpadding="0" cellspacing="0" border="0" class="stdtable">

                <thead>
                    <tr>
                        <th> 檢舉編號 </th>
                        <th> 會員名稱 </th>
                        <th> 文章標題 </th>
                        <th> 檢舉時間 </th>
                        <th> 類別 </th>
                        <th> 檢舉狀態 </th>
                        <th colspan="2"> 後台管理 </th>
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
                             
                              <jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService"/>
			                  <td>${artiClassSvc.getOneClass(artiReportVO.arti_Cls_No).arti_Cls_Name }</td>
                             <td> ${artiReportVO.report_Status} </td>
                             <td>
                             <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" style="margin-bottom: 0px;">
			                 <input type="hidden" name="report_No"  value="${artiReportVO.report_No}">
			                 <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                 <input type="hidden" name="whichPage" value="<%=whichPage%>">
			                 <button class="btn btn-danger" type="submit" name="action" value="deleteReportFMBack"> 刪除檢舉 </button>
 			                 <input type="hidden" name="whichPage" value="<%=whichPage%>"> 
			                 </FORM>
			                 </td>
			                 
                             <td>
			                 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" style="margin-bottom: 0px;">
			                 <input type="hidden" name="report_No"  value="${artiReportVO.report_No}">
			                 <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                 <input type="hidden" name="whichPage" value="<%=whichPage%>">
			                 <button class="btn btn-info" type="submit" name="action" value="getOneReport_For_Display"> 查看檢舉 </button>
 			                 <input type="hidden" name="whichPage" value="<%=whichPage%>"> 
			                 </FORM>
		                     </td>
                         </tr>
                     </tbody>
                     </c:forEach>
                 </table>
             </div><!--widgetcontent-->
         </div><!--widgetbox-->
 <%@ include file="/backdesk/page2.file" %> 











<table>
	<tr>
		<th>檢舉編號</th>
		<th>會員名稱</th>
		<th>文章編號</th>
		<th>文章標題</th>
		<th>檢舉內容</th>
		<th>檢舉時間</th>
		<th>文章分類</th>
	</tr>
	
   		
		<tr>
			<td></td>
			<td></td>
			<td>${artiReportVO.arti_No}</td>
            </td>
			 
			<td>${artiReportVO.report_Desc}</td>
			<td> <fmt:formatDate value="" pattern="yyyy-MM-dd HH:mm:ss.SSS"/> </td>
			
		   
		
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="report_No"  value="${artiReportVO.report_No}">
			     <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			     <input type="hidden" name="whichPage" value="<%=whichPage%>"> 
			     <input type="hidden" name="action"	value="getOneReport_For_Update">
			     <input type="hidden" name="whichPage" value="<%=whichPage%>"> 
			     </FORM>
			     
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="report_No"  value="${artiReportVO.report_No}">
			     <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			     <input type="hidden" name="whichPage" value="<%=whichPage%>">
			     <input type="hidden" name="action" value="deleteReport">
 			     <input type="hidden" name="whichPage" value="<%=whichPage%>"> 
			     </FORM>
			</td>
		</tr>


</body>
</html>