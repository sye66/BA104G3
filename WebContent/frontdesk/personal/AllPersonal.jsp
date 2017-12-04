<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>
    <%@ page import="com.mem.model.*"%>
    <%@ page import="com.rank.model.*"%>
    <%@ page import="com.artiForm.model.*"%>
    <%@ page import="com.relation.model.*" %>
    <%@ page import="com.follow_tool_man.model.*" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<jsp:useBean id="RelationSvc" scope="page" class="com.relation.model.RelationService"/>
<jsp:useBean id="Follow_tmSvc" scope="page" class="com.follow_tool_man.model.Follow_tmService"/>
<jsp:useBean id="MemSvc" scope="page" class="com.mem.model.MemService"/>
    <%
    	
    	MemVO AllMemVO = (MemVO)request.getAttribute("AllMemVO");
    	String personal_No = AllMemVO.getMem_No();
    	RankService rankSvc = new RankService();
    	RankVO rankVO = rankSvc.getOneRank(personal_No);
    	pageContext.setAttribute("AllMemVO", AllMemVO);
    	pageContext.setAttribute("rankVO",rankVO);
    	ArtiFormService artiSvc = new ArtiFormService();
    	Set<ArtiFormVO> set = (Set<ArtiFormVO>)artiSvc.findArtiByMemNo(personal_No);
    	pageContext.setAttribute("set", set);
    	
    	//*********************************  智群********************
    	
    	//加好友 (判定狀態1)
    	RelationVO relationVO = (RelationVO)request.getSession().getAttribute("relationVO");
    	MemVO memVO = (MemVO)request.getSession().getAttribute("memVO");
    	String mem_No= memVO.getMem_No();
    	String related_Mem_No = personal_No;
    	System.out.println("memVO.getMem_No() +" +memVO.getMem_No());
    	relationVO = RelationSvc.getOneRelationVO(mem_No, personal_No);
    	if(relationVO!= null){
    	Integer relation_Status = relationVO.getRelation_Status();
//     	relation_Status = (String) (relation_Status);
    	System.out.println("relation_Status +" +relation_Status);
    	pageContext.setAttribute("relation_Status", relation_Status);
    	}
    	
    	//加好友(判定狀態2)
    	RelationVO relationVO1 = RelationSvc.getOneRelationVO(personal_No,mem_No);
    	if(relationVO1!= null){
        	Integer relation_Status1 = relationVO1.getRelation_Status();
//         	relation_Status = (String) (relation_Status);
        	System.out.println("relation_Status1 +" +relation_Status1);
    	pageContext.setAttribute("relation_Status1", relation_Status1);
    	}
    	//關注工具人
    	
    	Follow_tmService follow_tmSvc = new Follow_tmService();
    	Follow_tmVO follow_tmVO = (Follow_tmVO)request.getSession().getAttribute("follow_tmVO");
    	String follower_Mem_No = memVO.getMem_No();
    	String followed_Mem_No = personal_No;
    	follow_tmVO =follow_tmSvc.getOneFollow_tmVO(follower_Mem_No, followed_Mem_No);
    	System.out.println("follow_tmVO +" +follow_tmVO);
    	if(follow_tmVO != null){
    		Integer follow_Status = follow_tmVO.getFollow_Status();
        	System.out.println("follow_Status +" +follow_Status);
    	}
    	
    	//*********************************  智群********************
    	
    %>
    
    
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

    
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body style="background-color : #ffc">
	<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true" />
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

<!--     	//*********************************  智群******************** -->

	<script type="text/javascript">
	
	function watch(){
	var queryString= {"action":"insert_New","follower_Mem_No":'<%=follower_Mem_No%>',"followed_Mem_No":'<%=followed_Mem_No%>',"follow_Status":'0'};
	$.ajax({
		 type: "POST",
		 url: "<%=request.getContextPath()%>/follow_tool_man/follow_tool_man.do",
		 data: queryString,
		 dataType: "json",
			
		 success: function (data){
			 var status = data.follow_Status;
			 console.log("data.follow_Status + " +status);
			 //html就是innerHTML
				$('#changeBtn').html('<button onclick="disWatch()" class="btn btn-success">已關注</button>');
		 },
		 error: function(){alert("網路不穩斷線")}
	  });
	}
	
	function disWatch(){
	var queryString= {"action":"delete","follower_Mem_No":'<%=follower_Mem_No%>',"followed_Mem_No":'<%=followed_Mem_No%>',"follow_Status":'0'};
	$.ajax({
		 type: "POST",
		 url: "<%=request.getContextPath()%>/follow_tool_man/follow_tool_man.do",
		 data: queryString,
		//如果沒有回傳值，dataType要拿掉
		 
		 success: function (data){
				$('#changeBtn').html('<button onclick="watch()" class="btn btn-warning">關注他</button>');
		 },
		 error: function(){alert("網路不穩斷線")}
	  });
	}

	function addFriend(){
		if(<%=pageContext.getAttribute("relation_Status") ==null && pageContext.getAttribute("relation_Status1") ==null%>){
		var queryString= {"action":"insert_New","mem_No":'<%=mem_No%>',"related_Mem_No":'<%=related_Mem_No%>',"relation_Status":'0'};
		}
		if(<%=pageContext.getAttribute("relation_Status1")%>==0){
		var queryString= {"action":"insert_New_Each","mem_No":'<%=mem_No%>',"related_Mem_No":'<%=related_Mem_No%>',"relation_Status":'1'};
		}
		$.ajax({
			 type: "POST",
			 url: "<%=request.getContextPath()%>/relation/relation.do",
			 data: queryString,
			 dataType: "json",
				
			 success: function (data){
				 var status = data.relation_Status;
				 //html就是innerHTML
					$('#changeBtn1').html('<button onclick="delApply()" class="btn btn-success">已申請好友</button>');
			 },
			 error: function(){alert("網路不穩")}
		  });
		}
	
	function delApply(){
		var queryString= {"action":"delete","mem_No":'<%=mem_No%>',"related_Mem_No":'<%=related_Mem_No%>',"relation_Status":'0'};
		$.ajax({
			 type: "POST",
			 url: "<%=request.getContextPath()%>/relation/relation.do",
			 data: queryString,
			//如果沒有回傳值，dataType要拿掉	
			
			 success: function (data){
					$('#changeBtn1').html('<button onclick="addFriend()" class="btn btn-warning">加為好友</button>');
			 },
			 error: function(){alert("網路不穩")}
		  });
		}
	
	</script>
    
