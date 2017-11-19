<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.artiForm.model.*"%>
<%@ page import="com.artiClass.model.*"%>
<%@ page import="com.artiReply.model.*"%>
<%@ page import="com.artiReport.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  ArtiReplyService artiReplySvc = new ArtiReplyService();
  ArtiReplyVO artiReplyVO = (ArtiReplyVO) request.getAttribute("artiReplySet"); 
  
 %>


<html>
<head>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/reply.min.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />

<title>文章回覆資料 - listOneArtiReply.jsp</title>

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
	width: 600px;
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
		 <h3>文章回覆資料 - ListOneArtiReply.jsp</h3>
		 <h4><a href="selectReply_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回文章回覆首頁</a></h4>
	</td></tr>
</table>


	<div class="col-xs-12 col-sm-11 widget-container-span">
                <div class="widget-box">
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter"> ${artiReplyVO41.mem_No} </h5>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                            <jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService"/>
                            <div class="" style="">${artiClassSvc.getOneClass(artiReplyVO41.arti_Cls_No).arti_Cls_Name }</div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">${artiReplyVO41.arti_No}</div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">${artiReplyVO41.reply_No}</div>
                            </div>
                        </div>
                    </div>
                    <div class="widget-body">
                        <div class="widget-toolbox">
                            <div class="btn-toolbar">
                                <div class="btn-group">
                                    <div class="widget-toolbar">
                                    <div class="widget-main padding-6">
                                            <div class="pic">
    <img src="<%=request.getContextPath()%>/tool/showimage.do?action=mem_Pic&mem_No=${memVO.mem_No}"
	                     style="height:100px;width:120px;"/>
    </div>
                                    </div>
                                    </div>
                                    <div class="widget-toolbar">
                                    <div class="widget-main padding-6">
                                        <i class="icon-remove bigger-110"></i>
                                        <jsp:useBean id="artiFormSvc" scope="page" class="com.artiForm.model.ArtiFormService" />
                                        ${artiFormSvc.getOneArtiForm(artiReplyVO41.arti_No).arti_Title}
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="widget-main padding-16">
                            ${artiReplyVO41.reply_Desc}
                        </div>
                    </div>
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter">${artiReplyVO41.reply_Time}</h5>
                        <div class="widget-toolbar">
                            <div class="btn-group">
                            <div>
                                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" style="margin-bottom: 0px;">
                                <input type="hidden" name="reply_No"  value="${artiReplyVO41.reply_No}">
                                <input type="hidden" name="mem_No"  value="${memVO.mem_No}">
			                    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
 			                    <button class="btn btn-success" type="submit" name="action" value="getOneReply_For_Update">修改回覆</button>
			                    </FORM>
                            </div>
                            </div>
                            <div class="btn-group">
                            <div>
                                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" style="margin-bottom: 0px;">
			                    <input type="hidden" name="reply_No"  value="${artiReplyVO41.reply_No}">
			                    <input type="hidden" name="mem_No"  value="${memVO.mem_No}">
			                    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                    <button class="btn btn-danger" type="submit" name="action" value="deleteReply">刪除回覆</button>
 			                    </FORM>  
                            </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
                <hr>
                
                <div class="widget-main padding-28">
                 ${artiReplyVO41.arti_No}
                          <p>您的回覆已新增，請確認要回
                          <button class="btn btn-info"> <a href="/BA104G3/frontdesk/artiForm/listAllArtiForm.jsp"> 所有文章列表 </a></button>，或回
                          
                          <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" style="margin-bottom: 0px;">
			              <input type="hidden" name="arti_No"  value="${artiReplyVO41.arti_No}">
			              <input type="hidden" name="arti_Cls_No"  value="${artiReplyVO41.arti_Cls_No}">
			              <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
                          <button class="btn btn-info" type="submit" name="action" value="jumpOne_For_Display"> 剛才瀏覽文章頁面 </a></button>，謝謝。</p>  
                          </div>
                        </div>                  
</body>
</html>