<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.pro.model.*"%>
<%@ page import="com.pro.shoppingcart.*"%>
<%@ page import="com.protrack.model.*"%>
<%@ page import="com.proorder.model.*"%>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<%@ page import="java.util.*"%>
<%@ page import="java.lang.*"%>
<%@ page import="com.mem.model.*"%>


<html>
<head>
<link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/lib/css/mem/login_mem.css">
<link rel=stylesheet type="text/css"
	href="<%=request.getContextPath()%>/lib/css/index/index.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<%--     <link href="<%=request.getContextPath()%>/lib/publicfile/include/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"> --%>

<style>
.navbar {
	position: relative;
	display: -ms-flexbox;
	display: flex;
	-ms-flex-wrap: wrap;
	flex-wrap: wrap;
	-ms-flex-align: center;
	align-items: center;
	-ms-flex-pack: justify;
	justify-content: space-between;
	padding: .5rem 1rem;
	
}

.navbar>.container, .navbar>.container-fluid {
	display: -ms-flexbox;
	display: flex;
	-ms-flex-wrap: wrap;
	flex-wrap: wrap;
	-ms-flex-align: center;
	align-items: center;
	-ms-flex-pack: justify;
	justify-content: space-between
}

.container{
	margin-top:30px;

}

.navbar-brand {
	display: inline-block;
	padding-top: .3125rem;
	padding-bottom: .3125rem;
	margin-right: 1rem;
	font-size: 1.25rem;
	line-height: inherit;
	white-space: nowrap
}

.navbar-brand:focus, .navbar-brand:hover {
	text-decoration: none
}

.navbar-nav {
	display: -ms-flexbox;
	display: flex;
	-ms-flex-direction: column;
	flex-direction: column;
	padding-left: 0;
	margin-bottom: 0;
	list-style: none;
	border:2px;
	border-color: red;
  
}
/* 字大小 */
.navbar-nav .nav-link {
	padding-right: 0;
	padding-left: 0;
		font-size:25px;
}

.navbar-nav .dropdown-menu {
	position: static;
	float: none
}

.navbar-text {
	display: inline-block;
	padding-top: .5rem;
	padding-bottom: .5rem
}

.navbar-collapse {
	-ms-flex-preferred-size: 100%;
	flex-basis: 100%;
	-ms-flex-positive: 1;
	flex-grow: 1;
	-ms-flex-align: center;
	align-items: center
}

.navbar-toggler {
	padding: .25rem .75rem;
	font-size: 1.25rem;
	line-height: 1;
	background: 0 0;
	border: 3px solid red;
	border-radius: .25rem
}

.navbar-toggler:focus, .navbar-toggler:hover {
	text-decoration: none
}

.navbar-toggler-icon {
	display: inline-block;
	width: 1.5em;
	height: 1.5em;
	vertical-align: middle;
	content: "";
	background: no-repeat center center;
	background-size: 100% 100%
}

@media ( max-width :575px) {
	.navbar-expand-sm>.container, .navbar-expand-sm>.container-fluid {
		padding-right: 0;
		padding-left: 0
	}
}

@media ( min-width :576px) {
	.navbar-expand-sm {
		-ms-flex-flow: row nowrap;
		flex-flow: row nowrap;
		-ms-flex-pack: start;
		justify-content: flex-start
	}
	.navbar-expand-sm .navbar-nav {
		-ms-flex-direction: row;
		flex-direction: row
	}
	.navbar-expand-sm .navbar-nav .dropdown-menu {
		position: absolute
	}
	.navbar-expand-sm .navbar-nav .dropdown-menu-right {
		right: 0;
		left: auto
	}
	.navbar-expand-sm .navbar-nav .nav-link {
		padding-right: .5rem;
		padding-left: .5rem
	}
	.navbar-expand-sm>.container, .navbar-expand-sm>.container-fluid {
		-ms-flex-wrap: nowrap;
		flex-wrap: nowrap
	}
	.navbar-expand-sm .navbar-collapse {
		display: -ms-flexbox !important;
		display: flex !important;
		-ms-flex-preferred-size: auto;
		flex-basis: auto
	}
	.navbar-expand-sm .navbar-toggler {
		display: none
	}
	.navbar-expand-sm .dropup .dropdown-menu {
		top: auto;
		bottom: 100%
	}
}

