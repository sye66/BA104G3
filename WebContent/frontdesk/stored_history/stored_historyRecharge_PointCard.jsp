<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*" %>
<%-- <%@ page import="java.util.*" %> --%>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.stored_history.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); %>
<% StoredVO storedVO = (StoredVO)request.getSession().getAttribute("storedVO"); %>
<% request.getAttribute("success"); %>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>


<!-- navbar====================================================================== -->


<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"></jsp:include>

<br><br><br><br><br><br><br>
<!-- navbar====================================================================== -->


	
<!-- 麵包屑 -->

<div class="row">
 <div class="col-xs-10 col-sm-10 col-xs-offset-1" >
<ol class="breadcrumb">
	<li>
		<a href="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">首頁</a>
	</li>
	<li>
		<a href="<%=request.getContextPath()%>/frontdesk/mem/register.jsp">註冊</a>
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


<jsp:include page="/frontdesk/mem/memPageLeft.jsp" flush="true"></jsp:include>

<br><br><br><br><br><br><br>
<!-- navbar====================================================================== -->
		<script type="text/javascript">	
	$('#City').change(function(){
		var cityname = $('select#City option:selected').text();
			$('#City2').val(cityname);
		});
		
// 		$('#Area').change(function(){
// 			var areaname = $('select#Area option:selected').text();
// 				$('#Area2').val(areaname);
// 			});
		
		
// 		$('#pay_way').change(function(){
// 			var payway = $('select#pay_way option:selected').text();
				
// 		})
		
		
		

		
</script>







    <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-2">

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/stored_history/stored_history.do" name="form1">
			<div class="form-group">請選擇付款方式
            <select size="1" name="photo" onchange="photos(this);" id="pay_way"name="stored_Type" size="36" class="form-control input-lg" tabindex="3">
            <option value="<%=request.getContextPath()%>/res/images/stored_history/GashCard.png" selected>點數卡</option>
			<option value="2">信用卡</option>
			<option value="3">匯款</option>
			</select>
			</div>

		<img style="display:none" id="MyImage"/> 

            <input type="hidden" name="mem_No" size="36" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_No()%>" />
			
			<input type="hidden" name="stored_Date" size="36" class="form-control input-lg" tabindex="3"
			value="<%= (storedVO==null)? "": storedVO.getStored_Date()%>" />
			
			<input type="hidden" id="success" value="${success}"/>
			
			<input type="hidden" name="mem_point" size="36" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Point()%>" />
			
			<div class="form-group">請輸入儲值金額
            <input type="text" name="stored_Cost" size="36" class="form-control input-lg" tabindex="3"
            value="<%= (storedVO==null)? "": storedVO.getStored_Cost()%>"/>
			</div>
			
			
			
			
			<div class="form-group">
			<input type="hidden" name="action" value="insert">
			<input type="submit" value="送出新增資料">
			</div>
			</FORM>
			
			
		</div>
	
			
			
			
			
			
			
	</div>
</div>		
			
			
<!-- navbar====================================================================== -->
<br><br><br><br><br><br><br>

<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>


<!-- navbar====================================================================== -->
			
			
			
			
<script>
		var successOk = "ok";
		var success = $('#success').val();
		if(successOk == success){
			swal({
				  position: 'center',
				  type: 'success',
				  title: '恭喜你修改成功 !',
				  showConfirmButton: false,
				  timer: 1500
				})
		};
</script>

</body>
</html>