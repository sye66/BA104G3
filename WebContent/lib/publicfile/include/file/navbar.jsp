<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>

<%-- <c:if test="${not empty login_memVO.mem_Id}"><% MemVO memVO = (MemVO)request.getSession().getAttribute("login_memVO"); %></c:if> --%>
<%MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); %>
<%request.getAttribute("updateSuccess");%>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<html lang="en">
 
<style>

#photo,.logo_size{
		heigth:70px;
}
#img_pic_nav,#old_pic_nav,.logo_size{
	max-width:70px;
	 border: #d3d3d3;
    border-radius: 5em;}
 .a_tag{
 	margin-top:25px;
 	font-size:22px;
 }
 .a_tag2{
 	margin-top:6px;
 	font-size:22px;
 }
</style>

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

  <body id="page-top"  style="font-family:Microsoft JhengHei;"   onload="connect();" onunload="disconnect();">

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
      <div class="container">
      
        <a class="navbar-brand js-scroll-trigger" href="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">
        <img class="logo_size" src="<%=request.getContextPath() %>/lib/publicfile/include/img/logo/teamwork.png">
        </a>
        
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu 
          <i class="fa fa-bars"></i>
        </button>
        <div style="margin-top:0px; margin-bottom:0px; font-size=30px;" id="navbarResponsive">
          <ul style="margin-top:20px" class="navbar-nav ml-auto">
           
            
           
            <li class="nav-item">
              <h3 style="font-size:22px"><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/frontdesk/issuemission/issuemission.jsp"><i class="glyphicon glyphicon-send"></i> 發案區　</a></h3>
            </li>
            <li class="nav-item">
              <h3 style="font-size:22px">
              <c:if test="${memVO ==null }" var= "login">
              <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/frontdesk/getmission/getMission.jsp">
              </c:if>
              <c:if test="${!login}">
              <a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/frontdesk/getmission/getMissionlogin.jsp">
              </c:if>
              <i class="glyphicon glyphicon-screenshot"></i> 接案區　</a></h3>
            </li>
            <li class="nav-item">	
              <h3 style="font-size:22px"><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/frontdesk/artiForm/listAllArtiForm.jsp"><i class="glyphicon glyphicon-list-alt"></i> 討論區　</a></h3>
            </li>
            <li class="nav-item">
              <h3 style="font-size:22px"><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp"><i class="glyphicon glyphicon-shopping-cart"></i> 積分商城　</a></h3>
            </li>
            <c:if test="${not empty memVO.mem_Id}">
            </c:if>
            <c:if test="${not empty memVO.mem_Id}">
            <li class="nav-item">
              <h3 style="font-size:22px"><a class="nav-link js-scroll-trigger" href="<%=request.getContextPath()%>/frontdesk/mem/memCenter.jsp"><i class="glyphicon glyphicon-user"></i> 會員中心 　</a></h3>
            </li>
            </c:if>

<!--  開新分頁 target="_blank"   跳新視窗        onclick="window.open(' http://tw.yahoo.com ', 'Yahoo', config='height=500,width=500');"> -->
            
            
				<c:if test="${not empty memVO.mem_No}">
				<div id="photo">
           <li style="margin-top:0px; margin-bottom:0px;" class="nav-item1">  <a href="<%=request.getContextPath()%>/frontdesk/personal/PersonalPage.jsp" class="nav-link js-scroll-trigger" id="create-user"  >
				<img id="old_pic_nav" src="<%=request.getContextPath() %>/mem/memShowImage.do?mem_No=${memVO.mem_No}">
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
						
						
						<button type="button" onclick="aa0953711016()">兆</button>
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
 
 <script>
    
    var MyPoint ="/MissionSocket/${memVO.mem_No}/${memVO.mem_Id}";
    var host = window.location.host;
    var path = window.location.pathname;
    var webCtx = path.substring(0, path.indexOf('/', 1));
    var endPointURL = "ws://" + host + webCtx + MyPoint;
    

	var webSocket;
	
	function connect() {
		// 建立 websocket 物件
		webSocket = new WebSocket(endPointURL);
		
		webSocket.onopen = function(event) {
// 			updateStatus("WebSocket 成功連線");
		
		};

		webSocket.onmessage = function(event) {
			var messagesArea = document.getElementById("messagesArea");
	        var jsonObj = JSON.parse(event.data);
	        if(jsonObj.action=='missionOk'){
	        	var inputMessage = "你的任務已經OK囉,積分已匯入,請確認查閱";
	        	swal(
	   				  '${memVO.mem_Id}',
	   				  inputMessage,
	   				  'success'
   				)
	        	
	        }
	        if(jsonObj.action=='checkmem'){
	        	var inputMessage = "恭喜你成功獲得青睞~快快去做任務吧";
	        	swal(
	   				  '${memVO.mem_Id}',
	   				  inputMessage,
	   				  'success'
   				)
	        	
	        }
	        if(jsonObj.action=='finishwork'){
	        	var inputMessage = "嘿~你的任務已經被完成囉~信件且已寄送~趕快去查看成果吧~";
	        	swal(
	   				  '${memVO.mem_Id}',
	   				  inputMessage,
	   				  'warning'
   				)
	        	
	        }
	 
		};

		webSocket.onclose = function(event) {
			updateStatus("WebSocket 已離線");
		};
	}
	


	
	function disconnect () {
		webSocket.close();
		
	}

	

</script>
 
  </body>

</html>