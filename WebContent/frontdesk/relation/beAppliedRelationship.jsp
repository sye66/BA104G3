<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.relation.model.*" %>


        


<% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); %>
<%request.getAttribute("updateSuccess");%>
<%
RelationService relationSvc = new RelationService();

 String related_Mem_No = request.getParameter("relationVO");
if(related_Mem_No ==null){
	
	related_Mem_No= memVO.getMem_No();
}
 System.out.print(memVO.getMem_No());
List<RelationVO> list = relationSvc.getWhoAddme(related_Mem_No);
pageContext.setAttribute("list", list);
System.out.print(list.size());

%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/login_mem.css">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/index/index.css">
<title>Insert title here</title>
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
        <div>
       
<table>

        <h2>
        
 
		
		
		<tr align="center">
		<th>申請好友</th>
		<th>是否接受</th>
		</tr>
			
		<%@ include file="page1.file" %>
		<c:forEach var="relationVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relation/relation.do?reuestURL=<%=request.getServletPath()%>" name="form1">	
		<tr>
			<c:if test="${list.getRelation_Status()==0}">
			<td>${list.mem_No}</td>
		
			<td>
			<input type="hidden" name="action" value="update">
			<button value="text" type="submit"  class="btn btn-success btn-block btn-lg" tabindex="7">確認
			</button></h2></td>	
			</c:if>
			   
        	<input type="hidden" id="updateSuccess" value="${updateSuccess}"/>
        
        	<input type="hidden" name="mem_No" value="${list.mem_No}">
        	<input type="hidden" name="related_Mem_No" value="<%= (list==null)? "" : memVO.getMem_No()%>">">
			<input type="hidden" name="relation_Status" value=1 >
			
			
			
		</tr>
		</form>	
		</c:forEach>
		
</table>
<%@ include file="page2.file" %>
        </div>
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