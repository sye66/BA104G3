<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.artiForm.model.*"%>
<%@ page import="com.mem.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    MemVO memVO = (MemVO) session.getAttribute("memVO");

    ArtiFormVO artiFormVO = new ArtiFormVO();
    ArtiFormService artiSvc = new ArtiFormService();
    
    Set<ArtiFormVO> set = artiSvc.getAll();
    pageContext.setAttribute("set",set);
%>

<jsp:useBean id="artiFormDAO" scope="page" class="com.artiForm.model.ArtiFormDAO" />

<html>
<head>
<title>所有文章資料 - listAllArtiForm.jsp</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/artiAll.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
div> .timeline-body{
    float: left;
}

.video-container {
	position:relative;
	padding-bottom:56.25%;
	padding-top:30px;
	height:0 ;
	overflow:hidden;
	margin-left:10px;
}

.video-container iframe, .video-container object, .video-container embed {
	position:absolute;
	top:10px;
	left:10px;
	width:100%;
	height:100%;
}
.gridContainer clearfix{
  margin:0 auto;
}
  
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
</head>

<body style="background: url('.jpg') no-repeat center center fixed; background-size: cover; background-color:white;">

<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true" />
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<jsp:include page="/frontdesk/ad/listOneAd.jsp" flush="true" />
<div class="container">
<div class="page-header position-relative">

                <div class="title">
                    <div class="list">
                        <a  href="/BA104G3/frontdesk/artiForm/listAllArtiForm.jsp"><h1>所有文章列表 </h1></a>
                    </div>
                </div>
                    
                <div class="title">
                      <div class="search">
                        <h1>
                       <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do"  name="form1" enctype="multipart/form-data">
                         <input type="text" size="40"  class="" name="describe"  placeholder="請輸入內文關鍵字">
                        <input type="hidden" name="describe"  value="${artiFormVO.describe}">
    			         <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
                        <button class="btn btn-info" type="submit" name="action" value="listArti_BySearch"> GO!!! </button>
                        </FORM>
                        </h1>
                      </div>
                  </div>
    
                    <!--Header Buttons-->
                    
                    <div class="header-buttons">
                    <c:if test="${memVO.mem_State == 1}">
                        <a class="sidebar-toggler" href="/BA104G3/frontdesk/ad/listMusic.jsp">
                            <i></i>Relax Music
                        </a>
                        </c:if>
                        <c:if test="${memVO.mem_State == 1}">
                        <a class="refresh" id="refresh-toggler" href="/BA104G3/frontdesk/artiForm/listArti_ByMemNo.jsp">
                            <i>Personal</i>
                        </a>
                            </c:if>
                        <a class="fullscreen" id="fullscreen-toggler" href="/BA104G3/frontdesk/artiForm/addArtiForm.jsp">
                            <i> POST </i>
                        </a>
                        <a class="sidebar-toggler" href="/BA104G3/frontdesk/artiForm/listAllArtiForm.jsp">
                            <i>Main page</i>
                        </a>
                    </div>
                    </div>
            
<div class="page-body">
<div class="video-container">

        <iframe class="embed-responsive" frameborder="0" allowfullscreen="1" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/jSwV3IpNF2U?playlist=ehjOL_bqzSc&iv_load_policy=3&enablejsapi=1&disablekb=1&autoplay=1&controls=0&showinfo=0&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        id="widget2" sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:600px; height:300px; webkitallowfullscreen mozallowfullscreen allowfullscreen;">
        </iframe>          
</div>
</div>

</div>
<hr>
    <!--Basic Scripts-->
    <script src="js/jquery-2.0.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <!--Beyond Scripts-->
    <script src="js/beyond.min.js"></script>

    <!--Page Related Scripts-->
    <!--Google Analytics::Demo Only-->
    <script>
        (function (i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function () {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
            m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', 'http://www.google-analytics.com/analytics.js', 'ga');

        ga('create', 'UA-52103994-1', 'auto');
        ga('send', 'pageview');

        
    </script>
</body>

 <jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />
</html>