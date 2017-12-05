<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.getmission.model.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="getMissionSvc" scope="page" class="com.getmission.model.GetMissionService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<%
	GetMissionVO getMissionVO = (GetMissionVO) request.getAttribute("mission_No");
	String mem_No = (String) session.getAttribute("mem_No");
%>

<!DOCTYPE html>
<html lang="">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>wowAmaze</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
</head>

<style>
.slickButton3 {
    color: white;
    font-weight: bold;
    padding: 10px;
    border: solid 1px lightgray;
    background: lightgreen;
    cursor: pointer;   
    transition: box-shadow 0.5s;
    -webkit-transition: box-shadow 0.5s;
}
 
.slickButton3:hover {
    box-shadow:25px 25px 50px gray;
}

</style>
<body>
    <%@ include file="/lib/publicfile/include/file/navbar.jsp"%>
        <br>
        <br>
        <br>
        <br>
        <br>
        <br>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-12">
    <button class="good">
        
    <img src="<%=request.getContextPath()%>/res/images/getmission/good.jpg"  class="slickButton3">    
    </button>                


                </div>
            </div>
        </div>



        <form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name="getmission">
            <button class="btn btn-info" type="submit" name="action" value="missionindex">任務首頁</button>
        </form>
        <jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>
        <script type="text/javascript">
        $(document).ready(function(){    
                var i =0;
        $('.good').click(function(){
                i++;
				console.log(i);
            });
        });
        </script>
</body>

</html>