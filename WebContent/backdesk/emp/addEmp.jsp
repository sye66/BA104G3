<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.emp.model.*"%>

<%
  EmpVO empVO = (EmpVO) request.getAttribute("empVO");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Insert title here</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>員工資料新增 - addEmp.jsp</title>

<style>
 
  table, th, td{
    border: 1px solid #0044BB;
    text-align: center;
     font-size:20px;
     
  } 
</style>


<style type="text/css">
	#top{margin-top: auto;
		 margin-left: auto}
</style>

</head>
<body bgcolor='white'>
<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="backdeskEmpLeft.jsp" flush="true" />
	
	
<br>
<br>
<br>
<div class="container" align="center">
	<div class="row">
		<div class="col-xs-12 col-sm-12">

			<%-- 錯誤表列 --%>

<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>


<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/emp/emp.do" name="form1">
<table>
	<tr>
		<td>員工姓名:</td>
		<td><input type="TEXT" name="emp_Name" size="45" id="Username"
			 value="<%= (empVO==null)? "" : empVO.getEmp_Name()%>" placeholder="Username" required /></td>
	</tr>
	<tr>
		<td>信箱:</td>
		<td><input type="TEXT" name="emp_Mail" size="45" id="Useremail"
			 value="<%= (empVO==null)? "" : empVO.getEmp_Mail()%>" placeholder="Useremail" required /></td>
	</tr>
	<tr>
		<td>職稱:</td>
		<td><input type="TEXT" name="emp_Job" size="45" id="Userjob"
			 value="<%= (empVO==null)? "" : empVO.getEmp_Job()%>" placeholder="Userjob" required /></td>
	</tr>
	<tr>
		<td>電話:</td>
		<td><input type="TEXT" name="emp_Phone" size="45" id="Userphone"
			 value="<%= (empVO==null)? "" : empVO.getEmp_Phone()%>" placeholder="Userphone" required /></td>
	</tr>
	<tr>
		<td>狀態:</td>
		<td><input type="TEXT" name="emp_State" size="45" id="Userstate"
			 value="<%= (empVO==null)? "" : empVO.getEmp_State()%>" placeholder="Userstate" required /></td>
	</tr>


</table>

<br>
<br>

<input type="hidden" name="action" value="insert">
<input class="btn btn-primary" type="submit" value="送出新增">

</FORM>
<button type="button" id="newEmp">神</button>
		</div>
	</div>
</div>

</body>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/build/jquery.datetimepicker.full.min.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script type="text/javascript">
$('#newEmp').click(function(){
	$('#Username').val("吳永志");
	$('#Useremail').val("aaa123@gmail.com");
	$('#Userjob').val("manager");
	$('#Userphone').val("3345678");
	$('#Userstate').val("待授權");
});

</script>
<script>
       // $.datetimepicker.setLocale('zh');
       // $('#f_date1').datetimepicker({
	      // theme: '',              //theme: 'dark',
	      // timepicker:false,       //timepicker:true,
	      // format:'Y-m-d',         //format:'Y-m-d H:i:s',

           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
       // });
        
        
   
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
        //      var somedate1 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});

        
        //      2.以下為某一天之後的日期無法選擇
        //      var somedate2 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});


        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
</script>
</html>