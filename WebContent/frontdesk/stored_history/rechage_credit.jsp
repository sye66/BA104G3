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
<% StoredVO storedVO = (StoredVO)request.getSession().getAttribute("storedVO"); %>
<%
String finish = "finish";
	session.setAttribute("finish", finish);		//防止按F5重新送出
	request.getAttribute("card_number1");
	request.getAttribute("card_number2");
	request.getAttribute("card_number3");
	request.getAttribute("card_number4");
	request.getAttribute("full_name");
	request.getAttribute("mm");
	request.getAttribute("yy");
	System.out.println("+++++++++++++"+request.getAttribute("yy"));
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
	    <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-2">
		    			<img id="image1" src="<%=request.getContextPath()%>/res/images/stored_history/postive.png" />
		   				<img id="image2" src="<%=request.getContextPath()%>/res/images/stored_history/negitive.png" />
					</div>


</div>

    		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/stored_history/stored_history.do?reuestURL=<%=request.getServletPath()%>" name="form1">
    		
    		
    					<input type="hidden" name="action" value="insert">
    					 <input type="hidden" name="mem_No" size="36" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_No()%>" />
    					<input type="hidden" name="stored_Type" size="36" class="form-control input-lg" tabindex="3" value="1">
    					<input type="hidden" name="stored_Date" size="36" class="form-control input-lg" tabindex="3"
			value="<%= (storedVO==null)? "": storedVO.getStored_Date()%>" />
    					<input type="hidden" name="mem_point" size="36" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Point()%>" />
    					<div class="small-6 ">請輸入儲值金額
                                 <input type="text" name="stored_Cost" size="36" class="form-control input-lg" tabindex="3" value="" placeholder="最大金額 1000000" >
                        </div><br>
                        <div class="small-6 ">請輸入信用卡號碼<br>
                            <input style="height:50px" type="text" name="card_number1" onblur="checkCreditCard(this)" size="4" maxlength="4"  placeholder="XXXX" tabindex="3">　-　
                            <input style="height:50px" type="text" name="card_number2" onblur="checkCreditCard(this)" size="4" maxlength="4"  placeholder="XXXX" tabindex="3">　-　
                            <input style="height:50px" type="text" name="card_number3" onblur="checkCreditCard(this)" size="4" maxlength="4"  placeholder="XXXX" tabindex="3">　-　
                            <input style="height:50px" type="text" name="card_number4" onblur="checkCreditCard(this)" size="4" maxlength="4"  placeholder="XXXX" tabindex="3">
                        </div><br>
                        <div class="small-6 ">請輸入姓名
                           <input type="text" name="full_name"  size="36" class="form-control input-lg" tabindex="3" value=""  placeholder="Full name"  >
                        </div><br>
                        <div class="small-3 ">請輸入有效日期<br>
                         <input type="text" name="mm"  min="01" max="12" size="2" maxlength="2" tabindex="3" value=""  placeholder="MM"  >　/　
                          <input type="text" name="yy" class="tt1"  min="17" max="27" size="2" maxlength="2" tabindex="3" value=""  placeholder="YY"  >
                        </div><br>

                        <div class="small-3 ">請輸入背面卡號
                         <input type="text" id="switch" name="cvc"  size="36" class="form-control input-lg" tabindex="3" value=""  placeholder="CVC"  >
                        </div><br>

                        <div class="small-6 ">
                            <input type="submit" value="Submit" class="button btn-defult" tabindex="3">
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
                        
                        
                        function checkCreditCard(control)
                        {
                        	re2 = /^\d{4}$/;
                            if (!re2.test(control.value))
                            	swal('Oops !','你輸入的信用卡號有誤' , 'error');
//                             re1 = /^\[a-zA-Z-]{2,10}[a-zA-Z-]{2,10}[a-zA-Z-]{2,10}$/;
//                             if (!re1.test(control.value))
//                             	swal('Oops !','你輸入的姓名不合英文格式' , 'error');
//                             re = /^([0?][1-9]|1[012])$/;
//                             if (!re.test(control.value))
//                             	swal('Oops !','你輸入的卡片有效日期不正確' , 'error');
                        }
                        
                        function full_name(control)
                        {
                            re1 = /^\[a-zA-Z-]{2,10}[a-zA-Z-]{2,10}[a-zA-Z-]{2,10}$/;
                            if (!re1.test(control.value))
                            	swal('Oops !','你輸入的姓名不合英文格式' , 'error');
                        }
                        
//                         $('.tt1').blur(function(){
//                         	re2 = /^([0?][1-9]|1[012])$/;
//                         	vv = $('.tt1').val();
//                             if (!re2.match(vv))
//                             	swal('Oops !','你輸入的卡片有效日期不正確' , 'error');
//                         });
                        
                   
                        
                        
//                         function mmyy(control1)
//                         {
//                         	re2 = /^[1]{0,1}[0-9/]{1,2}[1-2]{1}[0-9]{1}$/;
//                             if (!re2.test(control.value))
//                             	swal('Oops !','你輸入的卡片有效日期不正確' , 'error');
//                         }
                        
                        </script>

</html>