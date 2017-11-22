<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ad.model.*"%>

<%-- 此頁暫練習採用 Script 的寫法取值 --%>
<%
  AdService adSvc = new AdService();
  Set<AdVO> set = adSvc.getAllAd();
  pageContext.setAttribute("set",set);

 %>
<jsp:useBean id="adSvc1" scope="page" class="com.ad.model.AdService" />
<html>
<head>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />

<title>文章回覆資料 - listOneArtiReply.jsp</title>

<style>
 
</style>

</head>
<body bgcolor='blue'>

<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true" />

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>廣告 - ListOneAD.jsp</h3>
		 <h4><a href="selectReply_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回文章回覆首頁</a></h4>
	</td></tr>
</table>


<div class="container">
<div id="carousel-id" class="carousel slide" data-ride="carousel">
		    <!-- 幻燈片小圓點區 -->
		    <ol class="carousel-indicators">
		    <c:forEach var="adVO" items="${adSvc.getAllAd(adVO.ad_No)}" varStatus="p">
		     <c:if test="${p.index == 0 }">
		        <li data-target="#carousel-id" data-slide-to="${p.index}" class="active"></li>
		        </c:if>
		        <c:if test="${p.index != 0 }">
		        <li data-target="#carousel-id" data-slide-to="${p.index}" class=""></li>
		        </c:if>
		        </c:forEach>
		    </ol>
		    <!-- 幻燈片主圖區 -->
		    <div class="carousel-inner">
		    <c:forEach var="adVO" items="${adSvc.getAllAd(adVO.ad_No)}" varStatus="p">
		    <c:if test="${p.index == 0 }">
		        <div class="item active">
		            <img src="<%=request.getContextPath()%>/tool/showimage.do?action=ad_Pic&ad_No=${adVO.ad_No}"
	                     style="height:120px;width:150px; box-shadow:3px 3px 12px gray;padding:3px;"/>
		            <div class="container">
		                <div class="carousel-caption">
		                    <h1>CSS可樂好喝超爽快</h1>
		                    <p>你喝過了嗎？</p>
		                    <p><a class="btn btn-lg btn-primary" href="#" role="button">Sign up today</a></p>
		                </div>
		            </div>
		        </div>
		     </c:if>
		     <c:if test="${p.index != 0 }">
		        <div class="item">
		            <img src="https://api.fnkr.net/testimg/2800x700/aaaaaa" alt="">
		            <div class="container">
		                <div class="carousel-caption">
		                    <h1>CSS可樂的外掛真方便</h1>
		                    <p>你安裝了嗎？</p>
		                    <p><a class="btn btn-lg btn-primary" href="#" role="button">更多</a></p>
		                </div>
		            </div>
		        </div>
		    </c:if>
			</c:forEach>
		    </div>
		    <!-- 上下頁控制區 -->
		    <a class="left carousel-control" href="#carousel-id" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
		    <a class="right carousel-control" href="#carousel-id" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
		</div>




	<div class="col-xs-12 col-sm-11 widget-container-span">
                <div class="widget-box">
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter"> ${adVO.ad_No} </h5>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                            <jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService"/>
                            <div class="" style="">${adVO.ad_Desc}</div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">${adVO.ad_Star}</div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">${adVO.ad_End}</div>
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
                                        ${adVO.ad_Fty_No}
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="widget-main padding-16">
                            ${adVO.ad_Fty_Name}
                        </div>
                    </div>
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter">111111111111111111111111</h5>
                        <div class="widget-toolbar">
                            <div class="btn-group">
                            <div>
                                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ad/ad.do" style="margin-bottom: 0px;">
                                <input type="hidden" name="reply_No"  value="${adVO.ad_No}">
			                    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
 			                    <button class="btn btn-success" type="submit" name="action" value="getOneReply_For_Update">修改回覆</button>
			                    </FORM>
                            </div>
                            </div>
                            <div class="btn-group">
                            <div>
                                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ad/ad.do" style="margin-bottom: 0px;">
			                    <input type="hidden" name="reply_No"  value="${adVO.ad_No}">
			                    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                    <button class="btn btn-danger" type="submit" name="action" value="deleteReply">刪除回覆</button>
 			                    </FORM>  
                            </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
  
</body>

 <jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />
</html>