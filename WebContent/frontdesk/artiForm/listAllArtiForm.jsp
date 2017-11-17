<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.artiForm.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
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
  
  .widget-main padding-16{
  word-wrap:break-word;
  word-break:normal;
}
  
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body bgcolor='white'>

<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true" />

<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>所有文張列表 - listAllArtiForm.jsp</h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0"> [HOME] </a></h4>
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

<table>
	<tr>
		<th>文章編號</th>
		<th>會員名稱</th>
		<th>文章標題</th>
		<th>文章人氣</th>
		<th>文章內容</th>
		<th>發文時間</th>
		<th>文章附圖</th>
		<th>文章類別</th>
		<th>文章狀態</th>
	</tr>
 	<%@ include file="/frontdesk/page1.file" %> 
	<c:forEach var="artiFormVO" items="${set}" varStatus="s" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" >
		
		<tr>
		    <td>
		    
		    <a href="javascript:presses${s.index}()">${artiFormVO.arti_No}</a></td>
 <!-- 			<td>${artiFormVO.arti_No}</td> --> 
			<td>${artiFormVO.mem_No}</td>

			<td>${artiFormVO.arti_Title}</td>
			
			<td>${artiFormVO.arti_Like}</td>
			<td>${artiFormVO.describe}</td>
			<td> <fmt:formatDate value="${artiFormVO.arti_Time}" pattern="yyyy-MM-dd HH:mm:ss.SSS"/> </td>
			<td><img src="<%=request.getContextPath()%>/tool/showimage.do?action=arti_Pic&arti_No=${artiFormVO.arti_No}"
	                     style="height:111px;width:120px;"/></td>
 <!--  			<td>${artiFormVO.arti_Pic}</td> --> 
 <!-- 			<td>${artiFormVO.arti_Cls_No}</td>  --> 
            <jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService"/>
			<td>${artiClassSvc.getOneClass(artiFormVO.arti_Cls_No).arti_Cls_Name}</td>
			
			<td>${artiFormVO.arti_Status}</td> 
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			     <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			     <input type="hidden" name="whichPage" value="<%=whichPage%>"> 
			     <input type="hidden" name="action"	value="getOneArti_For_Update">
			     <input type="hidden" name="whichPage" value="<%=whichPage%>"> 
			     </FORM>
			     
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			     <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			     <input type="hidden" name="whichPage" value="<%=whichPage%>">
			     <input type="hidden" name="action" value="deleteArti">
 			     <input type="hidden" name="whichPage" value="<%=whichPage%>"> 
			     </FORM>
			</td>
		</tr>
		
	    <script>
         function presses${s.index}(){
        	 console.log('${artiFormVO.arti_No}');
        	 document.open("/BA104G3/artiForm/artiForm.do?arti_No=${artiFormVO.arti_No}&arti_Cls_No=${artiFormVO.arti_Cls_No}&action=jumpOne_For_Display", "" ,"height=250,width=850,left=65,top=157,resizable=yes,scrollbars=yes");
         }
        </script>
        
    </c:forEach>
</table>
 <%@ include file="/backdesk/page2.file" %> 

</body>

 <jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />
</html>