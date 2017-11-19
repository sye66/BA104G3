<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.pro.model.*"%>
<%@ page import="com.protrack.model.*"%>
<%@ page import="com.mem.model.*" %>	
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- ajax未完成 -->
<script type="text/javascript" src="http://libs.useso.com/js/jquery/1.7.2/jquery.min.js"></script>
<script src="frontdesk/pro/jquery.fly.min.js" ></script>

  
<style type="text/css">
.demo{width:820px; margin:60px auto 10px auto}


.m-sidebar{position: fixed;top: 0;right: 0;background: #000;z-index: 2000;width: 35px;height: 100%;font-size: 12px;color: #fff;}
.cart{color: #fff;text-align:center;line-height: 20px;padding: 200px 0 0 0px;}
.cart span{display:block;width:20px;margin:0 auto;}
.cart i{width:35px;height:35px;display:block; background:url(car.png) no-repeat;}
#msg{position:fixed; top:300px; right:35px; z-index:10000; width:1px; height:52px; line-height:52px; font-size:20px; text-align:center; color:#fff; background:#360; display:none}

.box{float:left; width:198px; height:320px; margin-left:5px; border:1px solid #e0e0e0; text-align:center}
.box p{line-height:20px; padding:4px 4px 10px 4px; text-align:left}
.box:hover{border:1px solid #f90}
.box h4{line-height:32px; font-size:14px; color:#f30;font-weight:500}
.box h4 span{font-size:20px}
.u-flyer{display: block;width: 50px;height: 50px;border-radius: 50px;position: fixed;z-index: 9999;}

.button {
	display: inline-block;
	outline: none;
	cursor: pointer;
	text-align: center;
	text-decoration: none;
	font: 16px/100% 'Microsoft yahei',Arial, Helvetica, sans-serif;
	padding: .5em 2em .55em;
	text-shadow: 0 1px 1px rgba(0,0,0,.3);
	-webkit-border-radius: .5em; 
	-moz-border-radius: .5em;
	border-radius: .5em;
	-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.2);
	-moz-box-shadow: 0 1px 2px rgba(0,0,0,.2);
	box-shadow: 0 1px 2px rgba(0,0,0,.2);
}
.button:hover {
	text-decoration: none;
}
.button:active {
	position: relative;
	top: 1px;
}
/* orange */
.orange {
	color: #fef4e9;
	border: solid 1px #da7c0c;
	background: #f78d1d;
	background: -webkit-gradient(linear, left top, left bottom, from(#faa51a), to(#f47a20));
	background: -moz-linear-gradient(top,  #faa51a,  #f47a20);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#faa51a', endColorstr='#f47a20');
}
.orange:hover {
	background: #f47c20;
	background: -webkit-gradient(linear, left top, left bottom, from(#f88e11), to(#f06015));
	background: -moz-linear-gradient(top,  #f88e11,  #f06015);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#f88e11', endColorstr='#f06015');
}
.orange:active {
	color: #fcd3a5;
	background: -webkit-gradient(linear, left top, left bottom, from(#f47a20), to(#faa51a));
	background: -moz-linear-gradient(top,  #f47a20,  #faa51a);
	filter:  progid:DXImageTransform.Microsoft.gradient(startColorstr='#f47a20', endColorstr='#faa51a');
}
</style>



<script>
// $(function() {
// 	var offset = $("#end").offset();
// 	$(".addcar").click(function(event){
// 		var addcar = $(this);
// 		var img = addcar.parent().find('img').attr('src');
// 		var flyer = $('<img class="u-flyer" src="'+img+'">');
// 		flyer.fly({
// 			start: {
// 				left: event.pageX,
// 				top: event.pageY
// 			},
// 			end: {
// 				left: offset.left+10,
// 				top: offset.top+10,
// 				width: 0,
// 				height: 0
// 			},
// 			onEnd: function(){
// 				$("#msg").show().animate({width: '250px'}, 200).fadeOut(1000);
// 				this.destory();
				
// 				var pro_No =  $("input[name='pro_No']").value();
// 				console.log("pro_No "+pro_No);
// 				$.ajax({
// 		            type: "POST",
<%-- 		            url: "<%=request.getContextPath()%>/pro/pro.do?", --%>
// 		            data: proString($(this).val(), pro_No),
// 		            dataType: "json",
		            
// 		            success: function(data) {
// 		            	alert("OK");
// 		            },
// 		            error: function(jqXHR) {
		            	
		            	
// 		                alert("發生錯誤: " + jqXHR.status);
// 		            }
// 		        })
// // 				addcar.css("cursor","default").removeClass('orange').unbind('click');
// 		        function proString(getOne_For_Display_F,pro_No){
// 					var queryString= {"action":"getOne_For_Display_F", "detail_time_no":detail_time_no, "cartypename":cartypename};
// 					return queryString;
			
//     	 		};
// 			}
// 		});
		
// 	});
	
// });
</script>

<!-- <div class="m-sidebar">  -->
<!--     <div class="cart">  -->
<!--         <i id="end"></i>  -->
<!--         <span>購物車</span>  -->
<!--     </div>  -->
<!-- </div>  -->
<!-- <div id="msg">已成功加入購物車！</div>  -->
<!-- ajax -->



<style>
.proTable {
	margin: 20px;
	padding: 0px;
	height: 450px;
	width: 450px;
}

.proName {
	font-weight: 900;
	font-size: 30px;
	width: 200px;
}

.proPrice {
	font-size: 20;
	color: red;
}

.imgCont01 {
	display: flex;
	align-items: center;
	justify-content: center;
	max-width: 300px;
}

.proDiv {
	width: 650px;
	border: 3px orange double;
	margin: 20px;
	padding: 0px;
	height: 550px;
}

.proDiscount {
	font-size: 16px;
	text-decoration: line-through;
}

#ontopDiv {
	top: 0;
	width: 100%;
	height: 60px;
	background-color: #ffffff;
	padding: 15px;
	font-size: 16px;
}

.float {
	position: fixed;
	top: 0;
	box-shadow: 4px 4px 12px 4px rgba(20%, 20%, 40%, 0.5);
	z-index: 100;
}

.breadcrumb li, .breadcrumb li a {
	color: #f90;
	font-size: 16px;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#backPro").click(function() {
			var proCount = $("#proCount").val() * 1;
			if (proCount > 1) {
				$("#proCount").val(proCount - 1);
			}
		});

		$("#addPro").click(function() {
			var proCount = $("#proCount").val() * 1;
			if (proCount < 10) {
				$("#proCount").val(proCount + 1);
			}
		});
	});
</script>
<script>
	window.onscroll = function() {
		if ($(document).scrollTop() > 60)//这个60是距离顶部高度
		{
			$("#ontopDiv").addClass('float');//
		} else {
			$("#ontopDiv").removeClass('float');
		}
	}
</script>


</head>
<body>
	
<div class="col-xs-12 col-sm-12 ">
<%-- <jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"/> --%>
</div>	
	
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/proNavbar.jsp" flush="true"/> 
</div>
<!-- 商城TOP -->
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/selectProTOP.jsp" flush="true" />	
</div>
<div class="col-xs-12 col-sm-12">	
	<!--中6-->
	<div class="col-xs-12 col-sm-6 col-sm-offset-3">
	
	<!--麵包屑 -->
		<div class="col-xs-12 col-sm-10">

			<br>
			<ol class="breadcrumb">
				<li><a href="<%=request.getContextPath()%>">首頁</a></li>
				<li><a href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp">積分商城</a></li>
				<li class="active">商品詳情
				</li>

			</ol>

		</div>
		<!--麵包屑 結束-->
		<div class="col-xs-12 col-sm-12">
			<div class="proDiv">

				<table class="proTable">
					<tbody>
						<tr>
							<td rowspan="3" style="padding: 16px;"><img
								class="card-img-top rounded imgCont01"
								src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=${proVO.pro_No}"
								alt="Card image cap"></td>
							<td><p class="proName">${proVO.pro_Name}</p></td>
						</tr>
						<tr>
							<td><p class="proInfo">
									<c:forTokens var="alpha" items="${proVO.pro_Info}" delims=",">
										<c:forEach var="person" items="${alpha}">
											<p>✦${person}</p>
										</c:forEach>
									</c:forTokens>
								</p></td>
						</tr>
						<tr>
							<td><c:if test="${proVO.pro_Discount==100}">
									<P></P>
									<p class="proPrice">價格:$${proVO.pro_Price}</p>
								</c:if> <c:if test="${proVO.pro_Discount!=100}">
									<p class="proDiscount">原價:$${proVO.pro_Price}</p>
									
									 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
									<fmt:formatNumber type="number" value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" maxFractionDigits="0" var="dsPrice" />
									
									<p class="proPrice">折扣價:$${dsPrice}</p>
								</c:if></td>
						</tr>


						<tr>
							<%
							
							MemVO memVO = (MemVO)session.getAttribute("memVO");
							List<String> list2 = new ArrayList<String>();
System.out.println("onePro追蹤 "+session.getAttribute("memVO"));
								if(session.getAttribute("memVO")!=null){
								String mem_No = memVO.getMem_No();
								ProTrackService proTrackSvc = new ProTrackService();
								List<ProTrackVO> list = proTrackSvc.getOnePro(mem_No);
								
									for (ProTrackVO p : list) {
										list2.add(p.getPro_No());
									}
								
								ProVO proVO = (ProVO) request.getAttribute("proVO");
								String pro_No = proVO.getPro_No();

								if (!list2.contains(pro_No)){
															
							%>


							<td style="padding-left: 130px; padding-top: 13px;">
							<FORM METHOD="post" style="height: 42px; width: 180px;" ACTION="<%=request.getContextPath()%>/pro/proTrackServlet.do">
									<button type="submit" class="btn btn-Secondary"  style="width: 180px; margin-top: 5px; font-size: 20px;">加入追蹤清單</button>
									<input type="hidden" name="pro_No" value="${proVO.pro_No}" >
									<input type="hidden" name="proCar_Price"  value="${dsPrice}">
									<input type="hidden" name="action" value="insertProTrack">
									<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
							</FORM></td>

							<%}else{%>
							
							<td style="padding-left: 130px; padding-top: 13px;">
								<img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/heart.png"
								style="width: 50px;">已加入追蹤</td>

							<%
								}
								}else{
								%>
							<td></td>
							<%
							}
							%>
							<td>
								
								<form METHOD="post"
									ACTION="<%=request.getContextPath()%>/pro/shoppingCartServlet.do">

									<button type="button" id="backPro" style="width: 30px;">-</button>
									<input type="text" id="proCount" name="proCar_Quantity"
										value="1" style="width: 30px; text-align: center">
									<button type="button" id="addPro" style="width: 30px;">+</button>



									<button type="submit" class="btn btn-warning"
										style="width: 180px; margin: 5px; margin-left: 0px; font-size: 20px;">放入購物車</button>
									<input type="hidden" name="proCar_No" value="${proVO.pro_No}">
									<input type="hidden" name="proCar_Name" value="${proVO.pro_Name}"> 
									<input type="hidden" name="proCar_Info" value="${proVO.pro_Info}"> 
									<input type="hidden" name="proCar_Price" value="${dsPrice}">
									<input type="hidden" name="mem_NO" value="${memVO.mem_No}">
									
									<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"> 
									<input type="hidden" name="action" value="addPro">
								</form>
							<td>
							
							



						
						</tr>
						<tr>
							<td></td>
						</tr>
						
					</tbody>
				</table>
			</div>

		</div>


	</div>
	<!--中6結束 -->
	<div class="col-xs-12 col-sm-3"><!--空 --></div>
</div>	
</body>
</html>