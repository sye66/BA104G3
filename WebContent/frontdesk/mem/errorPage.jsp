<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta HTTP-EQUIV="refresh" CONTENT="3;URL=<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">

<link href="<%=request.getContextPath()%>/lib/publicfile/sweetalert-master/src/sweetalert.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/lib/publicfile/sweetalert-master/src/sweetalert.js"></script> 
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
 <style type="text/css">
	        body {
	            background-image: url(<%=request.getContextPath()%>/res/images/mem/memCenter/wrong.jpg);
	            background-repeat: no-repeat;
	            background-attachment: fixed;
	            background-position: center;
	            background-size: cover;
	            font-family: Microsoft JhengHei;
	        }
	       	label,p {
	       	color: white;
	       }
	       #map {
	        height: 300px;
	        width: 100%;
	       }
	    </style>
<title>Insert title here</title>
</head>
<body onload="initial();">
	
	<div style="margin-left:400px">	
<c:if test="${not empty errorMsgs}">
	
	<font style="color:#da0">請修正以下錯誤:</font>
	<h1>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:#00f">${message}</li>
		</c:forEach>
	</h1>
</c:if>

<script type="text/javascript">
swal("这是一条信息！");
</script>


<div>
<h1 style="color:#3F3">三秒後重回首頁</h1>




<p>倒數時間:</p>
<h2 style="color:#3F3"><div id="countdown"></div></h2>
</div>
</div>

 <form id="login-form" method="post" action="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">
                    	<div>
                    		<input type="hidden" name="action" value="register">
                    		<div style="text-align:center"><span style="font-size:24px;">3秒之後自動跳轉到首頁</span> <button type="submit" class="btn btn-success btn-lg btn-block">按我直接回首頁</button></div>
                    	</div>
                    </form>
</body>


<script type="text/javascript">
var countdownnumber=3;
var countdownid;
function initial(){ countdownfunc(); }
function countdownfunc(){
 var x=document.getElementById("countdown");
 x.innerHTML=countdownnumber;
 if (countdownnumber==0){
	
//   alert("倒數結束");
  clearTimeout(countdownid);
 
 }else{
  countdownnumber--;
  if(countdownid){
   clearTimeout(countdownid);
  }
  countdownid=setTimeout(countdownfunc,1000);
 }
}
 </script>
<script type="text/javascript">
 document.querySelector('.sweet-1').onclick = function(){
        swal("Here's a message!");
      };
      </script>



</html>