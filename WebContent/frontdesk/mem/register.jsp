<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>

<% MemVO memVO = (MemVO)request.getAttribute("memVO"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>工具人出租</title>


    <!-- Custom styles for this template -->
    <link href="<%=request.getContextPath()%>/lib/publicfile/include/css/freelancer.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/lib/component/datetimepicker/jquery.datetimepicker.css" />
<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/register.css" /> --%>
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/login_mem.css">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/index/index.css">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/register.css">

<style>
#img_pic,#old_pic{width:150px;
	heigth:200px}
</style>

  </head>

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


<div class="container">

<div class="row">
    <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" name="form1" enctype="multipart/form-data">
			<h2> <small>會員註冊表單</small></h2>
			<hr class="colorgraph">
			<div class=" ordering-image wow bounceIn" data-wow-delay="0.4s" id="preview">新增個人照片 :
			<img id="img_pic" <%-- src="<%=request.getContextPath()%>/mem/images/nopic.jpg" alt="your image" width="150" height="200"--%> /> 
			<span class="btn btn-block btn-large file-input-container">
				 <input id="mem_Pic" name="mem_Pic" size="30" type="file" value="上傳照片" onchange="previewFile();"/>
			</span>
		</div>
			
			<div class="form-group">E-mail
            <input type="email" id="mem_Email" name="mem_Email" size="36" placeholder="請輸入e-mail EX:aaa123@gmail.com" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Email()%>" />
    			
			</div>
		
            <div class="form-group">密碼
            <input type="password" id="mem_Pw" name="mem_Pw" size="36" placeholder="請輸入數字及英文字母" class="form-control input-lg" tabindex="3" 
            id="inputPassword1" pattern="[A-Za-z0-9]{6,16}" maxlength='16' title='由英文或數字所組成的6~16字元' 
            onchange="$('#inputPassword2').attr('pattern',$(this).val())" required />
    			
			</div>
			
			<div class="form-group">再次確認密碼
            <input type="password" id="mem_Pw_reg" name="mem_Pw_reg" size="36" placeholder="請輸入數字及英文字母" class="form-control input-lg" tabindex="3" 
            id="inputPassword2" title='與密碼不符' required />
    			
			</div>
			
			<div class="form-group">姓名
            <input type="TEXT" id="mem_Name" name="mem_Name" size="36" placeholder="請輸入中文或英文姓名" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Name()%>" />
    			
			</div>
			
			<div class="form-group">暱稱
            <input type="TEXT" id="mem_Id" name="mem_Id" size="36" placeholder="請輸入中文或英文暱稱" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Id()%>" />
    			
			</div>
			
			
			<div class="form-group">市話號碼
            <input type="TEXT" id="mem_Tel" name="mem_Tel" size="36" placeholder="EX:03-3345678" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Tel()%>" />
			
			</div>
			
			<div class="form-group">手機號碼
            <input type="TEXT" id="mem_Pho" name="mem_Pho" size="36" placeholder="EX:0978-978978" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Pho()%>" />
			
			</div>
			
			<div class="row">
            	<div class="col-xs-6 col-sm-6 col-md-6">
			<div class="form-group">性別
			<select size="1" name="mem_Gend" id="estadocivil" class="form-control input-lg" tabindex="3">${memVO.mem_Gend}
			<option value="1" selected>男</option>
			<option value="2">女</option>
			<option value="3">其他</option>
			</select>
			</div>
			</div>
			<div class="col-xs-6 col-sm-6 col-md-6">
			<div id="bday_right"class="form-group">生日
            <input type="TEXT" name="mem_Bday" size="36" id="f_date1" class="mem_Bday form-control input-lg" tabindex="3"/>
    		</div>	
			</div>
			</div>
			
<%----------------地址 -------------------------------------------%>


<jsp:include page="/frontdesk/mem/register_address.jsp" flush="true"></jsp:include>
<%				String City = request.getParameter("City2");
				String Area = request.getParameter("Area2");
				String ZIP = request.getParameter("ZIP"); 			%>
			<div class="form-group">通訊地址
            <input type="TEXT" id="mem_Address" name="mem_Address" size="36" placeholder="XXX路XXX巷XX弄XX號" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Address()%>" />
			
			</div>
			
<%----------------地址 -------------------------------------------%>
			
			<div class="form-group">能否被搜尋
            <select size="1" name="mem_Search" id="estadocivil" class="form-control input-lg" tabindex="3">
			<option value="0">無法被搜索</option>
			<option value="1" selected>可以被搜索</option>
			</select>
			
			
			<input type="hidden" name="mem_Date" size="36" 
			value="<%= (memVO==null)? "" : memVO.getMem_Date()%>" />
			<input type="hidden" name="mem_Code" size="36" 
			value="<%= (memVO==null)? "" : memVO.getMem_Code()%>" />
			<input type="hidden" name="mem_State" size="36" 
			value="<%= (memVO==null)? "" : memVO.getMem_State()%>" />
			<input type="hidden" name="mem_Gps_Lat" size="36" 
			value="<%= (memVO==null)? "" : memVO.getMem_Gps_Lat()%>" />
			<input type="hidden" name="mem_Gps_Lng" size="36" 
			value="<%= (memVO==null)? "" : memVO.getMem_Gps_Lng()%>" />
			<input type="hidden" name="mission_Count" size="36" 
			value="<%= (memVO==null)? "" : memVO.getMission_Count()%>" />
			<input type="hidden" name="mem_Point" size="36" 
			value="<%= (memVO==null)? "" : memVO.getMem_Point()%>" />
			
			
			
			<input type="hidden" name="City2" id="City2" />
			<input type="hidden" name="Area2" id="Area2" />
			
			
			</div>
			
			
			<div class="form-group">關於我<input id="mem_Intro" name="mem_Intro" type="text" value="<%= (memVO==null)? "": memVO.getMem_Intro()%>" placeholder="請輸入10個中文字以上" class="form-control input-lg" tabindex="3">