@media ( max-width :767px) {
	.navbar-expand-md>.container, .navbar-expand-md>.container-fluid {
		padding-right: 0;
		padding-left: 0
	}
}

@media ( min-width :768px) {
	.navbar-expand-md {
		-ms-flex-flow: row nowrap;
		flex-flow: row nowrap;
		-ms-flex-pack: start;
		justify-content: flex-start
	}
	.navbar-expand-md .navbar-nav {
		-ms-flex-direction: row;
		flex-direction: row
	}
	.navbar-expand-md .navbar-nav .dropdown-menu {
		position: absolute
	}
	.navbar-expand-md .navbar-nav .dropdown-menu-right {
		right: 0;
		left: auto
	}
	.navbar-expand-md .navbar-nav .nav-link {
		padding-right: .5rem;
		padding-left: .5rem
	}
	.navbar-expand-md>.container, .navbar-expand-md>.container-fluid {
		-ms-flex-wrap: nowrap;
		flex-wrap: nowrap
	}
	.navbar-expand-md .navbar-collapse {
		display: -ms-flexbox !important;
		display: flex !important;
		-ms-flex-preferred-size: auto;
		flex-basis: auto
	}
	.navbar-expand-md .navbar-toggler {
		display: none
	}
	.navbar-expand-md .dropup .dropdown-menu {
		top: auto;
		bottom: 100%
	}
}

@media ( max-width :991px) {
	.navbar-expand-lg>.container, .navbar-expand-lg>.container-fluid {
		padding-right: 0;
		padding-left: 0
	}
}

@media ( min-width :992px) {
	.navbar-expand-lg {
		-ms-flex-flow: row nowrap;
		flex-flow: row nowrap;
		-ms-flex-pack: start;
		justify-content: flex-start;
		font-size:25px;
	}
	.navbar-expand-lg .navbar-nav {
		-ms-flex-direction: row;
		flex-direction: row
	}
	.navbar-expand-lg .navbar-nav .dropdown-menu {
		position: absolute
	}
	.navbar-expand-lg .navbar-nav .dropdown-menu-right {
		right: 0;
		left: auto
	}
	.navbar-expand-lg .navbar-nav .nav-link {
		padding-right: .5rem;
		padding-left: .5rem
	}
	.navbar-expand-lg>.container, .navbar-expand-lg>.container-fluid {
		-ms-flex-wrap: nowrap;
		flex-wrap: nowrap
	}
	.navbar-expand-lg .navbar-collapse {
		display: -ms-flexbox !important;
		display: flex !important;
		-ms-flex-preferred-size: auto;
		flex-basis: auto
	}
	.navbar-expand-lg .navbar-toggler {
		display: none
	}
	.navbar-expand-lg .dropup .dropdown-menu {
		top: auto;
		bottom: 100%
	}
}

@media ( max-width :1199px) {
	.navbar-expand-xl>.container, .navbar-expand-xl>.container-fluid {
		padding-right: 0;
		padding-left: 0
	}
}

