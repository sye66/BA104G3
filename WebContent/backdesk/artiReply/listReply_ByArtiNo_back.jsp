<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.artiReply.model.*"%>
<%@ page import="com.emp.model.*"%>

<jsp:useBean id="artiFormSvc" scope="session" class="com.artiForm.model.ArtiFormService" />
<jsp:useBean id="artiReplySvc1" scope="session" class="com.artiReply.model.ArtiReplyService" />
<%
    EmpVO empVO = (EmpVO) session.getAttribute("empVO");

    ArtiReplyService artiReplySvc = new ArtiReplyService();
	String arti_No = (String) session.getAttribute("arti_No");
    Set<ArtiReplyVO> set = ( Set<ArtiReplyVO>) artiReplySvc.findReplyByArtiNo(arti_No);
    pageContext.setAttribute("set",set);
%>

<html>
<head><title> 分類文章 - listReply_ByArtiNo.jsp   ${arti_No}</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>


<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/reply.min.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />
<style>
h3{
    font-size: 48px;
    color: #F00;
}
</style>

</head>
<body bgcolor='white'>

<div class="widgetbox">
        <div class="title">
        <h3 > 這邊是回覆文章分隔線 </h3>
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

<c:forEach var="artiReplyVO" items="${artiReplySvc1.findReplyByArtiNo(arti_No)}" >
<div class="col-xs-8 col-sm-8 widget-container-span">
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
                                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" >
		                        <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
		                        <input type="hidden" name="mem_No"  value="${memVO.mem_No}">
		                        <input type="hidden" name="arti_Cls_No"  value="${artiFormVO.arti_Cls_No}">
		                        <input type="hidden" name="report_Desc"  value="${artiReportVO.report_Desc}">
                                <button class="btn btn-warning" type="submit" name="action" value="insertReport_4Reply"> 檢舉回覆 </button>
		         </FORM>
                            </div>
                            </div>
                            <div class="btn-group">
                            <div>
                                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" style="margin-bottom: 0px;">
			                    <input type="hidden" name="reply_No"  value="${artiReplyVO.reply_No}">
			                    <input type="hidden" name="emp_No"  value="${empVO.emp_No}">
			                    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                    <button class="btn btn-danger" type="submit" name="action" value="deleteReplyFMBack">刪除回覆</button>
 			                    </FORM>  
                            </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>

	</c:forEach>

</html>

</body>
</html>