<%--             <textarea style="width:100%" name="mem_Intro" rows="4" cols="100" placeholder="請輸入10個中文字以上" class="form-control input-lg" tabindex="3" required ></textarea>  --%>
			</div>
			
			<div class="row">
				<div class="col-xs-3 col-sm-3 col-md-3">
					<span class="button-checkbox">
						<button type="button" class="btn aa" data-color="info" tabindex="7">I Agree</button>
                        <input type="checkbox" name="t_and_c" id="t_and_c" class="hidden" value="1">
					</span>
				</div>
				<div class="col-xs-9 col-sm-9 col-md-9">
					 By clicking <strong class="label label-primary">Register</strong>, you agree to the <a href="#" data-toggle="modal" data-target="#t_and_c_m">Terms and Conditions</a> set out by this site, including our Cookie Use.
				</div>
			</div>
			
			<hr class="colorgraph">
			<div class="row">
			<div class="col-xs-6 col-sm-6 col-md-6 col-xs-offset-3">
				<input type="hidden" name="action" value="registerNew">
				<input type="submit" class="btn btn-success btn-block btn-lg" tabindex="7" value="Register">
				</div>
				</div>
				
				<input type="button" id="bb" value="Mageic_Button">
				
</FORM>
		</div>
	</div>
</div>
		
<!-- <!-- Modal --> -->
<!-- <div class="modal fade" id="t_and_c_m" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"> -->
<!-- 	<div class="modal-dialog"> -->
<!-- 		<div class="modal-content"> -->
<!-- 			<div class="modal-header"> -->
<!-- 				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button> -->
<!-- 				<h4 class="modal-title" id="myModalLabel">Terms & Conditions</h4> -->
<!-- 			</div> -->
<!-- 			<div class="modal-body"> -->
<!-- 				<p>Ｑ4、在這個平台有什麼需要注意的嗎　？</p> -->
<!-- 				<p>Ａ4、本平台僅提供會員們可以交流的環境，若會員在此發生什麼違反法律的事情，本平台一概不負任何責任，也請會員們不要輕易以身試法，謝謝!</p> -->
			
<!-- 				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique, itaque, modi, aliquam nostrum at sapiente consequuntur natus odio reiciendis perferendis rem nisi tempore possimus ipsa porro delectus quidem dolorem ad.</p> -->
<!-- 			</div> -->
<!-- 			<div class="modal-footer"> -->
<!-- 				<button type="button" class="btn btn-primary" data-dismiss="modal" id="faq">I Agree</button> -->
<!-- 			</div> -->
<!-- 		</div>/.modal-content -->
<!-- 	</div>/.modal-dialog -->
<!-- </div>/.modal -->







<!-- footer====================================================================== -->
<br><br><br><br><br><br><br>


<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>


<!-- footer====================================================================== -->


 
    <script src="<%=request.getContextPath()%>/lib/js/mem/register.js"></script>
  </body>
<%
	Date mem_Bday = null;
	try{
		mem_Bday = memVO.getMem_Bday();
	} catch (Exception e) {
		mem_Bday = new Date(System.currentTimeMillis());
	}
%>


<script src="<%=request.getContextPath()%>/lib/component/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/lib/component/datetimepicker/build/jquery.datetimepicker.full.min.js"></script>



<%-- 日期選擇----------------------------------------------------------%>
<script src="<%=request.getContextPath()%>/lib/js/mem/register_datetimepicker.js"></script>

<script src="<%=request.getContextPath()%>/lib/css/mem/register_datetimepicker.css"></script>
<%-- 日期選擇----------------------------------------------------------%>

<%-- 地址----------------------------------------------------------%>

<script src="<%=request.getContextPath()%>/lib/js/mem/register_address.js"></script>



<%-- 地址----------------------------------------------------------%>

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
		
		
		$('#City').change(function(){
		var cityname = $('select#City option:selected').text();
			$('#City2').val(cityname);
		});
		
		$('#Area').change(function(){
			var areaname = $('select#Area option:selected').text();
				$('#Area2').val(areaname);
			});
		


		$('#bb').click(function(){
			$('#mem_Email').val("kiz7386@gmail.com");				
			$('#mem_Pw').val("A123123");
			$('#mem_Pw_reg').val("A123123");
			$('#mem_Name').val("阿群");
			$('#mem_Id').val("高雄陳柏霖");
			$('#mem_Tel').val("07-3345678");
			$('#mem_Pho').val("0978-449449");
			$('.mem_Bday').val("1988-08-06");
			$('#mem_Address').val("320桃園市中壢區中大路300號1樓之1");
			$('#mem_Intro').val("大家好我是高雄陳柏霖，看到這個平台感覺可以藉由幫助他人認是更多朋友，請多指教	");

		})
				$('.aa').click(function(){
					swal('<p>Ｑ4、在這個平台有什麼需要注意的嗎　？</p><p>Ａ4、本平台僅提供會員們可以交流的環境，若會員在此發生什麼違反法律的事情，本平台一概不負任何責任，也請會員們不要輕易以身試法，謝謝! (詳情醒看FAQ)</p><br>')
					});
</script>







</html>