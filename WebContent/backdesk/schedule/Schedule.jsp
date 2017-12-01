<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%Integer count = 1;%>
<%Integer count2 = 1;%>
<%Integer count3 = 1;%>
<%Integer count4 = 1;%>
<%Integer count5 = 1;%>
<%Integer count6 = 1;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/arti_back_style.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

	<style>
	  table#table-1 {
    box-shadow: 0 17px 50px 0 rgba(0, 0, 0, 0.01), 0 12px 15px 0 rgba(0, 0, 0, 0.1), 0 0px 50px 0   #8A5CB8, 0 12px 15px 0   #5C5CB8;
    border-radius: 20px;
    text-align: center;
    width: 80%;
    height: 60px;
    padding-top: 30px;
    color: #4cae4c;
    margin : 20px;
    margin-left : 20px;
  }
  
  h3{
    width: 80%;
    height: 25px;  
    margin : 20px;
  }
  
  body{margin:40px;}
	</style>

</head>
<body bgcolor='white'>
<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="ScheduleBackLeft.jsp" flush="true" />
	
	
	<div class="col-xs-12 col-sm-8 col-sm-offset-1">
		<br>
		<nav aria-label="breadcrumb" role="navigation">
  		<ol class="breadcrumb">
    		<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/backdesk/backdesk.jsp">首頁</a></li>
    		
    		<li class="breadcrumb-item active" aria-current="page">排程管理</li>
  		</ol>
	</nav>
	</div>
	
<div align="center">
	<table id="table-1">
   <tr><td><h3>IBM Schedule: Home</h3><h4>( MVC )</h4></td></tr>
</table>
	
	<c:if test="${not empty errorMsgs}">
	<font style="color:red"></font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
	
	<div class="container">
	<div class="row">
		<div class="col-xs-12 col-sm-6">
			<div role="tabpanel">
		    <!-- 標籤面板：標籤區 -->
		    <ul class="nav nav-tabs" role="tablist">
		        <li role="presentation" class="active">
		            <a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">任務數量獎勵</a>
		        </li>
<!-- 		        <li role="presentation"> -->
<!-- 		            <a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">數量月發獎勵</a> -->
<!-- 		        </li> -->
<!-- 		        <li role="presentation"> -->
<!-- 		            <a href="#tab3" aria-controls="tab3" role="tab" data-toggle="tab">數量季發獎勵</a> -->
<!-- 		        </li> -->
		    </ul>
		
		    <!-- 標籤面板：內容區 -->
			
		    <div class="tab-content">
		    
		        <div role="tabpanel" class="tab-pane active" id="tab1">
		        <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/rank/rank.do" >
		        	<%for(int i=0;i<10;i++){%>
		        		第<%=count++%>名&nbsp;&nbsp;
						        請頒發獎勵點數(任務數量組)&nbsp;&nbsp;<input type="text" name="rewarda" size="5px">&nbsp;點   
		        		<br>
		        	<%}%>
		        	<input type="submit" value="獎勵囉!" class="btn btn-info">
					<input type="hidden" name="action" value="payReward">
					</FORM>
		        </div>
		         
		         
<!-- 		        <div role="tabpanel" class="tab-pane" id="tab2"> -->
<%-- 		        <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/rank/rank.do" > --%>
<%-- 		        	<%for(int i=0;i<10;i++){%> --%>
<%-- 		        		第<%=count2++%>名&nbsp;&nbsp; --%>
<!-- 						        請頒發一月數量獎勵點數&nbsp;&nbsp;<input type="text" name="rewardb" size="5px">&nbsp;點    -->
<!-- 		        		<br> -->
<%-- 		        	<%}%> --%>
<!-- 		        	<input type="submit" value="獎勵囉!" class="btn btn-info"> -->
<!-- 					<input type="hidden" name="action" value="payReward2"> -->
<!-- 					</FORM> -->
<!-- 		        </div> -->
		        
		        
<!-- 		        <div role="tabpanel" class="tab-pane" id="tab3"> -->
<%-- 		        <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/rank/rank.do" > --%>
<%-- 		        	<%for(int i=0;i<10;i++){%> --%>
<%-- 		        		第<%=count3++%>名&nbsp;&nbsp; --%>
<!-- 						        請頒發一季數量獎勵點數&nbsp;&nbsp;<input type="text" name="rewardc" size="5px">&nbsp;點    -->
<!-- 		        		<br> -->
<%-- 		        	<%}%> --%>
		        	
