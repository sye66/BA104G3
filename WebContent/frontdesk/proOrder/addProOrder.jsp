<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.proorder.model.*"%>

<%@ page import="com.mem.model.*"%>

<%
  MemVO memVO = (MemVO) session.getAttribute("memVO");		
  ProOrderVO proOrderVO = (ProOrderVO) request.getAttribute("ProOrderVO");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=BIG5">
<title>訂單</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>



</head>
<body>
	<!-- TOP -->
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/proNavbar.jsp" flush="true"/> 
</div>
<!-- 商城TOP -->
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/selectProTOP.jsp" flush="true" />	
</div>
<div class="col-xs-12 col-sm-6 col-sm-offset-3">
		<nav aria-label="breadcrumb" role="navigation">
  			<ol class="breadcrumb">
    			<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">首頁</a></li>
    			<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp">積分商城</a></li>
  				<li class="breadcrumb-item active">購物車</li>
  			
  			</ol>
		</nav>
</div>
	
<div class="col-xs-12 col-sm-3 col-sm-offset-3">
 
        <h3>新增訂單:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/proOrderServlet.do" name="form1">
<table>
	
	
	<tr>
		<td>總價:${totalPrice} </td>
		
	</tr>
	
</table>
<br>
			<div class="form-group"><h3>姓名</h3>
            <input type="TEXT" name="mem_Name" size="36" placeholder="請輸入中文或英文姓名" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Name()%>" />
    		</div>
									
			<div class="form-group"><h3>市話號碼</h3>
            <input type="TEXT" name="mem_Tel" size="36" placeholder="EX:03-3345678" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Tel()%>" />
			</div>
			
			<div class="form-group"><h3>手機號碼</h3>
            <input type="TEXT" name="mem_Pho" size="36" placeholder="EX:0978-978978" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Pho()%>" />
			
			</div>
			
			
<%----------------地址 -------------------------------------------%>



			<div class="form-group"><h3>通訊地址</h3>
            <input type="TEXT" name="mem_Address" size="36" placeholder="XXX路XXX巷XX弄XX號" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Address()%>" />
			
			</div>
			
<%----------------地址 -------------------------------------------%>
			
			
			<button type="submit" class="btn btn-success" style="font-size:26px;">確認送出訂單</button>
			<input type="hidden" name="mem_No" value="<%=memVO.getMem_No()%>">
			
	</FORM>		
			
</div>		
			

   


	
</body>
</html>