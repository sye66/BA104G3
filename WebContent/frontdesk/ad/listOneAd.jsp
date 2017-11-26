<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.ad.model.*"%>

<%-- 此頁暫練習採用 Script 的寫法取值 --%>
<%
//   AdVO adVO = new AdVO();
//   AdService adSvc = new AdService();
//   Set<AdVO> set = adSvc.getAllAd();
//   pageContext.setAttribute("set",set);

 %>
<jsp:useBean id="adSvc" scope="page" class="com.ad.model.AdService" />
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />

<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<title>文章回覆資料 - listOneArtiReply.jsp</title>

<style>
.carousel-caption >p{
  font-weight:bolder;
  color: #00F0F0;
  font-size: 28px;
  font-family:Microsoft JhengHei;
}

.carousel-caption >h1{
  color: #FFFF0F;
  font-size: 36px;
  font-family:Microsoft JhengHei;
}
 

</style>

</head>
<body bgcolor='blue'>

<%-- ${adSvc1.allAd}  here!!!! --%>
<%-- ${adSvc.getAllAd(adVO.ad_No)} --%>
<br><br><br><br><br><br>
<div class="container">
<div id="carousel-id" class="carousel slide" data-ride="carousel">
		    <!-- 幻燈片小圓點區 -->
		    <ol class="carousel-indicators">
		  <c:forEach var="adVO" items="${adSvc.allAd}" varStatus="p">
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
		    <c:forEach var="adVO" items="${adSvc.allAd}" varStatus="p">
		    <c:if test="${p.index == 0 }">
		        <div class="item active">

		            <img src="<%=request.getContextPath()%>/tool/showimage.do?action=ad_Pic&ad_No=${adVO.ad_No}ad_${adSvc.getOneAd(adVO.ad_No).ad_Pic}"/>
		            <div class="container">
		                <div class="carousel-caption">
		                    <h1>${adVO.ad_Fty_Name}</h1>
		                    <p>${adVO.ad_Desc}</p>
		                    <p><a class="btn btn-lg btn-primary" href="#" role="button"></a>${adVO.ad_No}</p>
		                </div>
		            </div>
		        </div>
		     </c:if>
		     <c:if test="${p.index != 0 }">
		        <div class="item">
		            <img src="<%=request.getContextPath()%>/tool/showimage.do?action=ad_Pic&ad_No=${adVO.ad_No}"/>
		            <div class="container">
		                <div class="carousel-caption">
		                    <h1>${adVO.ad_Fty_Name}</h1><br>
		                    <p>${adVO.ad_Desc}</p>
		                    <p><a class="btn btn-lg btn-primary" href="#" role="button">${adVO.ad_No}</a></p>
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
<hr>
</div>
</body>

</html>