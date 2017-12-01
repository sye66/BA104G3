<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    MemVO memVO = (MemVO) session.getAttribute("memVO");
%>

<html>
<head>
<title>所有文章資料 - listAllArtiForm.jsp</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

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
	width:32%;
	height:32%;
}
.gridContainer clearfix{
  margin:0 auto;
}

</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
</head>

<body style="background: url('.jpg') no-repeat center center fixed; background-size: cover; background-color:white;">


            
<div class="video-container">
        <iframe class="embed-responsive" frameborder="0" allowfullscreen="1" 
                      title="Youtube viedo player" width="50%" height="50%" 
                      src="https://www.youtube.com/embed/wo_ZsB07Yi0?playlist=ehjOL_bqzSc&iv_load_policy=3&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1" 
                      id="widget2" sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:600px; height:300px; webkitallowfullscreen mozallowfullscreen allowfullscreen;">
        </iframe>          
</div>

<div class="video-container">
        <iframe class="embed-responsive" frameborder="0" allowfullscreen="1" 
                      title="Youtube viedo player" width="50%" height="50%" 
                      src="https://www.youtube.com/embed/_XTy4nDIt34?playlist=ehjOL_bqzSc&iv_load_policy=3&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1" 
                      id="widget2" sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:600px; height:300px; webkitallowfullscreen mozallowfullscreen allowfullscreen;">
        </iframe>          
</div>

<div class="video-container">
        <iframe class="embed-responsive" frameborder="0" allowfullscreen="1" 
                      title="Youtube viedo player" width="50%" height="50%" 
                      src="https://www.youtube.com/embed/ATmIlYKLvZ8?playlist=ehjOL_bqzSc&iv_load_policy=3&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1" 
                      id="widget2" sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:600px; height:300px; webkitallowfullscreen mozallowfullscreen allowfullscreen;">
        </iframe>          
</div>

<div class="video-container">
        <iframe class="embed-responsive" frameborder="0" allowfullscreen="1" 
                      title="Youtube viedo player" width="50%" height="50%" 
                      src="https://www.youtube.com/embed/dqCb-8QatQ8?playlist=ehjOL_bqzSc&iv_load_policy=3&enablejsapi=1&disablekb=1&autoplay=0&controls=1&showinfo=1&rel=0&loop=1" 
                      id="widget2" sytle="position: absolute; max-width:50% marging-left:-61px; margin-top:0px; width:600px; height:300px; webkitallowfullscreen mozallowfullscreen allowfullscreen;">
        </iframe>          
</div>


<hr>
    <!--Basic Scripts-->
    <script src="js/jquery-2.0.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <!--Beyond Scripts-->
    <script src="js/beyond.min.js"></script>

    <!--Page Related Scripts-->
    <!--Google Analytics::Demo Only-->

</body>

</html>