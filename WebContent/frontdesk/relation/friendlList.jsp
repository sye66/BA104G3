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
	System.out.println("related_Mem_No ++++ " +related_Mem_No);
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


<!-- navbar====================================================================== -->


<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"></jsp:include>

<br><br><br><br><br><br><br>
<!-- navbar====================================================================== -->




<!-- 麵包屑 -->

<div class="row">
 <div class="col-xs-12 col-sm-8 col-sm-offset-2">
	<ol class="breadcrumb">
	<li>
		<a href="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">首頁</a>
	</li>
	<li>
		<a href="<%=request.getContextPath()%>/frontdesk/mem/memCenter.jsp">會員中心</a>
	</li>
	<li>
		<a href="<%=request.getContextPath()%>/frontdesk/relation/friendlList.jsp">好友列表</a>
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



<br><br>
<div class="container">
	<div class="row">
        <div class="col-xs-12 col-sm-3">
            <div class="panel-group" id="accordion2" role="tablist" aria-multiselectable="true">
                <!-- 區塊1 -->
                <div class="panel panel-info">
                    <div class="panel-heading" role="tab" id="panel1">
                        <h4 class="panel-title">
			        <a id="noUnderLine" href="#aaa" data-parent="#accordion2" data-toggle="collapse" role="button" aria-expanded="true" aria-controls="aaa">
			         <h2> 會員資料管理</h2>
			        </a>
			      </h4>
                    </div>
                    <div id="aaa" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel1">
                        <div class="panel-body">
                        <c:if test="${memVO.mem_State == 0 }">
                        	<h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/mem/memAuthentication.jsp">會員驗證</a></h3>
                        </c:if>
                            <h3><a id="noUnderLine" href="<%= request.getContextPath() %>/frontdesk/mem/memUpdateFile.jsp">修改會員資料</a></h3>
                        </div>
                    </div>
                </div>
                <!-- 區塊5 -->
                <div class="panel panel-info">
                    <div class="panel-heading" role="tab" id="panel5">
                        <h4 class="panel-title">
			        <a id="noUnderLine" href="#eee" data-parent="#accordion2" data-toggle="collapse" role="button" class="collapsed" aria-expanded="false" aria-controls="eee">
			           <h2> 好友</h2>
			        </a>
			      </h4>
                    </div>
                    <div id="eee" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="panel5">
                        <div class="panel-body">
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/follow_tm/followTmList.jsp">關注工具人列表</a></h3>
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/relation/beAppliedRelationship.jsp">好友申請人</a></h3>
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/relation/friendlList.jsp">好友列表</a></h3>
                        </div>
                    </div>
                </div>
                 <!-- 區塊2 -->
                <div class="panel panel-info">
                    <div class="panel-heading" role="tab" id="panel2">
                        <h4 class="panel-title">
			        <a id="noUnderLine" href="#bbb" data-parent="#accordion2" data-toggle="collapse" role="button" class="collapsed" aria-expanded="false" aria-controls="bbb">
			           <h2> 儲值</h2>
			        </a>
			      </h4>
                    </div>
                    <div id="bbb" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel2">
                        <div class="panel-body">
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/stored_history/stored_historyRecharge_PointCard.jsp">點數卡儲值</a></h3>
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/stored_history/rechage_credit.jsp">信用卡儲值</a></h3>
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/stored_history/stored_historyReview.jsp">儲值歷史紀錄</a></h3>
                        </div>
                    </div>
                </div>
                <!-- 區塊3 -->
                <div class="panel panel-info">
                    <div class="panel-heading" role="tab" id="panel4">
                        <h4 class="panel-title">
			        <a id="noUnderLine" href="#ddd" data-parent="#accordion2" data-toggle="collapse" role="button" class="collapsed" aria-expanded="false" aria-controls="ddd">
			           <h2> 疑難困惑解答區</h2>
			        </a>
			      </h4>
                    </div>
                    <div id="ddd" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel4">
                        <div class="panel-body">
                            <h3><a id="noUnderLine" href="<%=request.getContextPath()%>/frontdesk/mem/FAQ.jsp">ＦＡＱ</a></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        
    <div class="col-xs-12 col-sm-9">
        <div>
       
<table>

        <h2>
        
 
		
		
		<tr align="center">
		<th>圖片</th>
		<th>好友姓名</th>
		<th>性別</th>
		<th>完成任務數</th>
<!-- 		<th>聊天視窗</th> -->
		<th>刪除好友</th>
		</tr>
			
		<%@ include file="page1.file" %>
		<c:forEach var="relationVO" items="${relationVO}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/relation/relation.do?reuestURL=<%=request.getServletPath()%>" name="form1">	
		<tr>
			<c:if test="${relationVO.getRelation_Status()==1}">
			<c:if test="${RelationVO.related_Mem_No != memVO.mem_No and RelationVO.mem_No !=memVO.mem_No}">
			<td>
			<div class="form-group">
			<a href="<%=request.getContextPath() %>/all/all.do?mem_No=${MemSvc.getOneMem(relationVO.mem_No).mem_No}"><img id="old_pic"src="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${MemSvc.getOneMem(relationVO.mem_No).mem_No}"></a>
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
				
				
<%-- 			<td><input type="submit" style="width:70px"  class="btn btn-success btn-sm" value="申請聊天" onclick="window.open(' <%=request.getContextPath() %>/lib/publicfile/include/file/webSocket.jsp ', 'Yahoo', config='height=500,width=550')"></td> --%>
<!-- 			   <input type="hidden" name="action" value="updateByMem"> -->
			   
			   
        	<input type="hidden" id="updateSuccess" value="${updateSuccess}"/>
        
        	<input type="hidden" name="mem_No" value="${relationVO.mem_No}">
        	<input type="hidden" name="related_Mem_No" value="<%= (relationVO==null)? "" : memVO.getMem_No()%>">
			<input type="hidden" name="relation_Status" value=1 >
			
			
			
		
		</form>	
		
		<form METHOD="post" ACTION="<%=request.getContextPath()%>/relation/relation.do?" name="form1">
			    <input type="hidden" name="mem_No" value="${relationVO.mem_No}">
	        	<input type="hidden" name="related_Mem_No" value="<%= (relationVO==null)? "" : memVO.getMem_No()%>">
				<input type="hidden" name="relation_Status" value=1 >
			<td><input style="width:50px" type="submit" class="btn btn-danger  btn-sm" value="刪除" ></td>
			    <input type="hidden" name="action" value="delete">
		</form>
		</tr>
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