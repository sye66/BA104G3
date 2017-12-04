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
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/artiAll.css" />

<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<title>listMusic.jsp</title>

<style>

 .video-container {
	position:relative;
	padding-bottom: 56.25%; 
	padding-top:30px;
	height:100px ;
	overflow:hidden;
	margin-left:10px;
}

.video-container iframe, .video-container object, .video-container embed {
	position:absolute;
	top:0;
	left:0;
	width:80%;
	height:80%;
}
.gridContainer clearfix{
  margin:0 auto;
}

@media all and ( min-width: 560px ) {
    .div_style { 
        width:560px;
        padding-bottom:315px !important;
    }
}

</style>

</head>
<body bgcolor='blue'>
<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true" />
<br><br>
<jsp:include page="/frontdesk/ad/listOneAd.jsp" flush="true" />

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
                        <a class="refresh" href="/BA104G3/frontdesk/artiReport/listReport_ByMemNo.jsp">
                            <i></i>Report return
                        </a>
                        </c:if>
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
                        <c:if test="${memVO.mem_State == 1}">
                        <a class="fullscreen" id="fullscreen-toggler" href="/BA104G3/frontdesk/artiForm/addArtiForm.jsp">
                            <i> POST </i>
                        </a>
                        </c:if>
                        <a class="sidebar-toggler" href="/BA104G3/frontdesk/ad/GroupChat.jsp">
                            <i>Chat</i>
                        </a>
                    </div>
                    </div>

<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/kkx-7fsiWgg?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/DsmmaWs5PeQ?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>
        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/xvW-Gt-FLIE?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/Ms5st61sIkY?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>
        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/uLLJQeWhsA8?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/fywnbx7Qsto?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/lekZoatHo_I?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/TpK9SU-KGo8?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/_opouukG5w4?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/pVxgZXphu2k?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/QPp0mBS-A8g?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/p9bbYSuMQCU?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/QCUqYlvmAnk?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/3WNCDQMBdP0?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

		<div class="container" >
		    <div class="video-container">
	           <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/kXpWfjUqj_s?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>        
       <div class="container" >
		    <div class="video-container">
	           <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/JmXKhQlHzQw?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>        
        <div class="container" >
		    <div class="video-container">
	           <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/2dVyPvdMtwg?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>        
        <div class="container" >
		    <div class="video-container">
	           <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/VmQRnFWX--w?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>        
        <div class="container" >
		    <div class="video-container">
	           <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/jiwuQ6UHMQg?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>
        <div class="container" >
		    <div class="video-container">
	           <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/DNrnDx-KZUY?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/9QR64g26dEs?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/Eo9qB-vqSiQ?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/ABy95341Dto?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/DNp1KSVHbBI?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

        <div class="container" >
        <div class="video-container">
		    <div class="auto-resizable-iframe">
        <iframe class="embed-responsive" frameborder="0" width="560" height: auto !important; allowfullscreen="0" 
                        title="Youtube viedo player" width="50%" height="50%" 
                        src="https://www.youtube.com/embed/MrX7ugsks5o?&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1&wmode=transparent&origin=https%3A%2F%2Fwww.domraider.io&widgetid=1" 
                        sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:560px; height:315px;">
        </iframe>
        </div>
        </div>
        </div>
<hr>

</body>
<script>

</script>

 <jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />
</html>