<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
 
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
    
    //可以直接在EL前面加上 sdf.format(值)，設定自己要的時間格式字串
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
    pageContext.setAttribute("sdf", sdf);
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
 <div class="col-xs-12 col-sm-8 col-sm-offset-2">
<ol class="breadcrumb">
	<li>
		<a href="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">首頁</a>
	</li>
	<li>
		<a href="<%=request.getContextPath()%>/frontdesk/mem/register.jsp">儲值</a>
	</li>
	<li>
		<a href="<%=request.getContextPath()%>/frontdesk/stored_history/stored_historyReview.jsp">儲值歷史紀錄</a>
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
                    <div id="eee" class="panel-collapse collapse" role="tabpanel" aria-labelledby="panel5">
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
                    <div id="bbb" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="panel2">
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
				<div><h3><a style="text-decoration:none;" href="<%=request.getContextPath()%>/frontdesk/pro/cart.jsp">
				<img style="width:60px; height:60px;"alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/cart01.gif">點我回商城</a></h3></div>
		<c:forEach var="storedVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
			
		<tr>
			<td>${sdf.format(storedVO.stored_Date)}</td>
			<td>${storedVO.stored_Cost}</td>
		<c:if test="${storedVO.stored_Type ==1}">
			<td>點數卡</td>
		</c:if>
		<c:if test="${storedVO.stored_Type ==2}">
			<td>信用卡</td>
		</c:if>
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