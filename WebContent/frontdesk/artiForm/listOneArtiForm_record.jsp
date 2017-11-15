<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.artiForm.model.*"%>
<%@ page import="com.artiClass.model.*"%>
<%@ page import="com.artiReply.model.*"%>
<%@ page import="com.artiReport.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%-- 取出 Controller ArtiFormServlet.java已存入request的ArtiFormVO物件--%>
<%
  //ArtiFormServlet.java(Concroller), 存入req的ArtiFormVO物件
  ArtiFormVO artiFormVO = (ArtiFormVO) request.getAttribute("artiFormVO"); 
%>
<%-- 取出 對應的ArtiClassVO物件--%>
<%
  ArtiClassDAO dao = new ArtiClassDAO();
  ArtiClassVO artiClassVO = dao.findByPrimaryKey(artiFormVO.getArti_Cls_No());
%>

<html>
<head>
<title>文章資料 - listOneArtiFrom.jsp</title>

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
	width: 900px;
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

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>文章資料 - ListOneArtiFrom.jsp</h3>
		 <h4><a href="/BA104G3/frontdesk/artiForm/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>發文時間</th>
		<th>${artiFormVO.arti_Time}</th>
		<th>文章分類</th>
		<th>${artiFormVO.arti_Cls_No}</th>
		<th>文章狀態</th>
		<th>${artiFormVO.arti_Status}</th>
	</tr>
	
	<tr>
		<td>文章編號</td>
		<td>${artiFormVO.arti_No}</td>
		<td>人氣指數</td>
		<td>${artiFormVO.arti_Like}</td>
		<td>發文會員帳號</td>
		<td>${artiFormVO.mem_No}</td>
	</tr>
	
	<tr>
		<td>文章標題</td>
		<td colspan="3">${artiFormVO.arti_Title}</td>
         <jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService"/>
		<td colspan="2"><img src="<%=request.getContextPath()%>/tool/showimage.do?action=mem_Pic&mem_No=${artiFormVO.mem_No}&mem_${memSvc.getOneMem(memVO.mem_No).mem_pic}"
	                     style="height:111px;width:120px;"/></td>
	</tr>
	

	<tr>
        <td>文章附圖</td>
        <td colspan="5">文章內文</td>
    </tr>
		
    <tr>
		<td><img src="<%=request.getContextPath()%>/tool/showimage.do?action=arti_Pic&arti_No=${artiFormVO.arti_No}"
	                     style="height:111px;width:120px;"/></td>
	    <td colspan="5">${artiFormVO.describe}</td>
     </tr>
     
        <td></td>
        
        <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" >
        <td>
            <input type="submit" value="修改">
			<input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			<input type="hidden" name="action"	value="getOneArti_For_Update">
		</td>
		</FORM>
		
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" >
		<td>
			<input type="submit" value="刪除">
			<input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			<input type="hidden" name="action" value="deleteArti">
        </td>
        </FORM>
        
        <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" >
        <td>
            <input type="submit" name="arti_Like" value="讚ㄧ個!">
			<input type="hidden" name="mem_No"  value="${artiFormVO.mem_No}">
			<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
            <input type="hidden" name="action" value="giveOneLike">
		</td>
		</FORM>
		
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" >
        <td>
        <input type="hidden" name="action" value="getOneReport_For_Display">
        <input type="submit" name="report_No" value="檢舉文章">
		</td>
		</FORM>
		
		
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" >
        <td>
        <input type="hidden" name="action" value="getOneReply_For_Display">
        <input type="submit" name="reply_No" value="回覆文章">
		</td>
		</FORM>
	</tr>
</table>
	<hr>
	
<table>
		<tr>
		<th>發文時間</th>
		<th><%=artiFormVO.getArti_Time()%></th>
		<th>文章分類</th>
		<th><%=artiFormVO.getArti_Cls_No()%><%=artiClassVO.getArti_Cls_Name()%></th>
		<th>文章狀態</th>
		<th><%=artiFormVO.getArti_Status()%></th>
		
	</tr>
	
	<tr>
		<td>文章編號</td>
		<td><%=artiFormVO.getArti_No()%></td>
		<td>人氣指數</td>
		<td><%=artiFormVO.getArti_Like()%></td>
		<td>發文會員帳號</td>
		<td><%=artiFormVO.getMem_No()%></td>
	</tr>
	
	<tr>
		<td>文章標題</td>
		<td colspan="3"><%=artiFormVO.getArti_Title()%></td>

		<td colspan="2"><img src="<%=request.getContextPath()%>/tool/showimage.do?action=mem_Pic&mem_No=${artiFormVO.mem_No}&mem_${memSvc.getOneMem(memVO.mem_No).mem_pic}"
	                     style="height:111px;width:120px;"/></td>
	</tr>
	

	<tr>
        <td>文章附圖</td>
        <td colspan="5">文章內文</td>
    </tr>
		
    <tr>
		<td><img src="<%=request.getContextPath()%>/tool/showimage.do?action=arti_Pic&arti_No=${artiFormVO.arti_No}"
	                     style="height:111px;width:120px;"/></td>
	    <td colspan="5"><%=artiFormVO.getDescribe()%></td>
     </tr>
     
        <td></td>
        
        <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" >
        <td>
        <input type="hidden" name="action" value="updateArti">
        <input type="submit" name="arti_No" value="修改文章">
		</td>
		</FORM>
     
     	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" >
        <td>
        <input type="hidden" name="action" value="deleteArti">
        <input type="submit" name="arti_No" value="刪除文章">
		</td>
		</FORM>
		
     	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" >
        <td>
        <input type="hidden" name="action" value="giveOneLike">
        <input type="submit" name="arti_Like" value="讚ㄧ個!">
		</td>
		</FORM>
		
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" >
        <td>
        <input type="hidden" name="action" value="getOneReport_For_Display">
        <input type="submit" name="report_No" value="檢舉文章">
		</td>
		</FORM>
		
		
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" >
        <td>
        <input type="hidden" name="action" value="getOneReply_For_Display">
        <input type="submit" name="reply_No" value="回覆文章">
		</td>
		</FORM>
		
	</tr>
</table>
	<hr>
	<jsp:include page="/frontdesk/artiReply/listReply_ByArtiNo.jsp" flush="true" />

</body>
</html>