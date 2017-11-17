<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.pro.model.*"%>
<%@ page import="com.pro.shoppingcart.*"%>
<%@ page import="com.protrack.model.*" %>
<%@ page import="com.proorder.model.*"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>	
<%MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); %>
<%request.getAttribute("updateSuccess");%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/login_mem.css">
<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/index/index.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<%--     <link href="<%=request.getContextPath()%>/lib/publicfile/include/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"> --%>
<style>

.navbar{position:relative;display:-ms-flexbox;display:flex;-ms-flex-wrap:wrap;flex-wrap:wrap;-ms-flex-align:center;align-items:center;-ms-flex-pack:justify;justify-content:space-between;padding:.5rem 1rem}
.navbar>.container,.navbar>.container-fluid{display:-ms-flexbox;display:flex;-ms-flex-wrap:wrap;flex-wrap:wrap;-ms-flex-align:center;align-items:center;-ms-flex-pack:justify;justify-content:space-between}.navbar-brand{display:inline-block;padding-top:.3125rem;padding-bottom:.3125rem;margin-right:1rem;font-size:1.25rem;line-height:inherit;white-space:nowrap}.navbar-brand:focus,.navbar-brand:hover{text-decoration:none}.navbar-nav{display:-ms-flexbox;display:flex;-ms-flex-direction:column;flex-direction:column;padding-left:0;margin-bottom:0;list-style:none}.navbar-nav .nav-link{padding-right:0;padding-left:0}.navbar-nav .dropdown-menu{position:static;float:none}.navbar-text{display:inline-block;padding-top:.5rem;padding-bottom:.5rem}.navbar-collapse{-ms-flex-preferred-size:100%;flex-basis:100%;-ms-flex-positive:1;flex-grow:1;-ms-flex-align:center;align-items:center}.navbar-toggler{padding:.25rem .75rem;font-size:1.25rem;line-height:1;background:0 0;border:1px solid transparent;border-radius:.25rem}.navbar-toggler:focus,
.navbar-toggler:hover{text-decoration:none}.navbar-toggler-icon{display:inline-block;width:1.5em;height:1.5em;vertical-align:middle;content:"";background:no-repeat center center;background-size:100% 100%}@media (max-width:575px){.navbar-expand-sm>.container,.navbar-expand-sm>.container-fluid{padding-right:0;padding-left:0}}@media (min-width:576px){.navbar-expand-sm{-ms-flex-flow:row nowrap;flex-flow:row nowrap;-ms-flex-pack:start;justify-content:flex-start}.navbar-expand-sm .navbar-nav{-ms-flex-direction:row;flex-direction:row}.navbar-expand-sm .navbar-nav .dropdown-menu{position:absolute}.navbar-expand-sm .navbar-nav .dropdown-menu-right{right:0;left:auto}.navbar-expand-sm .navbar-nav .nav-link{padding-right:.5rem;padding-left:.5rem}.navbar-expand-sm>.container,.navbar-expand-sm>.container-fluid{-ms-flex-wrap:nowrap;flex-wrap:nowrap}.navbar-expand-sm .navbar-collapse{display:-ms-flexbox!important;display:flex!important;-ms-flex-preferred-size:auto;flex-basis:auto}.navbar-expand-sm .navbar-toggler{display:none}.navbar-expand-sm .dropup .dropdown-menu{top:auto;bottom:100%}}@media (max-width:767px){.navbar-expand-md>.container,.navbar-expand-md>.container-fluid{padding-right:0;padding-left:0}}@media (min-width:768px){.navbar-expand-md{-ms-flex-flow:row nowrap;flex-flow:row nowrap;-ms-flex-pack:start;justify-content:flex-start}.navbar-expand-md .navbar-nav{-ms-flex-direction:row;flex-direction:row}.navbar-expand-md .navbar-nav .dropdown-menu{position:absolute}.navbar-expand-md .navbar-nav .dropdown-menu-right{right:0;left:auto}.navbar-expand-md .navbar-nav .nav-link{padding-right:.5rem;padding-left:.5rem}.navbar-expand-md>.container,.navbar-expand-md>.container-fluid{-ms-flex-wrap:nowrap;flex-wrap:nowrap}
.navbar-expand-md .navbar-collapse{display:-ms-flexbox!important;display:flex!important;-ms-flex-preferred-size:auto;flex-basis:auto}.navbar-expand-md .navbar-toggler{display:none}.navbar-expand-md .dropup .dropdown-menu{top:auto;bottom:100%}}@media (max-width:991px){.navbar-expand-lg>.container,.navbar-expand-lg>.container-fluid{padding-right:0;padding-left:0}}@media (min-width:992px){.navbar-expand-lg{-ms-flex-flow:row nowrap;flex-flow:row nowrap;-ms-flex-pack:start;justify-content:flex-start}.navbar-expand-lg .navbar-nav{-ms-flex-direction:row;flex-direction:row}.navbar-expand-lg .navbar-nav .dropdown-menu{position:absolute}.navbar-expand-lg .navbar-nav .dropdown-menu-right{right:0;left:auto}.navbar-expand-lg .navbar-nav .nav-link{padding-right:.5rem;padding-left:.5rem}.navbar-expand-lg>.container,.navbar-expand-lg>.container-fluid{-ms-flex-wrap:nowrap;flex-wrap:nowrap}.navbar-expand-lg .navbar-collapse{display:-ms-flexbox!important;display:flex!important;-ms-flex-preferred-size:auto;flex-basis:auto}.navbar-expand-lg .navbar-toggler{display:none}.navbar-expand-lg .dropup .dropdown-menu{top:auto;bottom:100%}}@media (max-width:1199px){.navbar-expand-xl>.container,.navbar-expand-xl>.container-fluid{padding-right:0;padding-left:0}}@media (min-width:1200px){.navbar-expand-xl{-ms-flex-flow:row nowrap;flex-flow:row nowrap;-ms-flex-pack:start;justify-content:flex-start}.navbar-expand-xl .navbar-nav{-ms-flex-direction:row;flex-direction:row}.navbar-expand-xl .navbar-nav .dropdown-menu{position:absolute}.navbar-expand-xl .navbar-nav .dropdown-menu-right{right:0;left:auto}.navbar-expand-xl .navbar-nav .nav-link{padding-right:.5rem;padding-left:.5rem}.navbar-expand-xl>.container,.navbar-expand-xl>.container-fluid{-ms-flex-wrap:nowrap;flex-wrap:nowrap}.navbar-expand-xl .navbar-collapse{display:-ms-flexbox!important;display:flex!important;-ms-flex-preferred-size:auto;flex-basis:auto}.navbar-expand-xl .navbar-toggler{display:none}.navbar-expand-xl .dropup .dropdown-menu{top:auto;bottom:100%}}.navbar-expand{-ms-flex-flow:row nowrap;flex-flow:row nowrap;-ms-flex-pack:start;justify-content:flex-start}.navbar-expand>.container,.navbar-expand>.container-fluid{padding-right:0;padding-left:0}.navbar-expand .navbar-nav{-ms-flex-direction:row;flex-direction:row}.navbar-expand .navbar-nav .dropdown-menu{position:absolute}.navbar-expand .navbar-nav .dropdown-menu-right{right:0;left:auto}.navbar-expand .navbar-nav .nav-link{padding-right:.5rem;padding-left:.5rem}.navbar-expand>.container,.navbar-expand>.container-fluid{-ms-flex-wrap:nowrap;flex-wrap:nowrap}.navbar-expand .navbar-collapse{display:-ms-flexbox!important;display:flex!important;-ms-flex-preferred-size:auto;flex-basis:auto}.navbar-expand .navbar-toggler{display:none}.navbar-expand .dropup .dropdown-menu{top:auto;bottom:100%}.navbar-light .navbar-brand{color:rgba(0,0,0,.9)}.navbar-light .navbar-brand:focus,.navbar-light .navbar-brand:hover{color:rgba(0,0,0,.9)}.navbar-light .navbar-nav .nav-link{color:rgba(0,0,0,.5)}.navbar-light .navbar-nav .nav-link:focus,.navbar-light .navbar-nav .nav-link:hover{color:rgba(0,0,0,.7)}.navbar-light .navbar-nav .nav-link.disabled{color:rgba(0,0,0,.3)}.navbar-light .navbar-nav .active>.nav-link,.navbar-light .navbar-nav .nav-link.active,.navbar-light .navbar-nav .nav-link.show,.navbar-light .navbar-nav .show>.nav-link{color:rgba(0,0,0,.9)}.navbar-light .navbar-toggler{color:rgba(0,0,0,.5);border-color:rgba(0,0,0,.1)}.navbar-light .navbar-toggler-icon{background-image:url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(0, 0, 0, 0.5)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E")}.navbar-light .navbar-text{color:rgba(0,0,0,.5)}.navbar-light .navbar-text a{color:rgba(0,0,0,.9)}.navbar-light .navbar-text a:focus,.navbar-light .navbar-text a:hover{color:rgba(0,0,0,.9)}.navbar-dark .navbar-brand{color:#fff}.navbar-dark .navbar-brand:focus,
.navbar-dark .navbar-brand:hover{color:#fff}.navbar-dark .navbar-nav .nav-link{color:rgba(255,255,255,.5)}.navbar-dark .navbar-nav .nav-link:focus,.navbar-dark .navbar-nav .nav-link:hover{color:rgba(255,255,255,.75)}.navbar-dark .navbar-nav .nav-link.disabled{color:rgba(255,255,255,.25)}.navbar-dark .navbar-nav .active>.nav-link,.navbar-dark .navbar-nav .nav-link.active,.navbar-dark .navbar-nav .nav-link.show,.navbar-dark .navbar-nav .show>.nav-link{color:#fff}.navbar-dark .navbar-toggler{color:rgba(255,255,255,.5);border-color:rgba(255,255,255,.1)}.navbar-dark .navbar-toggler-icon{background-image:url("data:image/svg+xml;charset=utf8,%3Csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath stroke='rgba(255, 255, 255, 0.5)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E")}.navbar-dark .navbar-text{color:rgba(255,255,255,.5)}.navbar-dark .navbar-text a{color:#fff}.navbar-dark .navbar-text a:focus,.navbar-dark .navbar-text a:hover{color:#fff}

</style>


</head>
<body>
<!-- 引入TOP-->
<div class="row">
<div class="col-xs-12 col-sm-12 ">


 <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav" >
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="#page-top"><img src="<%=request.getContextPath() %>/lib/publicfile/include/img/logo/profile_1.png"></a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fa fa-bars"></i>
        </button>
        <div id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
           
            
           
            <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="#contact"><i class="glyphicon glyphicon-send"></i> 發案區　</a></h3>
            </li>
            <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="#contact"><i class="glyphicon glyphicon-screenshot"></i> 接案區　</a></h3>
            </li>
             <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="#contact"><i class="glyphicon glyphicon-user"></i> 排行榜　</a></h3>
            </li>
            <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="#contact"><i class="glyphicon glyphicon-list-alt"></i> 討論區　</a></h3>
            </li>
            <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp"><i class="glyphicon glyphicon-shopping-cart"></i> 積分商城　</a></h3>
            </li>

            <c:if test="${not empty memVO.mem_Id}">
            <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/frontdesk/mem/memCenter.jsp"><i class="glyphicon glyphicon-user"></i> 會員中心 　</a></h3>
            </li>
            </c:if>

            
            
            
           <li class="nav-item1">  <h3><a class="nav-link js-scroll-trigger" id="create-user"  >
				
				<c:if test="${not empty memVO.mem_No}">
				<li><a style="text-decoration:none;" href='#modal-id1' data-toggle="modal">${memVO.mem_Id}<i class="glyphicon glyphicon-log-out"></i> 登出</a></li>
				</c:if>
				
				<c:if test="${empty memVO.mem_No}">
				<li><a style="text-decoration:none;" href='#modal-id' data-toggle="modal"><i class="glyphicon glyphicon-log-in"></i> 登入/註冊　</a></li>
				</c:if>
				</a></h3>
<%--               <h1><a class="nav-link js-scroll-trigger" href="#portfolio">Portfolio　</a></h1> --%>
            </li>
          </ul>
       </div>
      </div>
    </nav>

  
  
<div class="modal fade" id="modal-id">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;關閉</button>
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
                    <form id="login-form" method="post" action="<%=request.getContextPath()%>/mem/mem.do?reuestURL=<%=request.getServletPath()%>">
		                <div class="modal-body">
				    		<div id="div-login-msg">
                                <div id="icon-login-msg" class="glyphicon glyphicon-chevron-right"></div>
                                <span id="text-login-msg">Type your username and password.</span>
                            </div>
				    		<input name="mem_Email" id="login_username" class="form-control" type="email" placeholder="Username" required>
				    		<input name="mem_Pw" id="login_password" class="form-control" type="password" placeholder="Password" required><br>
<%--                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"> Remember me
                                </label>
                            </div>      --%>
        		    	</div>
                            <div>
                            	<input type="hidden" name="action" value="loginServlet">
                                <button type="submit" class="btn btn-primary btn-lg btn-block">確定登入</button><br>
                            </div>
<%--  				    	    <div>
                                <button id="login_lost_btn" type="button" class="btn btn-link">Lost Password?</button>
                                <button id="login_register_btn" type="button" class="btn btn-link">Register</button>
                            </div>       --%>
                    </form>
                    <form id="login-form" method="post" action="<%=request.getContextPath()%>/mem/mem.do">
                    	<div>
                    		<input type="hidden" name="action" value="register">
                    		<button type="submit" class="btn btn-success btn-lg btn-block">按我註冊</button>
                    	</div>
                    </form>
                    <!-- End # Login Form -->
                    
                    
                    
                    
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
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					</div>
					<div class="modal-body">
					
					
						 <!-- Begin # Login Form -->
                    <form id="login-form" method="post" action="<%=request.getContextPath()%>/mem/mem.do">
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









<%-- <jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"/> --%>
</div>
</div>

<!-- 商城TOP -->
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/selectProTOP.jsp" flush="true" />	
</div>




	

	<div class="col-xs-12 col-sm-2 col-sm-offset-1">
		<br><br><br>
		<div class="panel panel-info left001">
			<div class="panel-heading">
				<div class="panel-title">
					<h3 align="center">排行榜</h3>
				</div>
			</div>
			<div class="panel-body" >
	<div class="row">
					
					
<jsp:include page="/frontdesk/pro/selectProTop10.jsp" flush="true" />	
			
		</div>	
				
			</div>
		</div>

	</div>
	
	<!-- 左2結束 -->


	
	<div class="col-xs-12 col-sm-6">
	<!--麵包屑 -->
		<div class="col-xs-12 col-sm-12">

			<br>
			<ol class="breadcrumb">
				<li><a href="http://localhost:8081/BA104G3/lib/publicfile/include/file/index.jsp">首頁</a></li>
				<li class="active">積分商城
				</li>

			</ol>

		</div>
		
			<!-- 	輪播廣告		 -->
			<div class="col-xs-12 col-sm-12">
			<div id="carousel-id" class="carousel slide" data-ride="carousel">
				<!-- 幻燈片小圓點區 -->
				<ol class="carousel-indicators">
					<li data-target="#carousel-id" data-slide-to="0" class=""></li>
					<li data-target="#carousel-id" data-slide-to="1" class=""></li>
					<li data-target="#carousel-id" data-slide-to="2" class="active"></li>
				</ol>
				<!-- 幻燈片主圖區 -->
				<div class="carousel-inner">
					<div class="item active">
						<a href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=P000011" >
							<img src="<%=request.getContextPath()%>/res/images/pro_icons/iX.jpg" alt="" style="height:250px;width:900px;">
						</a>
					</div>
					
					<div class="item">
					<a  href="<%=request.getContextPath()%>/pro/pro.do" >
						<img src="<%=request.getContextPath()%>/res/images/pro_icons/aa02.jpg" alt="" style="height:250px;width:900px;">
					</a>
							
					</div>
					<div class="item ">
					<a  href="<%=request.getContextPath()%>/pro/pro.do?action=getOne_For_Display_F&pro_No=P000028" >
						<img src="<%=request.getContextPath()%>/res/images/pro_icons/aa03.jpg" alt="" style="height:250px;width:900px;">
					</a>
						
					</div>
				</div>
				<!-- 上下頁控制區 -->
				<a class="left carousel-control" href="#carousel-id"
					data-slide="prev"><span
					class="glyphicon glyphicon-chevron-left"></span></a> <a
					class="right carousel-control" href="#carousel-id"
					data-slide="next"><span
					class="glyphicon glyphicon-chevron-right"></span></a>
			</div>
				</div>
			<br>
		
		<br>



<div class="col-xs-12 col-sm-12" >
<div style="text-align:center ">
<jsp:include page="/frontdesk/pro/selectAllPro.jsp" flush="true" />
</div>
</div>


<div class="col-xs-12 col-sm-12">

		<div role="tabpanel">
			<!-- 標籤面板：標籤區 -->
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="#tab1"
					aria-controls="tab1" role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
				<li role="presentation"><a href="#tab2" aria-controls="tab2"
					role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
				<li role="presentation"><a href="#tab3" aria-controls="tab3"
					role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
				<li role="presentation"><a href="#amos" aria-controls="amos"
					role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
			</ul>

			<!-- 標籤面板：內容區 -->
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="tab1">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00ED21/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/002ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/002ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/20CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>
				</div>
				<div role="tabpanel" class="tab-pane" id="tab2">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/02CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/001ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00C1D1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CE11/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>
				</div>
				<div role="tabpanel" class="tab-pane" id="tab3">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/10CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/001ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/0aCED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00aED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>

				</div>
				<div role="tabpanel" class="tab-pane" id="amos">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00aED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CEa1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CEDa/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>

				</div>
			</div>
		</div>

		<div role="tabpanel">
			<!-- 標籤面板：標籤區 -->
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active"><a href="#tab1"
					aria-controls="tab1" role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
				<li role="presentation"><a href="#tab2" aria-controls="tab2"
					role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
				<li role="presentation"><a href="#tab3" aria-controls="tab3"
					role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
				<li role="presentation"><a href="#amos" aria-controls="amos"
					role="tab" data-toggle="tab"><h2>熱門</h2></a></li>
			</ul>

			<!-- 標籤面板：內容區 -->
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="tab1">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00ED21/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/002ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/002ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/20CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>
				</div>
				<div role="tabpanel" class="tab-pane" id="tab2">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/02CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/001ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00C1D1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CE11/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>
				</div>
				<div role="tabpanel" class="tab-pane" id="tab3">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/10CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/001ED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/0aCED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00aED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>

				</div>
				<div role="tabpanel" class="tab-pane" id="amos">
					<table class="table table-hover">


						<tbody>
							<tr>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00aED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CED1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CEa1/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
								<td><div>
										<a href=""> <img
											src="https://api.fnkr.net/testimg/170x200/00CEDa/FFF/?text=img+placeholder">XXXXXX
										</a>
										<p>SSSS</p>
										<p>
											$987 <input type="button" name="" value="購買">
										</p>

									</div></td>
							</tr>

						</tbody>
					</table>

				</div>
			</div>
		</div>
</div>

	</div>
	
	<!--中6結束 -->


	<div class="col-xs-12 col-sm-2">
		<br><br><br>
		<div class="panel panel-info left001">
			<div class="panel-heading">
				<div class="panel-title"><h3 align="center">特價商品</h3>
				</div>
			</div>
			<div class="panel-body">
				
<jsp:include page="/frontdesk/pro/selectHotPro.jsp" flush="true" />					
			</div>
		</div>

	</div>
	<!-- 右2結束 -->
<div class="col-xs-12 col-sm-12">
	<footer class="text-center">
      <div class="footer-above">
        <div class="container">
          <div class="row">
            <div class="footer-col col-md-4">
              <h2>Location</h2>
              <p>桃園市平鎮區
                <br>中央路300號</p>
              <br><br>
              <h2>Contact us</h2>
              <p>03-3345678</p>
            </div>
            <div class="footer-col col-md-4">
              <h3>Around the Web</h3>
              <ul class="list-inline">
                <li class="list-inline-item">
                  <a class="btn-social btn-outline" href="">
                    <i class="fa fa-fw fa-facebook"></i>
                  </a>
                </li>
                <li class="list-inline-item">
                  <a class="btn-social btn-outline" href="">
                    <i class="fa fa-fw fa-google-plus"></i>
                  </a>
                </li>
                <li class="list-inline-item">
                  <a class="btn-social btn-outline" href="">
                    <i class="fa fa-fw fa-twitter"></i>
                  </a>
                </li>
              </ul>
            </div>
            <div class="footer-col col-md-4">
              <h3>QR code</h3>
              <p>
                <img src="<%=request.getContextPath()%>/lib/publicfile/include/img/QRcode/static_qr_code_100.jpg"></p>
            </div>
          </div>
        </div>
      </div>
      <div class="footer-below">
        <div class="container">
          <div class="row">
            <div class="col-lg-12">
              Copyright &copy; POTM 2017
            </div>
          </div>
        </div>
      </div>
    </footer>

    <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
    <div class="scroll-top d-lg-none">
      <a class="btn btn-primary js-scroll-trigger" href="#page-top">
        <i class="fa fa-chevron-up"></i>
      </a>
    </div>

<%-- 	<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include> --%>
</div>	
</body>
</html>