@media ( min-width :1200px) {
	.navbar-expand-xl {
		-ms-flex-flow: row nowrap;
		flex-flow: row nowrap;
		-ms-flex-pack: start;
		justify-content: flex-start
	}
	.navbar-expand-xl .navbar-nav {
		-ms-flex-direction: row;
		flex-direction: row
	}
	.navbar-expand-xl .navbar-nav .dropdown-menu {
		position: absolute
	}
	.navbar-expand-xl .navbar-nav .dropdown-menu-right {
		right: 0;
		left: auto
	}
	.navbar-expand-xl .navbar-nav .nav-link {
		padding-right: .5rem;
		padding-left: .5rem
	}
	.navbar-expand-xl>.container, .navbar-expand-xl>.container-fluid {
		-ms-flex-wrap: nowrap;
		flex-wrap: nowrap
	}
	.navbar-expand-xl .navbar-collapse {
		display: -ms-flexbox !important;
		display: flex !important;
		-ms-flex-preferred-size: auto;
		flex-basis: auto
	}
	.navbar-expand-xl .navbar-toggler {
		display: none
	}
	.navbar-expand-xl .dropup .dropdown-menu {
		top: auto;
		bottom: 100%
	}
}

.navbar-expand {
	-ms-flex-flow: row nowrap;
	flex-flow: row nowrap;
	-ms-flex-pack: start;
	justify-content: flex-start
}

.navbar-expand>.container, .navbar-expand>.container-fluid {
	padding-right: 0;
	padding-left: 0
}

.navbar-expand .navbar-nav {
	-ms-flex-direction: row;
	flex-direction: row
}

.navbar-expand .navbar-nav .dropdown-menu {
	position: absolute
}

.navbar-expand .navbar-nav .dropdown-menu-right {
	right: 0;
	left: auto
}

.navbar-expand .navbar-nav .nav-link {
	padding-right: .5rem;
	padding-left: .5rem
}

.navbar-expand>.container, .navbar-expand>.container-fluid {
	-ms-flex-wrap: nowrap;
	flex-wrap: nowrap
}

.navbar-expand .navbar-collapse {
	display: -ms-flexbox !important;
	display: flex !important;
	-ms-flex-preferred-size: auto;
	flex-basis: auto
}

.navbar-expand .navbar-toggler {
	display: none
}

.navbar-expand .dropup .dropdown-menu {
	top: auto;
	bottom: 100%
}












.navbar-light .navbar-toggler {
	color: rgba(0, 0, 0, .5);
	border-color: red;
}

.navbar-light .navbar-toggler-icon {
	background-image:
		url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(0, 0, 0, 0.5)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E")
}

.navbar-light .navbar-text {
	color: rgba(0, 0, 0, .5)
}

.navbar-light .navbar-text a {
	color: rgba(0, 0, 0, .9)
}

.navbar-light .navbar-text a:focus, .navbar-light .navbar-text a:hover {
	color: rgba(0, 0, 0, .9)
}

.navbar-dark .navbar-brand {
	color: #fff
}

.navbar-dark .navbar-brand:focus, .navbar-dark .navbar-brand:hover {
	color: #fff
}

.navbar-dark .navbar-nav .nav-link {
	color: rgba(255, 255, 255, .5)
}

.navbar-dark .navbar-nav .nav-link:focus, .navbar-dark .navbar-nav .nav-link:hover
	{
	color: rgba(255, 255, 255, .75)
}

.navbar-dark .navbar-nav .nav-link.disabled {
	color: rgba(255, 255, 255, .25)
}

.navbar-dark .navbar-nav .active>.nav-link, .navbar-dark .navbar-nav .nav-link.active,
	.navbar-dark .navbar-nav .nav-link.show, .navbar-dark .navbar-nav .show>.nav-link
	{
	color: #fff
}

.navbar-dark .navbar-toggler {
	color: rgba(255, 255, 255, .5);
	border-color: red;
}

.navbar-dark .navbar-toggler-icon {
	background-image:
		url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(255, 255, 255, 0.5)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E")
}

.navbar-dark .navbar-text {
	color: red;
}

.navbar-dark .navbar-text a {
		color: red;
}

.navbar-dark .navbar-text a:focus, .navbar-dark .navbar-text a:hover {
	color: #fff
}
.navbarTop{
	border-color:red;
	border:3px;
	color:#000;
}
.nav-item{
	color:#000;

}
</style>


