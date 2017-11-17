<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>

<%-- <c:if test="${not empty login_memVO.mem_Id}"><% MemVO memVO = (MemVO)request.getSession().getAttribute("login_memVO"); %></c:if> --%>
<%MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); %>
<%request.getAttribute("updateSuccess");%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>工具人出租</title>

    <!-- Bootstrap core CSS -->
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link href="<%=request.getContextPath()%>/lib/publicfile/include/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="<%=request.getContextPath()%>/lib/publicfile/include/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">
	
	<link href="<%=request.getContextPath()%>/lib/publicfile/include/css/sweetalert2.css" rel="stylesheet" type="text/css" />

    <!-- Custom styles for this template -->
    <link href="<%=request.getContextPath()%>/lib/publicfile/include/css/freelancer.css" rel="stylesheet">

	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/login_mem.css">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/index/index.css">





  </head>

  <body id="page-top"  style="font-family:Microsoft JhengHei;">

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
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


    <!-- Bootstrap core JavaScript -->
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/vendor/jquery/jquery.js"></script>
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/vendor/jquery-easing/jquery.easing.min.js"></script>



    <script src="<%=request.getContextPath()%>/lib/publicfile/include/vendor/jquery/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/vendor/bootstrap/js/bootstrap330.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<%--     <script src="<%=request.getContextPath()%>/front/jquery-twzipcode-master/jquery.twzipcode.js"></script> <!-- 台灣地址選擇器 --> --%>
<%--     <script src="<%=request.getContextPath()%>/front/MDP/jquery-ui.multidatespicker.js"></script> --%>



    <!-- Contact Form JavaScript -->
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/js/jqBootstrapValidation.js"></script>
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/js/contact_me.js"></script>
	<script src="<%=request.getContextPath()%>/lib/publicfile/include/js/sweetalert2all.js"></script>
    <!-- Custom scripts for this template -->
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/js/freelancer.min.js"></script>
  
  
  
  
  
  
  </body>

</html>