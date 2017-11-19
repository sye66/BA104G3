<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.artiReply.model.*"%>
<%@ page import="com.mem.model.*"%>

<jsp:useBean id="artiFormSvc" scope="session" class="com.artiForm.model.ArtiFormService" />
<jsp:useBean id="artiReplySvc1" scope="session" class="com.artiReply.model.ArtiReplyService" />

<%
    ArtiReplyService artiReplySvc = new ArtiReplyService();

	String arti_No = (String) session.getAttribute("arti_No");
	String mem_No = (String) session.getAttribute("mem_No");
	session.setAttribute("mem_No",mem_No);

    Set<ArtiReplyVO> set = ( Set<ArtiReplyVO>) artiReplySvc.findReplyByArtiNo(arti_No);
    pageContext.setAttribute("set",set);
%>

<html>
<head><title> 分類文章 - listReply_ByArtiNo.jsp   ${arti_No} </title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>


<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/reply.min.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />
<style>
  table#table-2 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-2 h4 {
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
${arti_No}
<h4>此頁練習採用 EL 的寫法取值:</h4>
<table id="table-2">
	<tr><td>
		 <h3> 分標題列出回覆文章 - listReply_ByArtiNo.jsp ${arti_No } </h3>
		 <h4><a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
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

<c:forEach var="artiReplyVO" items="${artiReplySvc1.findReplyByArtiNo(arti_No)}" >
<div class="col-xs-12 col-sm-11 widget-container-span">
                <div class="widget-box">
                    <div class="widget-header header-color-dark">
                    
                        <h5 class="bigger lighter"> ${artiReplyVO.mem_No} </h5>
                        
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">
			                        
			                    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" style="margin-bottom: 0px;">
			                        <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			                        <input type="hidden" name="reply_No"  value="${artiReplyVO.reply_No}">
			                        <input type="hidden" name="mem_No"  value="${memVO.mem_No}">
			                        <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                        <button class="btn btn-danger" type="submit" name="action" value="deleteReply">刪除回覆</button>
 			                    </FORM>
                                
                                </div>
                            </div>
                        </div>
                        
                        
                      <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">
                                
                                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" style="margin-bottom: 0px;">
                                    <input type="hidden" name="reply_No"  value="${artiReplyVO.reply_No}">
                                    <input type="hidden" name="mem_No"  value="${memVO.mem_No}">
			                        <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
 			                        <button class="btn btn-success" type="submit" name="action" value="getOneReplyWithSet_For_Update">修改回覆</button>
			                    </FORM>
                                
                                </div>
                            </div>
                        </div>
                        
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
                        
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">
                                ${artiReplyVO.reply_Time}
                                </div>
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
                                            <img src="<%=request.getContextPath()%>/tool/showimage.do?action=mem_Pic&mem_No=${artiReplyVO.mem_No}&mem_${memSvc.getOneMem(artiReplyVO.mem_No).mem_pic}"
	                     style="height: 120px;width: 150px; box-shadow:3px 3px 12px gray;padding:3px;"/>
	                                        <p>${memSvc.getOneMem(artiReplyVO.mem_No).mem_Name}</p>
	                                        </div>
                                        </div>
                                    </div>
                                    <div class="widget-toolbar">
                                        <font size="3"> ${artiReplyVO.reply_Desc} </font>                        
                                    </div>
         
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    </div>

	</c:forEach>

</html>

<br>本網頁的路徑:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>