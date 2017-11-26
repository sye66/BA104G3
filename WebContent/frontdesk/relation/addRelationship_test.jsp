<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.relation.model.*" %>

<jsp:useBean id="RelationSvc" scope="page" class="com.relation.model.RelationService"/>
<jsp:useBean id="MemSvc" scope="page" class="com.mem.model.MemService"/>


<% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); 
   
%>
<%request.getAttribute("updateSuccess");%>
        


<%
RelationService relationSvc = new RelationService();

 String related_Mem_No = request.getParameter("relationVO");
 if(related_Mem_No ==null){
		
		related_Mem_No= memVO.getMem_No();
	}
List<RelationVO> relationVO = relationSvc.getAllFriends(related_Mem_No);
pageContext.setAttribute("relationVO", relationVO);

String mem_No= related_Mem_No;
MemService memSvc = new MemService();
System.out.println("related_Mem_No " +related_Mem_No);
List<MemVO> memVOlist = memSvc.getAllForFriend(related_Mem_No); 
pageContext.setAttribute("memVOlist", memVOlist);
System.out.println("memVOlist " +memVOlist);
%>
<c:forEach var="memVOlist" items="${memVOlist}" >
<td>${MemSvc.getOneMem(relationVO.mem_No).mission_Count}</td>
</c:forEach>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/login_mem.css">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/index/index.css">
    <title>工具人出租</title>
</head>


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
  #img_pic,#old_pic{width:180px;
	heigth:230px}
  
</style>

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
		<th>圖片</th>
		<th>申請好友</th>
		<th>性別</th>
		<th>完成任務數</th>
		</tr>
			
		<%@ include file="page1.file" %>
		<c:forEach var="memVO" items="${memVOlist}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relation/relation.do?reuestURL=<%=request.getServletPath()%>" name="form1">	
		<tr>
			<c:if test="${relationSvc.getWhoAddme(mem_No).relation_Status==0}">
			<c:if test="${relationSvc.getWhoAddme(relationVO.mem_No).relationVO.related_Mem_No != memVO.mem_No and relationSvc.getWhoAddme(relationVO.mem_No).mem_No !=memVO.mem_No}">
			<td><% System.out.println("memVOlist  " + memVOlist);%>
			<div class="form-group">
			<img id="old_pic"src="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${MemSvc.getOneMem(relationVO.mem_No).mem_No}">
			</div>
			</td>
			<td>${MemSvc.getOneMem(relationVO.mem_No).mem_Name}</td>
			<c:if test="${MemSvc.getOneMem(relationVO.mem_No).mem_Gend ==1}">
			<td>男性</td>
			</c:if>
			<c:if test="${MemSvc.getOneMem(relationVO.mem_No).mem_Gend ==2}">
			<td>女性</td>
			</c:if>
			<td>
			<input type="hidden" name="action" value="update">
			${MemSvc.getOneMem(relationVO.mem_No).mission_Count}</td>
				</h2></c:if></c:if>
			
			   
        	<input type="hidden" id="updateSuccess" value="${updateSuccess}"/>
        
        	<input type="hidden" name="mem_No" value="${relationSvc.getWhoAddme(relationVO.mem_No).mem_No}">
        	<input type="hidden" name="related_Mem_No" value="<%= (relationVO==null)? "" : memVO.getMem_No()%>">
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

		function previewFile() {
				 var preview = document.querySelector('#img_pic');
				 var file    = document.querySelector('input[type=file]').files[0];
				 var reader  = new FileReader();
		
				  reader.addEventListener("load", function () {
				  preview.src = reader.result;
					 }, false);
				 if (file) {
					 reader.readAsDataURL(file);
				 }
}








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