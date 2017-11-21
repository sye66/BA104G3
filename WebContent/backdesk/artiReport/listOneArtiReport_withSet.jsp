<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.artiReport.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  ArtiReportService artiReportSvc = new ArtiReportService();
  Set<ArtiReportVO> set= (Set<ArtiReportVO>) request.getAttribute("artiReportSet");
  pageContext.setAttribute("set",set);
%>

<html>
<head>
<title>文章回覆資料 - listOneArtiReply.jsp</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style>

</style>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>文章檢舉資料 - ListOneArtiReply.jsp</h3>
		 <h4><a href="selectReport_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回文章檢舉首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>檢舉編號</th>
		<th>發文會員</th>
		<th>文章編號</th>
		<th>文章標題</th>
		<th>回覆內容</th>
		<th>檢舉時間</th>
		<th>文章分類</th>
	</tr>
	
	<%@ include file="/backdesk/page1.file" %> 
	<c:forEach var="artiReportVO" items="${set}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
	+
	
	<tr>
		<td>${artiReportVO.report_No}</td>
		<td>${artiReportVO.mem_No}</td>
		<td>${artiReportVO.arti_No}</td>
		
		<jsp:useBean id="artiFormSvc" scope="page" class="com.artiForm.model.ArtiFormService" />
		<td>${artiFormSvc.getOneArtiForm(artiReportVO.arti_No).arti_Title}</td>
		
		<td>${artiReportVO.report_Desc}</td>
		<td>${artiReportVO.report_Time}</td>
		<jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService"/>
			<td>${artiClassSvc.getOneClass(artiReportVO.arti_Cls_No).arti_Cls_Name }</td>
		
		<td>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" style="margin-bottom: 0px;">
			   <input type="submit" value="修改">
			   <input type="hidden" name="report_No"  value="${artiReportVO.report_No}">
			   <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			   <input type="hidden" name="whichPage" value="<%=whichPage%>">
			   <input type="hidden" name="action" value="getOneReport_For_Update">
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
	
<!-- 	<tr> -->
<%-- 		<td><%=artiReplyVO.getReply_No()%></td> --%>
<%-- 		<td><%=artiReplyVO.getMem_No()%></td> --%>
<%-- 		<td><%=artiReplyVO.getArti_No()%></td> --%>
<%-- 		<td><%=artiReplyVO.getArti_No()%></td> --%>
<%-- 		<td><%=artiReplyVO.getReply_Desc()%></td> --%>
<%-- 		<td><%=artiReplyVO.getReply_Time()%></td> --%>
<%-- 		<td><%=artiReplyVO.getArti_Cls_No()%></td> --%>
		
<!-- 		<td> -->
<%-- 			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" style="margin-bottom: 0px;"> --%>
<!-- 			   <input type="submit" value="修改"> -->
<%-- 			   <input type="hidden" name="reply_No"  value="${artiReplyVO.reply_No}"> --%>
<%-- 			   <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"> --%>
<%-- 			   <input type="hidden" name="whichPage" value="<%=whichPage%>"> --%>
<!-- 			   <input type="hidden" name="action" value="getOneReply_For_Update"> -->
<%--  			   <input type="hidden" name="whichPage" value="<%=whichPage%>">  --%>
<!-- 			   </FORM> -->
<!-- 	    </td> -->
	    
<!-- 	    <td> -->
<%-- 			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" style="margin-bottom: 0px;"> --%>
<!-- 			   <input type="submit" value="刪除"> -->
<%-- 			   <input type="hidden" name="reply_No"  value="${artiReplyVO.reply_No}"> --%>
<%-- 			   <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"> --%>
<%-- 			   <input type="hidden" name="whichPage" value="<%=whichPage%>"> --%>
<!-- 			   <input type="hidden" name="action" value="deleteReply"> -->
<%--  			   <input type="hidden" name="whichPage" value="<%=whichPage%>">  --%>
<!-- 			   </FORM> -->
<!-- 	    </td> -->

<!-- 	</tr> -->
	</c:forEach>
</table>
 <%@ include file="/backdesk/page2.file" %> 
</body>
</html>