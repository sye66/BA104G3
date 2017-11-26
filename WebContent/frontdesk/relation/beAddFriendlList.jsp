<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.relation.model.*" %>

<jsp:useBean id="RelationSvc" scope="page" class="com.relation.model.RelationService"/>
<jsp:useBean id="MemSvc" scope="page" class="com.mem.model.MemService"/>


<% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); 
   MemVO memVO1 = (MemVO)request.getSession().getAttribute("memVO");
   
%>
<%request.getAttribute("updateSuccess");%>
        


<%
RelationService relationSvc = new RelationService();

 String related_Mem_No = request.getParameter("relationVO");
if(related_Mem_No ==null){
	
	related_Mem_No= memVO.getMem_No();
	System.out.println("related_Mem_No + " +related_Mem_No);
}
 
List<RelationVO> relationVO = relationSvc.getAllFriends(related_Mem_No);
pageContext.setAttribute("relationVO", relationVO);
System.out.println("relationVO + " +relationVO);
%>


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
  #img_pic,#old_pic{
	max-width:150px;
	max-height:150px;}
  
  
</style>

  </head>
<body>




        
    <div class="col-xs-12 col-sm-9">
        <div>
       
<table>

        <h2>
        
 
		
		
		<tr align="center">
		<th>圖片</th>
		<th>好友姓名</th>
		<th>性別</th>
		<th>完成任務數</th>
		<th>聊天視窗</th>
		</tr>
			
		<%@ include file="page1.file" %>
		<c:forEach var="relationVO" items="${relationVO}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relation/relation.do?reuestURL=<%=request.getServletPath()%>" name="form1">	
		<tr>
			<c:if test="${relationVO.getRelation_Status()==1}">
			<c:if test="${RelationVO.related_Mem_No != memVO.mem_No and RelationVO.mem_No !=memVO.mem_No}">
			<td>
			<div class="form-group">
			<a href="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${MemSvc.getOneMem(relationVO.mem_No).mem_No}"><img id="old_pic"src="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${MemSvc.getOneMem(relationVO.mem_No).mem_No}"></a>
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
				
				
			<td><input type="subbmit" class="btn btn-success btn-block btn-lg" value="申請聊天" onclick="window.open(' <%=request.getContextPath() %>/lib/publicfile/include/file/webSocket.jsp ', 'Yahoo', config='height=500,width=550')"></td>
<!-- 			   <input type="hidden" name="action" value="updateByMem"> -->
			   
			   
        	<input type="hidden" id="updateSuccess" value="${updateSuccess}"/>
        
        	<input type="hidden" name="mem_No" value="${relationVO.mem_No}">
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