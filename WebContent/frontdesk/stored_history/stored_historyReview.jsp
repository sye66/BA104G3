<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.stored_history.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); %>
<%-- <% StoredVO storedVO = (StoredVO)request.getSession().getAttribute("storedVO"); %> --%>
<% request.getAttribute("success"); %>
<%  StoredService storedSvc = new  StoredService();
  	String mem_No = memVO.getMem_No();
    List<StoredVO> list = storedSvc.getAll(mem_No);
    System.out.print(list.size());
    pageContext.setAttribute("list", list);
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>工具人出租</title>


<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 3px solid 	#00BFFF;
  }
  b,tr, th, td {
  	font-size: 20px;
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body>


<!-- navbar====================================================================== -->


<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"></jsp:include>

<br><br><br><br><br><br><br>
<!-- navbar====================================================================== -->


	
<!-- 麵包屑 -->

<div class="row">
 <div class="col-xs-10 col-sm-10 col-xs-offset-1" >
<ol class="breadcrumb">
	<li>
		<a href="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">首頁</a>
	</li>
	<li>
		<a href="<%=request.getContextPath()%>/frontdesk/mem/register.jsp">註冊</a>
	</li>
	<!-- <li class="active">媽我上電視了</li> -->
</ol>
</div>
</div>




<%-- 錯誤處理 --%>

<c:if test="${not empty errorMsgs}">
	<font style="color:#da0">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:#00f">${message}</li>
		</c:forEach>
	</ul>
</c:if>

	
<!-- navbar====================================================================== -->


<jsp:include page="/frontdesk/mem/memPageLeft.jsp" flush="true"></jsp:include>

<br><br><br><br><br><br><br>
<!-- navbar====================================================================== -->
			



    <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-1">

<%-- <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/stored_history/stored_history.do" name="form1"> --%>
			
			<input type="hidden" id="success" name="success" value="${success}">
            <input type="hidden" name="mem_No" size="36" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_No()%>" />
			
			
			
		<table>
		
		
		<tr align="center">
		<th>儲值時間</th>
		<th>儲值金額</th>
		<th>儲值方式</th>
		</tr>
			
		<%@ include file="/frontdesk/stored_history/page1.file" %>　<br><br><h2><font>目前持有積分：${memVO.mem_Point} 分</font></h2>
		<c:forEach var="storedVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
			
		<tr>
			<td>${storedVO.stored_Date}</td>
			<td>${storedVO.stored_Cost}</td>
			<td>${storedVO.stored_Type}</td>
			
		</tr>	
		</c:forEach>
		</table>

<%@ include file="page2.file" %>

			

			
			
			
		</div>
	
			
	</div>
</div>		
			
			
<!-- navbar====================================================================== -->
<br><br><br><br><br><br><br>

<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>


<!-- navbar====================================================================== -->
			
			
			
			
<script>
		var successOk = "ok";
		var success = $("[name='success']").val();
		if(successOk == success){
			swal({
				  position: 'center',
				  type: 'success',
				  title: '恭喜你儲值成功 !',
				  showConfirmButton: false,
				  timer: 1500
				})
		};
</script>

</body>
</html>