<!--     	//*********************************  智群********************     -->

	<br>
	<br>
	<br>

	
	<div class="container">
		<div class="row">
	<div class="col-xs-12 col-sm-4">
 				<div class="panel panel-primary">
 				  <div class="panel-heading">
 				    <h3 class="panel-title">${AllMemVO.mem_Name}的個人小檔案
 				    	<div class="btn-group" style="float:right">
 				    	<p id=changeBtn>
 				    	    <c:if test="<%=follow_tmVO==null%>">
 				    	    <button onclick="watch()" class="btn btn-warning">關注他</button> 
 				    	    </c:if>
 				    	    <c:if test="<%=follow_tmVO!=null%>">
 				    	    <button onclick="disWatch()" class="btn btn-success">已關注</button>
 				    	    </c:if>
 				    	</p>
 				    	<p id=changeBtn1>
 				            <c:if test="<%=relationVO==null%>">
 				    		<button onclick="addFriend()" class="btn btn-warning">加為好友</button>
 				    		</c:if>
 				    		<c:if test="<%=relationVO!=null%>">
 				    		<button onclick="delApply()" class="btn btn-success">已申請好友</button>
 				    		</c:if>
 				    	</p>
 				    	</div>
 				    	</h3>
 				  </div>
 				    		
 				  <div class="panel-body">
 				    <table class="table table-hover">
 				    	<tr>
 				    		<td>
 				    			<img id="img" weight="150" height="150" src="<%=request.getContextPath() %>/personalShowPic/personalShowPic.do?mem_No=${AllMemVO.mem_No}">
 				    		</td>
 				    	</tr>
 				    	<tr>
 				    		<td>
 				    			${AllMemVO.mem_Intro}
 				    		</td>
 				    	</tr>
 				    </table>				
 				  </div>
 				</div>
 			</div>
 			<div class="col-xs-12 col-sm-4">
 				<div class="panel panel-primary">
 				  <div class="panel-heading">
 				    <h3 class="panel-title">${AllMemVO.mem_Name}的個人排行</h3>
 				  </div>
 				  <div class="panel-body">
 				    <table class="table table-hover">
 				    	<thead>
					    		<tr>
					    			<img src="<%=request.getContextPath()%>/frontdesk/personal/image/good.png">
					    		</tr>
					    		<tr>
					    			
					    			<th>單日數量排行</th>
					    			<th>單日積分排行</th>
					    		</tr>
					    	</thead>
					    	<tbody>
					    		<tr>
					    			<td>${rankVO.day_Number_Rank}</td>
					    			<td>${rankVO.day_Score_Rank}</td>
					    		</tr>
					    	</tbody>
 				    </table>				
 				  </div>
 				</div>
 			</div>
 			<div class="col-xs-12 col-sm-4">
 				<div class="panel panel-primary">
 				  <div class="panel-heading">
 				    <h3 class="panel-title">${AllMemVO.mem_Name}發表的文章</h3>
 				  </div>
 				  <div class="panel-body">
 				    <table class="table table-hover">
					    	<c:forEach var="artiFormVO" items="${set}">
					    		<tr>
					    			<td>${AllMemVO.mem_Name}發表了《${artiFormVO.arti_No}》這篇文章</td>
					    		</tr>
					    		<tr>
					    			<td>有${artiFormVO.arti_Like}個人說${AllMemVO.mem_Name}的文章讚!</td>
					    		</tr>
					    	</c:forEach>
 				    </table>				
 				  </div>
 				</div>
 			</div>
 		</div>
 	</div>	
	<br>
	<br>
	<br>
	<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />

</body>
</html>