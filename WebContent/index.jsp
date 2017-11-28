<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>ToolMan</title>



<style type="text/css" media="screen">
.loginpage {
	background: #fff url(<%=request.getContextPath()%>/res/images/pro_icons/patternbg.png);
}

.loginbox {
	width: 350px;
	padding: 5px;
	background: #fff;
	margin: 7% auto 0 auto;
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	border-radius: 2px;
	-moz-box-shadow: 0 0 2px rgba(0, 0, 0, 0.3);
	-webkit-box-shadow: 0 0 2px rgba(0, 0, 0, 0.3);
	box-shadow: 0 0 2px rgba(0, 0, 0, 0.3);
}

.loginboxinner {
	padding: 20px;
	background: #32415a url(../res/images/pro_icons/p.png);
	-moz-border-radius: 0 2px 2px 0;
	-webkit-border-radius: 0 0 2px 2px;
	border-radius: 0 0 2px 2px;
}

.loginbox .logo {
	text-align: center;
}

.loginbox .logo h1 {
	font-family: 'RobotoCondensed', Arial, Helvetica, sans-serif;
	font-size: 32px;
	color: #fff;
	border-bottom: 1px solid #56647d;
	line-height: normal;
	margin-bottom: 5px;
}

.loginbox .logo h1 span {
	color: #FB9337;
}

.loginbox .logo p {
	font-weight: bold;
	color: #eee;
	font-style: italic;
}

.loginbox form {
	display: block;
	margin-top: 20px;
}

.loginbox .username {
	background: #eee url(<%=request.getContextPath()%>/res/images/pro_icons/username.png) no-repeat 13px center;
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	border-radius: 2px;
	-moz-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.4);
	-webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.4);
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.4);
	margin: 20px 0;
}

.loginbox .usernameinner {
	margin-left: 45px;
	border-left: 1px solid #ddd;
	background: #fff;
	padding-right: 20px;
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	border-radius: 2px;
}

.loginbox .username input {
	padding: 15px 10px;
	border: 0;
	font-size: 14px;
	width: 100%;
	box-shadow: none;
	color: #666;
	font-family: 'RobotoCondensed', Arial, Helvetica, sans-serif;
	-moz-border-radius: 0 2px 2px 0;
	-webkit-border-radius: 0 2px 2px 0;
	border-radius: 0 2px 2px 0;
}

.loginbox .password {
	background: #eee url(<%=request.getContextPath()%>/res/images/pro_icons/password.png) no-repeat 13px center;
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	border-radius: 2px;
	-moz-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.4);
	-webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.4);
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.4);
	margin: 20px 0;
	overflow: hidden;
}

.loginbox .passwordinner {
	margin-left: 45px;
	border-left: 1px solid #ddd;
	background: #fff;
}

.loginbox .password input {
	padding: 15px 10px;
	border: 0;
	font-size: 14px;
	width: 330px;
	box-shadow: none;
	color: #666;
	font-family: 'RobotoCondensed', Arial, Helvetica, sans-serif;
}

.loginbox button {
	background: #f0801d url(<%=request.getContextPath()%>/res/images/pro_icons/btngrad.png) repeat-x top left;
	border: 0;
	padding: 15px 0;
	text-align: center;
	font-family: 'RobotoCondensed', Arial, Helvetica, sans-serif;
	font-size: 14px;
	font-weight: normal;
	width: 100%;
	text-transform: uppercase;
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	border-radius: 2px;
	-moz-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.4);
	-webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, 0.4);
	box-shadow: 0 1px 2px rgba(0, 0, 0, 0.4);
}

.loginbox button:hover {
	background-color: #f0721e;
}

.loginbox .keep {
	margin-top: 20px;
	font-weight: bold;
	color: #ccc;
	font-size: 11px;
}

.loginbox .loginmsg {
	background: #fffccc;
	color: #333;
	margin-bottom: 10px;
	padding: 5px;
	text-align: center;
	font-size: 11px;
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	border-radius: 2px;
}

.loginf {
	padding: 10px;
	background: #2e3e59;
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	border-radius: 2px;
	-moz-box-shadow: inset 0 1px 1px #23324b;
	-webkit-box-shadow: inset 0 1px 1px #23324b;
	box-shadow: inset 0 1px 1px #23324b;
	border-bottom: 1px solid #475875;
}

.loginpage .nousername, .loginpage .nopassword {
	display: none;
}

.loginpage .nopassword {
	color: #fff;
}

.loginpage .nopassword .thumb {
	padding: 5px;
	background: #fff;
	display: inline-block;
	vertical-align: top;
	-moz-border-radius: 2px;
	-webkit-border-radius: 2px;
	border-radius: 2px;
}

.loginpage .nopassword .userlogged {
	display: inline-block;
	margin-left: 10px;
	font-weight: bold;
}

.loginpage .nopassword .userlogged h4 {
	font-size: 14px;
	font-family: 'RobotoCondensed', Arial, Helvetica, sans-serif;
}

.loginpage .nopassword .userlogged a {
	color: #f0801d;
	font-style: italic;
}

.loginpage .nopassword .userlogged a:hover {
	text-decoration: underline;
}

.loginpage .notibar {
	border: 0;
}
</style>
</head>

	

<body class="loginpage">

	
	
	<div class="loginbox">
		<div class="loginboxinner">
		
		<c:if test="${not empty errorMsgs}">
	<font color='red'>請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
	</c:if>
		
			<div class="logo">
				<h1 class="logo">
					ToolMan.<span>Admin</span>
				</h1>
				</span>
			</div>
			<!--logo-->

			<br clear="all" />
			<br />

			<div class="nousername">
				<div class="loginmsg">密碼不正確</div>
			</div>
			<!--nousername-->

			<div class="nopassword">
				<div class="loginmsg">密碼不正確</div>
				<div class="loginf">
					<div class="thumb">
						<img alt="" src="images/thumbs/avatar1.png" />
					</div>
					<div class="userlogged">
						<h4></h4>
						<a href="index.html">Not <span></span>?
						</a>
					</div>
				</div>
				<!--loginf-->
			</div>
			<!--nopassword-->
			
			

			<form id="login" action="<%=request.getContextPath()%>/loginhandler/loginhandler.do" method="post">

				<div class="username" style="">
					<div class="usernameinner">
						<input type="text" name="username" id="username" />
						<input type="hidden" name="action" value="emplogin">
					</div>
				</div>

				<div class="password">
					<div class="passwordinner">
						<input type="password" name="password" id="password" />
						<input type="hidden" name="action" value="emplogin">
					</div>
				</div>

				<button>登錄</button>



			</form>
			
				<br>
				<!--神奇小按鈕-->
						<button type="button" onclick="e01()"  class="btn btn-success" style="width:20px;height:10px;">老</button>						
					    <button type="button" onclick="e02()"  class="btn btn-success" style="width:20px;height:10px;">王</button>
                <!--神奇小按鈕 -->
				

		</div>
		<!--loginboxinner-->
	</div>
	<!--loginbox-->
			<!--神奇方法 -->
			<script type="text/javascript">
			function e01(){
				var v = document.getElementById("username");			
					v.value="E000001";
				var a=document.getElementById("password");  
					a.value="123";	
				}	
			
			function e02(){
				var v = document.getElementById("username");			
					v.value="E000002";
				var a=document.getElementById("password");  
					a.value="123";	
				}		
			</script>
		<!--神奇方法 -->

</body>
</html>
