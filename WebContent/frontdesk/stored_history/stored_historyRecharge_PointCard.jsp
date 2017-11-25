<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.stored_history.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<jsp:useBean id="StoredSvc" scope="page" class="com.stored_history.model.StoredService"/>
<% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); %>
<% StoredVO storedVO = (StoredVO)request.getSession().getAttribute("storedVO"); 
String finish = "finish";
// request.setAttribute("finish", finish);
session.setAttribute("finish", finish);		//防止按F5重新送出
System.out.println("finish + " + finish);
%>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/login_mem.css">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/index/index.css">
		<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/recharge/default.css">
<title>Insert title here</title>
</head>
<body>


<!-- navbar====================================================================== -->


<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"></jsp:include>

<br><br><br><br><br><br><br>
<!-- navbar====================================================================== -->




<!-- 麵包屑 -->

<div class="row">
 <div class="col-xs-12 col-sm-10">
	<ol class="breadcrumb">
	<li>
		<a href="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">首頁</a>
	</li>
	<li>
		<a href="<%=request.getContextPath()%>/frontdesk/mem/memCenter.jsp">會員中心</a>
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





<!-- memPageLeft====================================================================== -->



<jsp:include page="/frontdesk/mem/memPageLeft.jsp" flush="true"></jsp:include>

	<div id="container">
		<div><img style="margin-left:-30px" id="image" src="<%=request.getContextPath()%>/res/images/stored_history/pointCard.jpg" /></div>
	    <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-2">
		    		
<%-- 		   				<img id="image2" src="<%=request.getContextPath()%>/res/images/stored_history/negitive.png" /> --%>
					</div>


</div>

    		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/stored_history/stored_history.do?reuestURL=<%=request.getServletPath()%>" name="form1">
    		<script>
    		</script>
    					<input type="hidden" name="success" value="ok">
    					<input type="hidden" name="action" value="insert1">
    					 <input type="hidden" name="mem_No" size="36" class="form-control input-lg" tabindex="3"
							value="<%= (memVO==null)? "": memVO.getMem_No()%>" />
    					<input type="hidden" name="stored_Type" size="36" class="form-control input-lg" tabindex="3" value="1">
    					<input type="hidden" name="stored_Date" size="36" class="form-control input-lg" tabindex="3"
							value="<%= (storedVO==null)? "": storedVO.getStored_Date()%>" />
    					<input type="hidden" name="mem_point" size="36" class="form-control input-lg" tabindex="3"
							value="<%= (memVO==null)? "": memVO.getMem_Point()%>" />
    					<br><br><br>
                        <div class="small-6 ">請輸入點卡序號：
                            <input id="sn" type="text" name="card_number" size="36" class="form-control input-lg" tabindex="3" value="" placeholder="請輸入序號(14、20或21碼英數字組合)" >
                        </div><br>
                        <div class="small-6 ">
                          	<div class="col-xs-6 col-sm-6 col-md-6">
						<div class="form-group">選擇你的點數卡:
						<select size="1" name="stored_Cost" id="estadocivil" class="form-control input-lg" tabindex="3">
						
						<option value="50">50點</option>
						<option value="100">100點</option>
						<option value="150">150點</option>
						<option value="300">300點</option>
						<option value="500">500點</option>
						<option value="1000">1000點</option>
						<option value="3000">3000點</option>
						<option value="5000">5000點</option>
						</select>
						</div>
						</div>

                        <br><br><div class="small-6 ">
                            <input type="submit" value="確認送出" class="button btn-susccess">
                       <br><br><div></div><input type="button" id="Magic" value="Magic"></div>
                        </div>
                        
                        
                      
   				</FORM>
			</div>
    	 </div>       
       </div>
</div>
</div>

<!-- memPageLeft====================================================================== -->




<!-- footer====================================================================== -->
<br><br><br><br><br><br><br><br><br><br><br><br><br><br>


<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>


<!-- footer====================================================================== -->

            


</body>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.3.1/jquery.min.js"></script>
  <script>
                        var margin = $("#image1").width()/2;
                		var width = $("#image1").width();
                		var height = $("#image1").height();
                		$("#image2").css({width:'0px', height:height+'px', marginLeft:margin+'px', opacity:'0.5'});
                        $(document).ready(function(){
                        	$('#switch').focus(function(){
                        		$("#image1").stop().animate({width:'0px', height:height+'px', marginLeft:margin+'px', opacity:'0.5'}, 500);
                    			window.setTimeout(function() {
                    				$("#image2").stop().animate({width:width+'px', height:height+'px', marginLeft:'0px', opacity:'1'}, 500);
                    			}, 500)
                        	})
                        	$('#switch').blur(function(){
                        		$("#image2").stop().animate({width:'0px', height:height+'px', marginLeft:margin+'px', opacity:'0.5'}, 500);
                    			window.setTimeout(function() {
                    				$("#image1").stop().animate({width:width+'px', height:height+'px', marginLeft:'0px', opacity:'1'}, 500);
                    			}, 500);
                        	})
                        });
                        
                        $('#Magic').click(function(){
                        	$('#sn').val("32r0O68q1P6xE5zO74sL9");
                        })
                        
   
</script>

</html>