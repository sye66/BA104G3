<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.follow_tool_man.model.*" %>

<jsp:useBean id="Follow_tmSvc" scope="page" class="com.follow_tool_man.model.Follow_tmService"/>
<jsp:useBean id="MemSvc" scope="page" class="com.mem.model.MemService"/>


<% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); 
   MemVO memVO1 = (MemVO)request.getSession().getAttribute("memVO");
   
%>
<%request.getAttribute("updateSuccess");%>
        


<%
Follow_tmService follow_tmSvc = new Follow_tmService();

 String follower_Mem_No = request.getParameter("follow_tmVO");
if(follower_Mem_No ==null){
	follower_Mem_No= memVO.getMem_No();
	System.out.println("follower_Mem_No + " +follower_Mem_No);
}
 
List<Follow_tmVO> follow_tmVO = follow_tmSvc.getAllDependOnFollower_Mem_No(follower_Mem_No);
pageContext.setAttribute("follow_tmVO", follow_tmVO);

System.out.println("follow_tmVO + " +follow_tmVO);
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/login_mem.css">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/index/index.css">
<title>Insert title here</title>
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
  #img_pic,#old_pic{
	max-width:150px;
	max-height:150px;}
  
  
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
		<c:forEach var="follow_tmVO" items="${follow_tmVO}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/follow_tool_man/follow_tool_man.do?reuestURL=<%=request.getServletPath()%>" name="form1">	
		<tr>
			<c:if test="${follow_tmVO.getFollow_Status()==0}">
			<c:if test="${follow_tmVO.followed_Mem_No != memVO.mem_No and follow_tmVO.follower_Mem_No !=memVO.mem_No}">
			<td>
			<div class="form-group">
			<a href="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${MemSvc.getOneMem(follow_tmVO.followed_Mem_No).mem_No}"><img id="old_pic"src="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${MemSvc.getOneMem(follow_tmVO.followed_Mem_No).mem_No}"></a>
			</div>
			</td>
			<td>${MemSvc.getOneMem(follow_tmVO.followed_Mem_No).mem_Name}</td>
			<c:if test="${MemSvc.getOneMem(follow_tmVO.followed_Mem_No).mem_Gend ==1}">
			<td>男性</td>
			</c:if>
			<c:if test="${MemSvc.getOneMem(follow_tmVO.followed_Mem_No).mem_Gend ==2}">
			<td>女性</td>
			</c:if>
			<td>
			<input type="hidden" name="action" value="update">
			${MemSvc.getOneMem(follow_tmVO.followed_Mem_No).mission_Count}</td>
				</h2></c:if></c:if>
			
			   
        	<input type="hidden" id="updateSuccess" value="${updateSuccess}"/>
        
        	<input type="hidden" name="follower_Mem_No" value="${follow_tmVO.follower_Mem_No}">
        	<input type="hidden" name="followed_Mem_No" value="<%= (follow_tmVO==null)? "" : memVO.getMem_No()%>">
			<input type="hidden" name="follow_Status" value=1 >
			
			
			
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