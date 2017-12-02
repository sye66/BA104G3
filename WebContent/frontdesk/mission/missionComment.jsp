<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.getmission.model.*"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="getMissionSvc" scope="page"
	class="com.getmission.model.GetMissionService" />



<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<%
	GetMissionVO getMissionVO = (GetMissionVO) request.getAttribute("getMissionVO");

%>

<!DOCTYPE html>
<html lang="">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
<title>missionComment</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/lib/css/getmission/star.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">

<link rel='stylesheet prefetch' href='http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css'>

    
</head>
<body>


<%@ include file="/lib/publicfile/include/file/navbar.jsp"%>

	<br><br><br><br><br>
	<br><br><br>

<div class="container">
    <div class="row">
    <div class="col-xs-12 col-sm-12">
<section class='rating-widget'>
  <form METHOD="post" ACTION="<%=request.getContextPath()%>/missioncomment/missioncomment.do"">
  <!-- Rating Stars Box -->
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">任務評價</h3>
    </div>
    <div class="panel-body">
     <p>對於這次的任務 <b>${getMissionVO.mission_Name}</b> 還有 <b>合作方</b> 給予評價吧~.</p>
    </div>
    <table class="table">
      <tr>
        <td>
          <div class='rating-stars text-center' >
    <ul id='stars' >
      <li class='star' title='Poor' data-value='1' name="comment_Point" value="1">
        <i class='fa fa-star fa-fw'></i>
      </li>
      <li class='star' title='Fair' data-value='2' name="comment_Point" value="2">
        <i class='fa fa-star fa-fw'></i>
      </li>
      <li class='star' title='Good' data-value='3' name="comment_Point" value="3">
        <i class='fa fa-star fa-fw'></i>
      </li>
      <li class='star' title='Excellent' data-value='4' name="comment_Point" value="4">
        <i class='fa fa-star fa-fw'></i>
      </li>
      <li class='star' title='WOW!!!' data-value='5' name="comment_Point" value="5">
        <i class='fa fa-star fa-fw'></i>
      </li>
    </ul>
  </div> 
        </td>
<td>
          <button class="btn btn-warning" type="submit" name="action" value="givecomment">發出評論</button>
 <input type="hidden" name="mission_No" value="${getMissionVO.mission_No}">
 <c:if test="${getMissionVO.mission_No.issuer_Mem_No.equals(memVO.mem_No)}" var="reviewer"> 
 <input type="hidden" name="listener" value="${memVO.mem_No}">
 </c:if>
 <c:if test="${!reviewer}">
 <input type="hidden" name="listener" value="${getMissionVO.mission_No.takecase_Mem_No}">
 </c:if>
 <input type="hidden" name="requestURL" value="/frontdesk/mission/missionComment.jsp">
       </td>
        
        <tr>
        <td>
          <div class="col-xs-12 col-sm-12 col-sm-offset-5">
  <textarea class="smallInput center fuild" ROWS="5"   COLS="20" name="comment_Detial"></textarea>
          </div>
        </td>
        </tr>
       
      </tr>
    </table>
  </div>
								                
  </form>
</section>

</div>
</div>
    </div>
<form method="post" action="<%=request.getContextPath()%>/getmission/getmission.do" name= "getmission">
	
<button class="btn btn-info" type="submit" name="action" value="missionindex">任務首頁</button>

</form>





 <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="<%=request.getContextPath()%>/lib/js/getmission/star.js"></script>

 
<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include></div>

</body>
</html>