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
      
      <c:if test="${memVO.mem_State==null || memVO.mem_State==0 || memVO.mem_State==9}">
        <a class="navbar-brand js-scroll-trigger" href="#page-top">
        <img src="<%=request.getContextPath() %>/lib/publicfile/include/img/logo/logo.png">
        </a>
        </c:if>
      <c:if test="${memVO.mem_State==1}">
        <a class="navbar-brand js-scroll-trigger" href="#" onclick="window.open(' <%=request.getContextPath() %>/lib/publicfile/include/file/webSocket.jsp ', 'Yahoo', config='height=500,width=550')">
        <img src="<%=request.getContextPath() %>/lib/publicfile/include/img/logo/logo.png">
        </a>
        </c:if>
        
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fa fa-bars"></i>
        </button>
        <div id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
           
            
           
            <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/frontdesk/issuemission/issuemission.jsp"><i class="glyphicon glyphicon-send"></i> 發案區　</a></h3>
            </li>
            <li class="nav-item">
              <h3>
              <c:if test="${memVO ==null }" var= "login">
              <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/frontdesk/getmission/getMission.jsp">
              </c:if>
              <c:if test="${!login}">
              <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/frontdesk/getmission/getMissionlogin.jsp">
              </c:if>
              <i class="glyphicon glyphicon-screenshot"></i> 接案區　</a></h3>
            </li>
             <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="#contact"><i class="glyphicon glyphicon-user"></i> 排行榜　</a></h3>
            </li>
            <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/frontdesk/artiForm/ArtiForm_main.jsp"><i class="glyphicon glyphicon-list-alt"></i> 討論區　</a></h3>
            </li>
            <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp"><i class="glyphicon glyphicon-shopping-cart"></i> 積分商城　</a></h3>
            </li>

            <c:if test="${not empty memVO.mem_Id}">
            <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/frontdesk/mem/memCenter.jsp"><i class="glyphicon glyphicon-user"></i> 會員中心 　</a></h3>
            </li>
            </c:if>

<!--  開新分頁 target="_blank"   跳新視窗        onclick="window.open(' http://tw.yahoo.com ', 'Yahoo', config='height=500,width=500');"> -->
            
            
           <li class="nav-item1">  <h3><a class="nav-link js-scroll-trigger" id="create-user"  >
				
				<c:if test="${not empty memVO.mem_No}">
				<li><a style="text-decoration:none;" href='#modal-id1' data-toggle="modal">${memVO.mem_Id}<i class="glyphicon glyphicon-log-out"></i> 登出</a></li>
				</c:if>
				
				<c:if test="${empty memVO.mem_No}">
				<li><a style="text-decoration:none;" href='#modal-id' data-toggle="modal"><i class="glyphicon glyphicon-log-in"></i> 登入/註冊　</a></li>
				</c:if>
				</a></h3>
<%--               <h1><a class="nav-link js-scroll-trigger" href="#portfolio">Portfolio　</a></h1> --%>

<%-- 					<li><jsp:include page="/index.html" flush="true"></jsp:include></li> --%>
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
                    
						<br>
					<!--神奇小按鈕 -->	
						<div class="col-xs-12 col-sm-8">
						
						
						<button type="button" onclick="aa0953711016()">神</button>
						<button type="button" id="M000002">柏</button>	
						<button type="button" id="M000003">武</button>
						<button type="button" id="M000004">子</button>						
<!-- 						<button type="button" id="GM1">官</button></div>						 -->
                    <!--神奇小按鈕 -->
                    
                    <div class="col-xs-12 col-sm-4">
                    <a style="text-decoration:none;" href="<%=request.getContextPath()%>/frontdesk/mem/memForgetPw.jsp">
                    <input type="submit" value="忘記密碼" class="btn btn-danger btn-block"></a></div>
                   
					
					</div>
					<div class="modal-footer">
<%-- 						<button type="button" class="btn btn-default" data-dismiss="modal">����</button> 
 						<button type="button" class="btn btn-danger">Save changes</button> --%>
					</div>
				</div>
			</div>
		</div>
		<!--神奇方法 -->
			<script type="text/javascript">
				function aa0953711016(){
					
				var v = document.getElementById("login_username");			
					v.value="aa0953711016@gmail.com";
						
				var a=document.getElementById("login_password");  
					a.value="A123456";	
				}
				
				
				
			</script>
		<!--神奇方法 -->
		
		
		
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


<c:if test="${memSvc.getOneMem(memVO.mem_No).mem_State ==9}">
<input type="hidden" id="auth">
</c:if>






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
 	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.1/jquery.min.js"></script>
 	
 	<script type="text/javascript">
 	
 	$('#M000002').click(function(){
		$('#login_username').val("BBB@gmail.com");
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
 
  </body>

</html>