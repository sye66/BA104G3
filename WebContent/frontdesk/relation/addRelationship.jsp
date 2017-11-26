<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.relation.model.*" %>


<jsp:useBean id="RelationSvc" scope="page" class="com.relation.model.RelationService"/>
<jsp:useBean id="MemSvc" scope="page" class="com.mem.model.MemService"/>
<% RelationVO relationVO = (RelationVO)request.getSession().getAttribute("relationVO"); %>
<% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); %>
<%request.getAttribute("updateSuccess");%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/login_mem.css">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/index/index.css">
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


<div class="col-xs-12 col-sm-9">
    <form id="login-form" method="post" action="<%=request.getContextPath()%>/relation/relation.do?">
        <div>
        <h2>
        <input type="hidden" name="action" value="insert_New">
        <input type="hidden" id="updateSuccess" value="${updateSuccess}"/>
        
        <input type="hidden" name="mem_No" value="<%= (relationVO==null)? "" : relationVO.getMem_No()%>">
      
        <input type="hidden" name="related_Mem_No" value="<%= (relationVO==null)? "" : relationVO.getRelated_Mem_No()%>">
        
        <c:if test="${relationVO.relation_Status == null}">
        <a class="nav-link js-scroll-trigger" href="#">
        <img alt="" src="<%=request.getContextPath()%>/res/images/relation/icon/bluelike.png"></a>
        </c:if>
        <c:if test="${relationVO.relation_Status == 1}">
        <a class="nav-link js-scroll-trigger" href="#">
        <img alt="" src="<%=request.getContextPath()%>/res/images/relation/icon/greenlike.png"></a>
        </c:if>
        <c:if test="${relationVO.relation_Status == 2}">
        <a class="nav-link js-scroll-trigger" href="#">
        <img alt="" src="<%=request.getContextPath()%>/res/images/relation/icon/purplelike.png"></a>
        </c:if>
        <c:if test="${relationVO.relation_Status == 3}">
        <a class="nav-link js-scroll-trigger" href="#">
        <img alt="" src="<%=request.getContextPath()%>/res/images/relation/icon/redlike.png"></a>
        </c:if>
        <c:if test="${relationVO.relation_Status == 4}">
        <a class="nav-link js-scroll-trigger" href="#">
        <img alt="" src="<%=request.getContextPath()%>/res/images/relation/icon/blacklike.png"></a>
        </c:if>
        <div class="form-group">互動關係
			<select size="1" name="relation_Status" id="estadocivil" class="form-control input-lg" tabindex="3">${relationVO.relation_Status}
			<option value="1" selected>點頭之交</option>
			<option value="2">普通朋友</option>
			<option value="3">摯友</option>
			<option value="4">黑名單</option>
			</select>
		</div>
        <button value="text" type="submit"  class="btn btn-success btn-block btn-lg" tabindex="7">送出</button></h2>
        
        </div>
        </form>
        </div>
    
        </div>
</div>
</div>

<!-- memPageLeft====================================================================== -->




<!-- footer====================================================================== -->
<br><br><br><br><br><br><br><br><br><br><br><br><br><br>


<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>


<!-- footer====================================================================== -->



</body>




<script>	
		var updateOk = "ok";
		var updateSuccess = $('#updateSuccess').val();
		if(updateOk == updateSuccess){
			swal({
				  position: 'top-right',
				  type: 'success',
				  title: '恭喜你修改成功 !',
				  showConfirmButton: false,
				  timer: 1500
				})
		};
		
		
		
</script>



</html>