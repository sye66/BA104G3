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
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/arti_back_style.css" />

<title>文章回覆資料(後台) - listArtiReply_withSet (REVISED).jsp </title>

<style>

    a{
   font-size: 24px;
   color: #F00;
  }
  
</style>
</head>
<body bgcolor='white'>

<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/artiForm/backdeskLeft_ArtiForm.jsp" flush="true" />
	
	
	    <div class="widgetbox">
        <div class="title">
        <h3> 這裡是討論區文章資料查詢 -- 列出單ㄧ文章的所有回覆   // <a href="/BA104G3/backdesk/artiReply/listAllArtiReply_back.jsp">List</a> all Article Reply.  
        </div>
        </div>


<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<br>
<hr>
	<%@ include file="/frontdesk/page1.file" %> 
	<c:forEach var="artiReplyVO" items="${set}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
	
	<br>
	<div class="col-xs-8 col-sm-8 widget-container-span">
                <div class="widget-box">
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter"> ${artiReplyVO.mem_No} </h5>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                            <jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService"/>
                                <div class="" style="">${artiClassSvc.getOneClass(artiReplyVO.arti_Cls_No).arti_Cls_Name }</div>
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
    <img src="<%=request.getContextPath()%>/tool/showimage.do?action=mem_Pic&mem_No=${artiReplyVO.mem_No}&mem_${memSvc.getOneMem(artiReplyVO.mem_No).mem_Pic}"
	                     style="height: 120px;width: 150px; box-shadow:3px 3px 12px gray;padding:3px;"/>
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
			                    <button class="btn btn-danger" type="submit" name="action" value="deleteReply">刪除回覆</button>
 			                    <input type="hidden" name="whichPage" value="<%=whichPage%>">
 			                    </FORM>  
                            </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
	</c:forEach>
<div class="container" style="font-size: 18px; text-align: center;">    
 <%@ include file="/backdesk/page2.file" %> 
 </div>
</body>
</html>