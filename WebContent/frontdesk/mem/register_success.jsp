<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
    
    
    <% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); %>
      <%request.getSession().setAttribute("memVO" ,memVO); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<span style="font-size:18px;"> </span><span style="font-size:24px;"><meta http-equiv="refresh" content="3;URL=<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp"> </span> 

<title>
	<c:if test="${memVO.mem_State == 0}">恭喜'註冊'成功 ! </c:if>
	<c:if test="${memVO.mem_State == 1}">恭喜'認證'成功 ! </c:if>
</title>
<style>
img #show {heigth:100%}
</style>
<script src="<%=request.getContextPath()%>/lib/publicfile/include/js/sweetalert2all.js"></script>
<link href="<%=request.getContextPath()%>/lib/publicfile/include/css/sweetalert2.css" rel="stylesheet" type="text/css" />
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

</head>
<body>
 
 
<c:if test="${memVO.mem_State == 0}">
	<script type="text/javascript">
		swal('${memVO.mem_Id}，恭喜註冊成功 ! 請至註冊信箱收信驗證')
	</script>
</c:if>


<c:if test="${memVO.mem_State == 1}">
	<script type="text/javascript">
		swal('${memVO.mem_Id}，恭喜認證成功 ! 可以正式啟用帳號')
	</script>
</c:if>





	 <form id="login-form" method="post" action="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">
                    	<div>
                    		<input type="hidden" name="action" value="register">
                    		<div style="text-align:center"><span style="font-size:24px;">3秒之後自動跳轉到首頁</span> <button type="submit" class="btn btn-success btn-lg btn-block">按我直接回首頁</button></div>
                    	</div>
                    </form>
                    
                    <div class="row">
			<div class="col-xs-12 col-sm-12"><img id="show" src="<%=request.getContextPath()%>/lib/publicfile/include/img/0.png"></div>
		</div>
                    
</body>
</html>