<!-- 		        	<input type="submit" value="獎勵囉!" class="btn btn-info"> -->
<!-- 					<input type="hidden" name="action" value="payReward3"> -->
<!-- 					</FORM> -->
<!-- 		        </div> -->
		        
		    </div>
		   
		</div>
		</div>
		<div class="col-xs-12 col-sm-6">
			<div role="tabpanel">
		    <!-- 標籤面板：標籤區 -->
		    <ul class="nav nav-tabs" role="tablist">
		        <li role="presentation" class="active">
		            <a href="#tab4" aria-controls="tab1" role="tab" data-toggle="tab">積分獎勵</a>
		        </li>
<!-- 		        <li role="presentation"> -->
<!-- 		            <a href="#tab5" aria-controls="tab2" role="tab" data-toggle="tab">積分月發獎勵</a> -->
<!-- 		        </li> -->
<!-- 		        <li role="presentation"> -->
<!-- 		            <a href="#tab6" aria-controls="tab3" role="tab" data-toggle="tab">積分季發獎勵</a> -->
<!-- 		        </li> -->
		    </ul>
		
		    <!-- 標籤面板：內容區 -->
		    
		    <div class="tab-content">
		        <div role="tabpanel" class="tab-pane active" id="tab4">
		        <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/rank/rank.do" >
		        	<%for(int i=0;i<10;i++){%>
		        		第<%=count4++%>名&nbsp;&nbsp;
						        請頒發獎勵點數(積分組)&nbsp;&nbsp;<input type="text" name="rewardd" size="5px">&nbsp;點   
		        		<br>
		        	<%}%>
		        	
		        	<input type="submit" value="獎勵囉!" class="btn btn-info">
					<input type="hidden" name="action" value="payReward4">
					</FORM>
		        </div>
<!-- 		        <div role="tabpanel" class="tab-pane" id="tab5"> -->
<%-- 		        <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/rank/rank.do" > --%>
<%-- 		        	<%for(int i=0;i<10;i++){%> --%>
<%-- 		        		第<%=count5++%>名&nbsp;&nbsp; --%>
<!-- 						        請頒發一月積分獎勵點數&nbsp;&nbsp;<input type="text" name="rewarde" size="5px">&nbsp;點    -->
<!-- 		        		<br> -->
<%-- 		        	<%}%> --%>
		        	
<!-- 		        	<input type="submit" value="獎勵囉!" class="btn btn-info"> -->
<!-- 					<input type="hidden" name="action" value="payReward5"> -->
<!-- 				</FORM>	 -->
<!-- 		        </div> -->
<!-- 		        <div role="tabpanel" class="tab-pane" id="tab6"> -->
<%-- 		         <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/rank/rank.do" > --%>
<%-- 		        	<%for(int i=0;i<10;i++){%> --%>
<%-- 		        		第<%=count6++%>名&nbsp;&nbsp; --%>
<!-- 						        請頒發一季積分獎勵點數&nbsp;&nbsp;<input type="text" name="rewardf" size="5px">&nbsp;點    -->
<!-- 		        		<br> -->
<%-- 		        	<%}%> --%>
		        	
<!-- 		        	<input type="submit" value="獎勵囉!" class="btn btn-info"> -->
<!-- 					<input type="hidden" name="action" value="payReward6"> -->
<!-- 				</FORM>		 -->
<!-- 		        </div> -->
		    </div>
		    
		</div>
		</div>
	</div>
	</div>
	
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
</body>
</div>
</html>