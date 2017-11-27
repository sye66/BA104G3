<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>

<jsp:useBean id="MemSvc" scope="session" class="com.mem.model.MemService"/>

<% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); %>
<% request.getAttribute("updateSuccess"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">




  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>工具人出租</title>

<!--     Bootstrap core CSS -->
<!--      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
<%--     <link href="<%=request.getContextPath()%>/lib/publicfile/include/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"> --%>

<!--     Custom fonts for this template -->
<%--     <link href="<%=request.getContextPath()%>/lib/publicfile/include/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css"> --%>
<!--     <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css"> -->
<!--     <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css"> -->


<!--     Custom styles for this template -->
<%--     <link href="<%=request.getContextPath()%>/lib/publicfile/include/css/freelancer.css" rel="stylesheet"> --%>

<%-- 	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/login_mem.css"> --%>
<%-- 	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/index/index.css"> --%>
<%-- 	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/register.css"> --%>
<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/lib/component/datetimepicker/jquery.datetimepicker.css" /> --%>
<%-- <%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/register.css" /> --%> 

  </head>


<!-- 會員資料修改====================================================================== -->


	<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/mem/backdeskMemLeft.jsp" flush="true" />
	
	
	<div id="top" class="container-fluid">
			<div class="row">
				
				<div class="col-xs-12 col-sm-8 col-sm-offset-1" >

<table id="table-1">
	<tr><td id="hh">
			<h3>會員修改資料</h3>
			<h4><a href="<%=request.getContextPath()%>/backdesk/mem/backdeskMemIndex.jsp""><img src="<%=request.getContextPath()%>/lib/publicfile/include/img/logo/logo.png"
			width="60" height="80"
			border="0"><br>回首頁</a></h4>
	</td></tr>
</table>
           


<div class="row">
    <div class="col-xs-12 col-sm-9 col-md-9 col-sm-offset-1 col-md-offset-1">
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/mem/mem.do" name="form1" >
			<hr class="colorgraph">
		
			<div class="form-group">個人圖片 :
<%-- 		<img id="old_pic"src="<%=request.getContextPath() %>/mem/memShowImage.do?action=mem_Pic&mem_No=${memVO.mem_No}"> --%>
			<img id="old_pic"src="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${memVO.mem_No}">
			</div>
			
			<%/*如果使用disabled 會連傳送值都會取消掉，使用readonly是唯讀,但是可以傳值 */%>
			
			<div class="form-group">會員編號
			<input type="text" name="mem_No" size="36" 
			value="<%=memVO.getMem_No()%>" readonly  class="form-control input-lg" tabindex="3"/>
			
			<div class="form-group">E-mail
            <input type="TEXT" name="mem_Email" size="36" readonly  class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Email()%>" />
    			
			</div>
		
			
			<div class="form-group">姓名
            <input type="TEXT" name="mem_Name" size="36" readonly  class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Name()%>" />
    			
			</div>
			
			<div class="form-group">暱稱
            <input type="TEXT" name="mem_Id" size="36" readonly  class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Id()%>" />
    			
			</div>
			
			<c:if test="${memVO.mem_Gend==1}">
			<div class="form-group">性別
			<input type="text" name="mem_Gend" size="36" readonly class="form-control input-lg" tabindex="3"
			value="男">
			</div>
			</c:if>
			<c:if test="${memVO.mem_Gend==2}">
			<div class="form-group">性別
			<input type="text" name="mem_Gend" size="36" readonly class="form-control input-lg" tabindex="3"
			value="女">
			</div>
			</c:if>
			<c:if test="${memVO.mem_Gend==3}">
			<div class="form-group">性別
			<input type="text" name="mem_Gend" size="36" readonly class="form-control input-lg" tabindex="3"
			value="不想說">
			</div>
			</c:if>
			
			<c:if test="${memVO.mem_State==0}">
			<div class="form-group">會員狀態
			<select size="1" name="mem_State" value="<%= (memVO==null)? "": memVO.getMem_State()%>" id="estadocivil" class="form-control input-lg" tabindex="3">
			<option value="0" selected>尚未驗證</option>
			<option value="1">一般會員</option>
			<option value="9">停權</option>
			</select>
			</div>
			</c:if>
			<c:if test="${memVO.mem_State==1}">
			<div class="form-group">會員狀態
			<select size="1" name="mem_State" value="<%= (memVO==null)? "": memVO.getMem_State()%>" id="estadocivil" class="form-control input-lg" tabindex="3">
			<option value="0">尚未驗證</option>
			<option value="1" selected>一般會員</option>
			<option value="9">停權</option>
			</select>
			</div>
			</c:if>
				<c:if test="${memVO.mem_State==9}">
			<div class="form-group">會員狀態
			<select size="1" name="mem_State" value="<%= (memVO==null)? "": memVO.getMem_State()%>" id="estadocivil" class="form-control input-lg" tabindex="3">
			<option value="0">尚未驗證</option>
			<option value="1">一般會員</option>
			<option value="9" selected>停權</option>
			</select>
			</div>
			</c:if>
			
			
			
			
			
			
			
			<hr class="colorgraph">
			<div class="row">
			<div class="col-xs-6 col-sm-6 col-md-6 col-xs-offset-3">
				<input type="hidden" name="action" value="updateByEmp">
				<input type="submit" class="btn btn-success btn-block btn-lg" tabindex="7">
				</div>
				</div>
				
</FORM>
</div>
</div>

		</div>
	</div>
</div>
		


 
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
		var updateOk = "ok";
		var updateSuccess = $('#updateSuccess').val();
		if(updateOk == updateSuccess){
			swal({
				  position: 'center',
				  type: 'success',
				  title: '恭喜你修改成功 !',
				  showConfirmButton: false,
				  timer: 1500
				})
		};
		
		
		
</script>

<style>
  table#table-1 {
	width: 98%;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 40px;
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
	margin-top: 5px;
	margin-bottom: 5px;
	
  }
  table, th, td ,#bo{
    border: 1px solid #0044BB;
    text-align: center;
     font-size:20px;
  } 
  th, td {
    padding: 5px;
    text-align: center;
    height:200px;
  }
  #img{width:150px;
	heigth:150px}
</style>
<style>
#img_pic,#old_pic{width:150px;
	heigth:200px}
	#hh {
	 height:100px}
</style>





</html>