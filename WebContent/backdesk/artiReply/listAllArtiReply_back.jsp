<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.artiReply.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    ArtiReplyService artiReplySvc = new ArtiReplyService();
    Set<ArtiReplyVO> set = artiReplySvc.getAllReply();
    pageContext.setAttribute("set",set);
%>
<jsp:useBean id="artiReplyDAO" scope="page" class="com.artiReply.model.ArtiReplyDAO" />
<html>
<head>
<title>所有回覆文章資料 - listAllArtiReply.jsp</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/arti_back_style.css" />
<style>

  body{margin:40px;}
  
    a{
   font-size: 24px;
   color: #F00;
  }

</style>

</head>
<body bgcolor='white'>

<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/artiForm/backdeskLeft_ArtiForm.jsp" flush="true" />


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

        <div class="title">
        <h3> 這裡是討論區文章所有回覆列表 -- LIST ALL : </h3><br/>
        </div>

        <div class="widgetcontent padding0 statement">
            <table cellpadding="0" cellspacing="0" border="0" class="stdtable">

                <thead>
                    <tr>
                        <th> 回覆編號 </th>
                        <th> 會員名稱 </th>
                        <th> 文章標題 </th>
                        <th> 回覆時間 </th>
                        <th> 類別 </th>
                        <th colspan="2"> 後台管理 </th>
                    </tr>
                 </thead>
    <%@ include file="/backdesk/page1.file" %> 
	<c:forEach var="artiReplyVO" items="${set}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
	
                 <tbody>
                     <tr>
                             <td> ${artiReplyVO.reply_No} </td>
                             <td> ${artiReplyVO.mem_No} </td>
                             
                             <jsp:useBean id="artiFormSvc" scope="page" class="com.artiForm.model.ArtiFormService"/>
                             <td> ${artiFormSvc.getOneArtiForm(artiReplyVO.arti_No).arti_Title }</td>
                             <td> <fmt:formatDate value="${artiReplyVO.reply_Time}" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
                             
                             <jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService"/>
                             <td> ${artiClassSvc.getOneClass(artiReplyVO.arti_Cls_No).arti_Cls_Name } </td>
                             
                             <td>
                             <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" style="margin-bottom: 0px;">
			                 <input type="hidden" name="reply_No"  value="${artiReplyVO.reply_No}">
			                 <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                 <input type="hidden" name="whichPage" value="<%=whichPage%>">
			                 <button class="btn btn-danger" type="submit" name="action" value="deleteReplyFMBack"> 刪除回覆 </button>
 			                 <input type="hidden" name="whichPage" value="<%=whichPage%>"> 
			                 </FORM>
			                 </td>
			                 
                             <td>
			                 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" style="margin-bottom: 0px;">
			                 <input type="hidden" name="reply_No"  value="${artiReplyVO.reply_No}">
			                 <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                 <input type="hidden" name="whichPage" value="<%=whichPage%>">
			                 <button class="btn btn-info" type="submit" name="action" value="getOneReplyFMback_For_Display"> 查看回覆 </button>
 			                 <input type="hidden" name="whichPage" value="<%=whichPage%>"> 
			                 </FORM>
		                     </td>
                         </tr>
                     </tbody>
                     </c:forEach>
                 </table>
             </div><!--widgetcontent-->
         </div><!--widgetbox-->
          <hr>
 <br>
 <%@ include file="/backdesk/page2.file" %> 


</body>
</html>