</head>
<body>
	<!-- 引入TOP-->
	<div class="row">
		<div class="col-xs-12 col-sm-12 " class="navbarTop">


			<nav style="margin-bottom:27px"class="navbar navbar-expand-lg navbar-light fixed-top "
				id="mainNav" style="height: 100px;">
				<div class="container">
					 <img style="max-height:70px" src="<%=request.getContextPath() %>/lib/publicfile/include/img/logo/logo.png">
        
					<button class="navbar-toggler navbar-toggler-right" type="button"
						data-toggle="collapse" data-target="#navbarResponsive"
						aria-controls="navbarResponsive" aria-expanded="false"
						aria-label="Toggle navigation">
						Menu <i class="fa fa-bars"></i>
					</button>
					<div id="navbarResponsive">
						<ul class="navbar-nav ml-auto">



							<li class="nav-item">
								<h3>
									<a class="nav-link js-scroll-trigger"
										href="<%=request.getContextPath()%>/frontdesk/issuemission/issuemission.jsp"><i
										class="glyphicon glyphicon-send"></i> 發案區 </a>
								</h3>
							</li>
							<li class="nav-item">
								<h3>
									<a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/frontdesk/getmission/getMission.jsp"><i
										class="glyphicon glyphicon-screenshot"></i> 接案區 </a>
								</h3>
							</li>
							<li class="nav-item">
								<h3>
									<a class="nav-link js-scroll-trigger"
										href="<%=request.getContextPath()%>/frontdesk/artiForm/listAllArtiForm.jsp"><i
										class="glyphicon glyphicon-list-alt"></i> 討論區 </a>
								</h3>
							</li>
							<li class="nav-item">
								<h3>
									<a class="nav-link js-scroll-trigger"
										href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp"><i
										class="glyphicon glyphicon-shopping-cart"></i> 積分商城 </a>
								</h3>
							</li>


							<c:if test="${not empty memVO.mem_Id}">
								<li class="nav-item">
									<h3>
										<a class="nav-link js-scroll-trigger"
											href="<%=request.getContextPath()%>/frontdesk/mem/memCenter.jsp"><i
											class="glyphicon glyphicon-user"></i> 會員中心 </a>
									</h3>
								</li>
							</c:if>




										<c:if test="${not empty memVO.mem_No}">
							<div id="photo">
			           <li style="margin-top:0px; margin-bottom:0px;" class="nav-item1">  <a href="<%=request.getContextPath()%>/frontdesk/personal/PersonalPage.jsp" class="nav-link js-scroll-trigger" id="create-user"  >
							<img style="max-width:70px; border: #d3d3d3; border-radius: 5em;" src="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${memVO.mem_No}">
							</a>
			            	</li>
			            	</div>
							</c:if>
							<c:if test="${empty memVO.mem_No}">
							<div style="margin-top:6px; margin-bottom:0px;">
							<a class="a_tag2" style="text-decoration:none" href='#modal-id' data-toggle="modal"><i class=" glyphicon glyphicon-log-in"></i> 登入/註冊　</a>
							</div>
							</c:if>
							<c:if test="${not empty memVO.mem_No}">
							<div style="margin-top:25px; margin-bottom:0px;">
							<a class="a_tag"style="style="text-decoration:none"  href='#modal-id1' data-toggle="modal">${memVO.mem_Id}<i class="glyphicon glyphicon-log-out"></i> 登出</a>
							</div>
							</c:if>
						</ul>
					</div>
				</div>
			</nav>



			<div class="modal fade" id="modal-id">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;關閉</button>
							<h4 class="modal-title"></h4>
						</div>
						<div class="modal-body">

							<%-- 錯誤處理 --%>
							<%--
