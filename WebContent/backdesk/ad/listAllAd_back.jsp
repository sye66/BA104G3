<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.ad.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    AdService adSvc = new AdService();
    Set<AdVO> set = adSvc.getAllAd();
    pageContext.setAttribute("set",set);    
%>

<jsp:useBean id="adDAO" scope="page" class="com.ad.model.AdDAO" />

<html>
<head>
<title>所有廣告資料 - listAllAD.jsp</title>

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
        <h3> 這裡是討論區廣告資料查詢 -- LIST ALL :   //      <a href="/BA104G3/backdesk/ad/addAd.jsp">Add</a> a new AD.</h3><br/>
        </div>

        <div class="widgetcontent padding0 statement">
            <table cellpadding="0" cellspacing="0" border="0" class="stdtable">

                <thead>
                    <tr>
                        <th> 廣告編號 </th>
                        <th> 廣告標題 </th>
                        <th> 廣告商編號 </th>
                        <th> 廣告商名稱 </th>
                        <th> 廣告開始時間 </th>
                        <th> 廣告結束時間 </th>
                        <th colspan="2"> 後台管理 </th>
                    </tr>
                 </thead>
                 <%@ include file="/backdesk/page1.file" %> 
	             <c:forEach var="adVO" items="${set}" varStatus="s" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" >
	
                 <tbody>
                     <tr>
                         <td>${adVO.ad_No} </td>
                         <td> ${adVO.ad_Desc} </td>
                         <td> ${adVO.ad_Fty_No} </td>
                         <td> ${adVO.ad_Fty_Name} </td>
                         <td> <fmt:formatDate value="${adVO.ad_Start}" pattern="yyyy-MM-dd HH:mm:ss.SSS"/> </td>
                         <td> <fmt:formatDate value="${adVO.ad_End}" pattern="yyyy-MM-dd HH:mm:ss.SSS"/> </td>

                             <td>
                             <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ad/ad.do" style="margin-bottom: 0px;">
			                 <input type="hidden" name="adNo"  value="${adVO.ad_No}">
			                 <input type="hidden" name="emp_No"  value="${empVO.emp_No}">
			                 <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                 <input type="hidden" name="whichPage" value="<%=whichPage%>">
			                 <button class="btn btn-danger" type="submit" name="action" value="deleteAdFMBack"> 刪除廣告 </button>
 			                 <input type="hidden" name="whichPage" value="<%=whichPage%>"> 
			                 </FORM>
			                 </td>
			                 
                             <td>
			                 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ad/ad.do" style="margin-bottom: 0px;">
			                 <input type="hidden" name="ad_No"  value="${adVO.ad_No}">
			                 <input type="hidden" name="emp_No"  value="${empVO.emp_No}">
			                 <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                 <input type="hidden" name="whichPage" value="<%=whichPage%>">
			                 <button class="btn btn-info" type="submit" name="action" value="getOneAd_For_Display"> 查看廣告 </button>
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