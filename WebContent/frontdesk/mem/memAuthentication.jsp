<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>工具人出租</title>
</head>
<body>


<!-- navbar====================================================================== -->


<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"></jsp:include>

<br><br><br><br><br><br><br>
<!-- navbar====================================================================== -->




<!-- 麵包屑 -->

<div class="row">
 <div class="col-xs-12 col-sm-10">
	<ol class="breadcrumb">
	<li>
		<a href="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">首頁</a>
	</li>
	<li>
		<a href="<%=request.getContextPath()%>/frontdesk/mem/memCenter.jsp">會員中心</a>
	</li>
	<li>
		<a href="<%=request.getContextPath()%>/frontdesk/mem/memAuthentication.jsp">會員驗證</a>
	</li>
	<!-- <li class="active">媽我上電視了</li> -->
	</ol>
</div>
</div>


<!-- 註冊表單====================================================================== -->


<%-- 錯誤處理 --%>

<c:if test="${not empty errorMsgs}">
	<font style="color:#da0">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:#00f">${message}</li>
		</c:forEach>
	</ul>
</c:if>





<!-- memPageLeft====================================================================== -->



<jsp:include page="/frontdesk/mem/memPageLeft.jsp" flush="true"></jsp:include>

<!-- memPageLeft====================================================================== -->






<!-- memPageRight====================================================================== -->

 <form id="login-form" method="post" action="<%=request.getContextPath()%>/mem/mem.do">
<div class="col-xs-12 col-sm-9">
     <h2 align="center">請輸入會員驗證碼<p></p>
        <div class="row">
			<div class="col-xs-6 col-sm-6 col-md-6 col-xs-offset-3">
			<div class="form-group">
				<input type="text" name="mem_UserCode">
			</div>
			
			<div>
        <input type="hidden" name="action" value="memAuthentication"><p></p>
        <button type="submit"  class="btn btn-success btn-block btn-lg" tabindex="7">送出</button></h2>
        </div>
        	</div>
          </div>
</div>
</form>

</div>
</div>

<!-- memPageRight====================================================================== -->



<!-- footer====================================================================== -->
<br><br><br><br><br><br><br><br><br><br><br><br><br><br>


<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>


<!-- footer====================================================================== -->



</body>
</html>