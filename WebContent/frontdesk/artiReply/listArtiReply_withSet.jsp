<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.artiReply.model.*"%>
<%@ page import="com.mem.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  ArtiReplyService artiReplySvc = new ArtiReplyService();
  Set<ArtiReplyVO> set= (Set<ArtiReplyVO>) request.getAttribute("artiReplySet");
  pageContext.setAttribute("set",set);
%>

<html>
<head>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/reply.min.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />
<title>文章回覆資料 - listArtiReply_withSet (REVISED).jsp </title>

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
	width: auto;
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

.popoverexample .popover{
    position:relative;
    display:block;
    width:auto;
    margin:20px
}

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
		 <h3>文章回覆資料 - ListOneArtiReply_WithSet (REVISED)).jsp</h3>
		 <h4><a href="selectReply_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回文章回覆首頁</a></h4>
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

	<%@ include file="/frontdesk/page1.file" %> 
	<c:forEach var="artiReplyVO" items="${set}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
	
	
	<div class="col-xs-12 col-sm-11 widget-container-span">
                <div class="widget-box">
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter"> ${artiReplyVO.mem_No} </h5>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">${artiReplyVO.arti_Cls_No}</div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">${artiReplyVO.arti_No}</div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">${artiReplyVO.reply_No}</div>
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
                                        <i class="icon-remove bigger-110"></i>Reject
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="widget-main padding-16">
                            ${artiReplyVO.reply_Desc}
                        </div>
                    </div>
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter">${artiReplyVO.reply_Time}</h5>
                        <div class="widget-toolbar">
                            <div class="btn-group">
                            <div>
                                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" style="margin-bottom: 0px;">
                                <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
                                <input type="hidden" name="reply_No"  value="${artiReplyVO.reply_No}">
			                    <input type="hidden" name="mem_No"  value="${memVO.mem_No}">
			                    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                    <input type="hidden" name="whichPage" value="<%=whichPage%>">
 			                    <button class="btn btn-success" type="submit" name="action" value="getOneReplyWithSet_For_Update">修改回覆</button>
			                    <input type="hidden" name="whichPage" value="<%=whichPage%>">
			                    </FORM>
                            </div>
                            </div>
                            <div class="btn-group">
                            <div>
                                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" style="margin-bottom: 0px;">
			                    <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			                    <input type="hidden" name="reply_No"  value="${artiReplyVO.reply_No}">
			                    <input type="hidden" name="mem_No"  value="${memVO.mem_No}">
			                    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                    <input type="hidden" name="whichPage" value="<%=whichPage%>">
			                    <button class="btn btn-danger" type="submit" name="action" value="deleteReply">刪除回覆</button>
 			                    <input type="hidden" name="whichPage" value="<%=whichPage%>">
 			                    </FORM>  
                            </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
    
	<tr>	
		<td></td>
		<td></td>
		<jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService"/>
			<td>${artiClassSvc.getOneClass(artiReplyVO.arti_Cls_No).arti_Cls_Name }</td>
	</tr>

	</c:forEach>

 <%@ include file="/backdesk/page2.file" %> 
</body>
</html>