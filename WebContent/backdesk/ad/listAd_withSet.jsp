<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.ad.model.*"%>

<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  AdService adSvc = new AdService();
  Set<AdVO> set= (Set<AdVO>) request.getAttribute("adSet");
  String ad_Fty_No = (String) adSvc.
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

<title>文章回覆資料(後台) - listAd_withSet (REVISED) </title>

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
        <h3> 這裡是討論區文章資料查詢 -- 列出單ㄧ文章的所有回覆   // <a href="/BA104G3/backdesk/ad/listAllAd_back.jsp">List</a> all AD.  
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
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ad/ad.do" name="form1" enctype="multipart/form-data">

<div class="col-xs-8 col-sm-8 widget-container-span">
                <div class="widget-box">
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter"> ${adVO.ad_No} </h5>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">
                                ${adVO.ad_Fty_No}
                                </div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">${adVO.ad_Fty_Name}</div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style=""> </div>
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
                        <img src="<%=request.getContextPath()%>/tool/showimage.do?action=ad_Pic&ad_No=${adVO.ad_No}"
	                     style="height:250px;width:900px; box-shadow:3px 3px 12px gray;padding:3px;"/>
                              </div>
    </div>
                                    </div>
                                    </div>
                                    <div class="widget-toolbar">
                                    <div class="widget-main padding-6">
     
                                    </div>
                                    </div>
                                    
                                    <div class="widget-toolbar">
                                    <div class="widget-main padding-6">
                                      <p class="title"> 廣告標題 : ${adVO.ad_Desc} </p>
                                      <p class="start"> 廣告開始時間 : ${adVO.ad_Start} </p>
                                      <p class="end"> 廣告結束時間 : ${adVO.ad_End}</p>
                                    </div>
                                    </div>
                                    
                                </div>
                            </div>
                        
                        <div class="widget-main padding-16">
                        <h4></h4><br>

                        </div>
                    </div>
                    
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter"></h5>
                        <div class="widget-toolbar">
                        
                            <div class="btn-group">
                            <div>
                            <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ad/ad.do" >
			                <input type="hidden" name="ad_No"  value="${adVO.ad_No}">
			                <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                <button class="btn btn-danger" type="submit" name="action" value="deleteAd">刪除廣告</button>
                            </FORM>
                            </div>
                            </div>
                           
                            <div class="btn-group">
                            <div>
                              
                            </div>
                            </div>
                            
                            </div>
                        </div>
                    </div>
                </div>
               
		</FORM>

	</c:forEach>

 <%@ include file="/backdesk/page2.file" %> 
</body>
</html>