<script>
function getFocus() {
    documemt.getElementById("myText").focus();
}
</script>
--%>

							<!-- Begin # Login Form -->
							<form id="login-form" method="post"
								action="<%=request.getContextPath()%>/mem/mem.do?reuestURL=<%=request.getServletPath()%>">
								<div class="modal-body">
									<div id="div-login-msg">
										<div id="icon-login-msg"
											class="glyphicon glyphicon-chevron-right"></div>
										<span id="text-login-msg">Type your username and
											password.</span>
									</div>
									<input name="mem_Email" id="login_username"
										class="form-control" type="email" placeholder="Username"
										required> <input name="mem_Pw" id="login_password"
										class="form-control" type="password" placeholder="Password"
										required><br>
									<%--                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"> Remember me
                                </label>
                            </div>      --%>
								</div>
								<div>
									<input type="hidden" name="action" value="loginServlet">
									<button type="submit" class="btn btn-primary btn-lg btn-block">確定登入</button>
									<br>
								</div>
								<%--  				    	    <div>
                                <button id="login_lost_btn" type="button" class="btn btn-link">Lost Password?</button>
                                <button id="login_register_btn" type="button" class="btn btn-link">Register</button>
                            </div>       --%>
							</form>
							<form id="login-form" method="post"
								action="<%=request.getContextPath()%>/mem/mem.do">
								<div>
									<input type="hidden" name="action" value="register">
									<button type="submit" class="btn btn-success btn-lg btn-block">按我註冊</button>
								</div>
							</form>
							<!-- End # Login Form -->


						<br>
					<!--神奇小按鈕 -->	
						<div class="col-xs-12 col-sm-8">
						
						
						<button type="button" id="M000001">兆</button>
						<button type="button" id="M000002">柏</button>	
						<button type="button" id="M000003">武</button>
						<button type="button" id="M000004">子</button></div>						
<!-- 						<button type="button" id="GM1">官</button></div>						 -->
                    <!--神奇小按鈕 -->
                    
                    <div class="col-xs-12 col-sm-4">
                    <a style="text-decoration:none;" href="<%=request.getContextPath()%>/frontdesk/mem/memForgetPw.jsp">
                    <input type="submit" value="忘記密碼" class="btn btn-danger btn-block"></a></div>

						</div>
						<div class="modal-footer">
							<%-- 						<button type="button" class="btn btn-default" data-dismiss="modal">����</button> 
 						<button type="button" class="btn btn-primary">Save changes</button> --%>
						</div>
					</div>
				</div>
			</div>

	

			<div class="modal fade" id="modal-id1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"
								aria-hidden="true">&times;</button>
						</div>
						<div class="modal-body">


							<!-- Begin # Login Form -->
							<form id="login-form" method="post"
								action="<%=request.getContextPath()%>/mem/mem.do">
								<div class="modal-footer">
									<div>
										<input type="hidden" name="action" value="logoutServlet">
										<button type="submit" class="btn btn-primary btn-lg btn-block">確定登出</button>
									</div>
									<%--  				    	    <div>
                                <button id="login_lost_btn" type="button" class="btn btn-link">Lost Password?</button>
                                <button id="login_register_btn" type="button" class="btn btn-link">Register</button>
                            </div>       --%>
								</div>
							</form>
							<!-- End # Login Form -->




						</div>
					</div>
				</div>
			</div>


<!--神奇方法 -->
			
			<script type="text/javascript">
			$('#M000001').click(function(){
				$('#login_username').val("aa0953711016@gmail.com");
				$('#login_password').val("A123456");
			});
 			$('#M000002').click(function(){
				$('#login_username').val("sanderxavalon@gmail.com");
				$('#login_password').val("E123456");
			});
 	
 			$('#M000003').click(function(){
				$('#login_username').val("CCC@gmail.com");
				$('#login_password').val("F123456");
			});
 	
 			$('#M000004').click(function(){
				$('#login_username').val("ziu0614@gmail.com");
				$('#login_password').val("B123456");
			});
 	
//  	$('#GM1').click(function(){
// 		$('#login_username').val("burnerzx@gmail.com");
// 		$('#login_password').val("OFFICAL1");
// 	});
 	</script>
		<!--神奇方法 -->







			<%-- <jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"/> --%>
		</div>
	</div>
</body>
</html>