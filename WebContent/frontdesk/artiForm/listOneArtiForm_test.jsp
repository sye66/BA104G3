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
<title>文章資料 - listOneArtiFrom_Test.jsp</title>
<link href="lib/css/arti_ref/bootstrap.min.css" rel="stylesheet" type="text/css"/>
<link href="lib/css/arti_ref/bootstrap-responsive.min.css" rel="stylesheet" type="text/css"/>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml">
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
  
  body{margin:40px;}
  
  .btn-circle {
  width: auto;
  height: 30px;
  text-align: center;
  padding: 6px 0;
  font-size: 12px;
  line-height: 1.428571429;
  border-radius: 15px;
  margin : 30 px;
}

.btn-circle.btn-lg {
  width: auto;
  height: 50px;
  padding: 10px 16px;
  font-size: 18px;
  line-height: 1.33;
  border-radius: 25px;
  margin : 30 px;
}

.btn-circle.btn-xl {
  width: autox;
  height: 70px;
  padding: 10px 16px;
  font-size: 24px;
  line-height: 1.33;
  border-radius: 200px;
  margin : 30 px;
}
button{
  float: left;
  margin : 30 px;
}
  
</style>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>文章資料 - ListOneArtiFrom_test.jsp</h3>
		 <h4><a href="/BA104G3/frontdesk/artiForm/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>
<hr>

<h3 class="page-title">
    Blog Post <small>blog post samples</small>
    </h3>
        <ul class="breadcrumb">
            <li>
            <i class="icon-home"></i>
                <a href="index.html">Home</a> 
                <i class="icon-angle-right"></i>
            </li>
            <li>
                <a href="#">Pages</a>
                <i class="icon-angle-right"></i>
            </li>
            <li><a href="#">Blog Post</a></li>
        </ul>
        
	    <h1>${artiFormVO.arti_Title}</h1>
	    
<table>
    <tr>
        <th colspan="3">主題文章附圖 : </th>
        <th>發文時間</th>
		<th>${artiFormVO.arti_Time}</th>
    </tr>
    <tr>
        <td colspan="3" rowspan="4">
        <img src="<%=request.getContextPath()%>/tool/showimage.do?action=arti_Pic&arti_No=${artiFormVO.arti_No}"
	                     style="height:500px;width:600px;"/></td>
        <td>推文數</td>
		<td>${artiFormVO.arti_Like}</td>
    </tr>
    <tr>
        <td>文章狀態</td>
		<td>${artiFormVO.arti_Status}</td>
    </tr>
    <tr>
		<td colspan="2"><img src="<%=request.getContextPath()%>/tool/showimage.do?action=mem_Pic&mem_No=${artiFormVO.mem_No}&mem_${memSvc.getOneMem(memVO.mem_No).mem_pic}"
	                     style="height:250px;width:300px;"/></td>
    </tr>
        <td>樓主</td>
		<td>${artiFormVO.mem_No}</td>
    </tr>
    
    </tr>
        <td colspan="6"> 詳細內文 : </td>
    </tr>
    </tr>
		<td colspan="6">${artiFormVO.describe}</td>
    </tr>

  
  <!--  -->  <button type="button" class="btn btn-primary btn-circle" name="reply_No" value=""><i class="glyphicon glyphicon-list" ></i> 修改文章 </button>
-->
    <tr>
    <td>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" >
			<input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
            <button class="btn btn-success" type="submit" name="action" value="getOneArti_For_Update">修改文章</button>
		</FORM>
		
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" >
			<input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			<button class="btn btn-danger" type="submit" name="action" value="deleteArti">刪除文章</button>
        </FORM>
        
        <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" >
			<input type="hidden" name="mem_No"  value="${artiFormVO.mem_No}">
			<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
            <button class="btn btn-link" type="submit" name="action" value="giveOneLike">讚ㄧ個! </button>
		</FORM>
		
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" >
		<input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
        <button class="btn btn-warning" type="submit" name="action" value="insertReport"> 檢舉文章</button>
		</FORM>
		
		
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" >
		<input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
		<input type="hidden" name="arti_No"  value="${artiFormVO.mem_No}">
        <button class="btn btn-primary" type="submit" name="action" value="insertReply"> 回覆文章</button>
        <button class="btn btn-info" type="submit" name="action" value="listReply_ByArtiNo"> 查看回覆</button>
		</td>
		</FORM>
	</tr>
</table>
	<hr>
	
	<jsp:include page="/frontdesk/artiReply/listReply_ByArtiNo.jsp" flush="true" />

</body>
</html>