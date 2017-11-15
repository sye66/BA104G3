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
<meta HTTP-EQUIV="refresh" CONTENT="5;URL=http://localhost:8081/BA104G3_2017_10_31/mem/index.jsp">

<link href="<%=request.getContextPath()%>/lib/publicfile/sweetalert-master/src/sweetalert.css" rel="stylesheet">
<script src="<%=request.getContextPath()%>/lib/publicfile/sweetalert-master/src/sweetalert.js"></script> 

<title>Insert title here</title>
</head>
<body onload="initial();">
		
<c:if test="${not empty errorMsgs}">
	
	<font style="color:#da0">請修正以下錯誤:</font>
	<ul><h1>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:#00f">${message}</li>
		</c:forEach>
	</h1></ul>
</c:if>

<script type="text/javascript">
swal("这是一条信息！");
</script>
<h1>五秒後重回首頁</h1>




<p>倒數時間:</p>
<div id="countdown"></div>

</body>


<script type="text/javascript">
var countdownnumber=5;
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