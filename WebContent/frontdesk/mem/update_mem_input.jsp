<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*" %>
<%-- <%@ page import="java.util.*" %> --%>
<%@ page import="com.mem.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	MemVO memVO = (MemVO) request.getAttribute("memVO");
%>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<title>新增會員資料 - addEmp.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 98%;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
  #img,#img_pic,#old_pic{width:150px;
	heigth:200px}
</style>

</head>
<body>


	
<table id="table-1">
	<tr><td>
			<h3>會員資料修改 - update_mem_input.jsp</h3>
			<h4><a href="select_page.jsp"><img src="image/panda.png"
			width="60" height="80" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改 : </h3>

<%-- 錯誤處理 --%>

<c:if test="${not empty requestScope.errorMsgs}">
	<font style="color:#da0">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:#00f">${message}</li>
		</c:forEach>
	</ul>
</c:if>


<FORM METHOD="post" ACTION="mem.do" name="form1" enctype="multipart/form-data">


<table>
	<div class=" ordering-image wow bounceIn" data-wow-delay="0.4s" id="preview">後來圖片 :
			<img id="img_pic" <%-- src="<%=request.getContextPath()%>/mem/images/nopic.jpg" alt="your image" width="150" height="200"--%> /> 
			<span class="btn btn-block btn-large file-input-container">
				 <input id="mem_Pic" name="mem_Pic" size="30" type="file" value="上傳照片" onchange="previewFile();"/>
			</span>
		</div>


	<tr>
		原本圖片 :<br>
<%-- 		<img id="old_pic"src="<%=request.getContextPath() %>/mem/memShowImage.do?action=mem_Pic&mem_No=${memVO.mem_No}"> --%>
		<img id="old_pic"src="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${memVO.mem_No}">
	</tr>
	<%-- <tr>
		<td>照片</td>
		<td><input id="browse" name="mem_pic" type="file"  
			accept='text/plain|image/*' onchange="previewFiles()" multiple><br> 
		</td>
	</tr> --%>

	<tr>
		<td>會員編號:</td>
		<td><font color=red align="left">${memVO.getMem_No()}</font></td>
		
	</tr>
	<tr>
		<td>會員密碼</td>
		<td><input type="TEXT" name="mem_Pw" size="36" 
		value="${memVO.getMem_Pw()}" /></td>
		
	</tr>
	<tr>
		<td>姓名</td>
		<td><input type="TEXT" name="mem_Name" size="36" 
		value="${memVO.getMem_Name()}" /></td>
	</tr>
	<tr>
		<td>暱稱</td>
		<td><input type="TEXT" name="mem_Id" size="36" 
		value="${memVO.getMem_Id()}" /></td>
	</tr>
	<tr>
		<td>生日</td>
		<td><input type="TEXT" name="mem_Bday" id="f_date1"></td>
	</tr>
	<tr>
		<td>市話號碼</td>
		<td><input type="TEXT" name="mem_Tel" size="36" 
		value="${memVO.getMem_Tel()}" /></td>
	</tr>
	<tr>
		<td>手機號碼</td>
		<td><input type="TEXT" name="mem_Pho" size="36" 
		value="${memVO.getMem_Pho()}" /></td>
	</tr>
	<tr>
		<td>性別</td>
		<td>
		<select size="1" name="mem_Gend">${memVO.mem_Gend}
		<option value="1" selected>男</option>
		<option value="2">女</option>
		<option value="3">其他</option>
		</select>
		</td>
	</tr>
	<tr>
		<td>E-mail</td>
		<td><input type="TEXT" name="mem_Email" size="36" 
		value="${memVO.getMem_Email()}" /></td>
	</tr>
	
	
	<tr>
		<td>關於我</td>
		<td><input type="TEXT" name="mem_Intro" size="36" 
		value="${memVO.getMem_Intro()}" /></td>
	</tr>
	<tr>
		<td>會員驗證碼</td>
		<td><input type="TEXT" name="mem_Code" size="36" 
		value="${memVO.getMem_Code()}" /></td>
	</tr>
	<tr>
		<td>帳號狀態</td>
		<td><input type="TEXT" name="mem_State" size="36" 
		value="${memVO.getMem_State()}" /></td>
	</tr>
	<tr>
		<td>定位經度</td>
		<td><input type="TEXT" name="mem_Gps_Lat" size="36" 
		value="${memVO.getMem_Gps_Lat()}" /></td>
	</tr>
	<tr>
		<td>定位緯度</td>
		<td><input type="TEXT" name="mem_Gps_Lng" size="36" 
		value="${memVO.getMem_Gps_Lng()}" /></td>
	</tr>
	<tr>
		<td>定位IP</td>
		<td><input type="TEXT" name="mem_Ip" size="36" 
		value="${memVO.getMem_Ip()}" /></td>
	</tr>
	<tr>
		<td>註冊日期</td>
		<td><input type="TEXT" name="mem_Date" size="36" 
		value="${memVO.getMem_Date()}" /></td>
	</tr>
	<tr>
		<td>完成任務數量</td>
		<td><input type="TEXT" name="mission_Count" size="36" 
		value="${memVO.getMission_Count()}" /></td>
	</tr>
	<tr>
		<td>通訊地址</td>
		<td><input type="TEXT" name="mem_Address" size="36" 
		value="${memVO.getMem_Address()}" /></td>
	</tr>
	<tr>
		<td>能否被搜尋</td>
		<td><input type="TEXT" name="mem_Search" size="36" 
		value="${memVO.getMem_Search()}" /></td>
	</tr>
	<tr>
		<td>剩餘積分</td>
		<td><input type="TEXT" name="mem_Point" size="36" 
		value="${memVO.getMem_Point()}" /></td>
	</tr>
	
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="mem_No" value="${memVO.getMem_No()}">
<input type="submit" value="送出新增資料"></FORM>



</body>


<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/lib/component/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/lib/component/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/lib/component/datetimepicker/build/jquery.datetimepicker.full.min.js"></script>



<%-- 日期選擇----------------------------------------------------------%>


<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>



        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: 'pink',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '${memVO.getMem_Bday()}', /* // value:   new Date(), */
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        
   
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
              var somedate2 = new Date('2017-06-15');
              $('#f_date1').datetimepicker({
                  beforeShowDay: function(date) {
                	  if (  date.getYear() >  somedate2.getYear() || 
        		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
                      ) {
                           return [false, ""]
                      }
                      return [true, ""];
              }});


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
<%-- 日期選擇----------------------------------------------------------%>


<%-- 圖片上傳----------------------------------------------------------%>
	<script type="text/javascript">
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
</script>



<%--
<script type=>
function previewFiles() {
var reader = new FileReader();
  var preview = document.querySelector('#preview');
  var files   = document.querySelector('input[type=file]').files;
  // aaa();


  function readAndPreview(file) {

    // Make sure `file.name` matches our extensions criteria
    if ( /\.(jpe?g|png|gif)$/i.test(file.name) ) {
      reader = new FileReader();

      reader.addEventListener("load", function () {
        var image = new Image();
        image.height = 300;
        image.title = file.name;
        image.src = this.result;
        preview.appendChild( image );
      }, false);

      reader.readAsDataURL(file);
    }
  }
  if (files) {
	    [].forEach.call(files, readAndPreview);
	  }
  
}
</script>--%>
<%-- 圖片上傳----------------------------------------------------------%>


</html>