<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.pro.model.*"%>
<%@ page import="com.protrack.model.*"%>
<%@ page import="com.mem.model.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     

<%
	ProVO proVO = (ProVO) session.getAttribute("ProVO");	
	if(session.getAttribute("ProVO")!=null){
		pageContext.setAttribute("ProVO",proVO);
	}
%>
	
<html>
<head>
<!-- <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"> -->
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>


  
<style type="text/css">

.proTable {
	margin: 20px;
	padding: 0px;
	height: 450px;
	width: 600px;
}
.proTable td{
	width: 300px;
}
.proName {
	font-weight: 900;
	font-size: 30px;
	width: 250px;
}

.proPrice {
	font-size: 24px;
	color: red;
	font-weight: 900;
}

.imgCont01 {
	display: flex;
	align-items: center;
	justify-content: center;
	max-width: 250px;
}

.proDiv {
	width: 680px;
	border: 3px orange double;
	margin: 20px;
	padding: 0px;
	height: 600px;
}

.proDiscount {
	font-size: 16px;
	text-decoration: line-through;
	
}

#ontopDiv {
/* 	top: 0; */
	width: 100%;
	height: 60px;
	background-color: #ffffff;
	padding: 15px;
	font-size: 16px;
}

.float {
	position: fixed;
/* 	top: 0; */
	box-shadow: 4px 4px 12px 4px rgba(20%, 20%, 40%, 0.5);
	z-index: 100;
}

.breadcrumb li, .breadcrumb li a {
	color: #f90;
	font-size: 16px;
}
/* 購物車 */
.m-sidebar{
	position: fixed;
	top: 200px;
	right: 100px;
/* 	background: #000; */
	z-index: 3;
	width: 35px;
	height: 50%;
	font-size: 12px;
	color: #fff;
}
#msg{
	position:fixed; 
	top:300px; right:35px; 
	z-index:3; 
	width:1px; 
	height:52px; 
	line-height:52px; 
	font-size:20px; 
	text-align:center; 
	color:#fff; 
	background:	#97CBFF; 
	display:none
}
.u-flyer{
	display: block;
	width: 100px;
	height: 100px;
	border-radius: 50px;
	position: fixed;
	z-index: 9999;
}
/* 購物車 */
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
// 	window.onscroll = function() {
// 		if ($(document).scrollTop() > 200)//这个60是距离顶部高度
// 		{
// 			$("#ontopDiv").addClass('float');
// 		} else {
// 			$("#ontopDiv").removeClass('float');
// 		}
// 	}
</script>

<title>工具人出租</title>

</head>
<body>

<a name="aaa"></a>	
	
<!-- TOP -->
<div class="row">
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/proNavbar.jsp" flush="true"/> 
<%-- <jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"></jsp:include> --%>
</div>
</div>
<!-- 商城TOP -->

<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/selectProTOP.jsp" flush="true" />	
</div>
<div class="col-xs-12 col-sm-12">	
	<!--中6-->
	<div class="col-xs-12 col-sm-6 col-sm-offset-4">
	
	<!--麵包屑 -->
		<div class="col-xs-12 col-sm-11">

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

																<c:if test="${proVO.pro_Discount==90}">
																	<div style="z-index:3;position:absolute;left:600px;  top:50px;">
																		<img alt="" style="height:70px;width:70px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d001.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==80}">
																	<div style="z-index:3;position:absolute;left:600px;  top:50px;">
																		<img alt="" style="height:70px;width:70px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d002.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==70}">
																	<div style="z-index:3;position:absolute;left:600px;  top:50px;">
																		<img alt="" style="height:70px;width:70px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d003.png">
																	</div>
																</c:if>
																<c:if test="${proVO.pro_Discount==50}">
																	<div style="z-index:3;position:absolute;left:550px;  top:30px;">
																		<img alt="" style="height:120px;width:200px;" src="<%=request.getContextPath()%>/res/images/pro_icons/d005.png">
																	</div>
																</c:if>

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
											<p style="font-size:16px;">✦${person}</p>
										</c:forEach>
									</c:forTokens>
								</p></td>
						</tr>
						<tr>
							<td><c:if test="${proVO.pro_Discount==100}">
								
									
									<c:set var="balance" value="${proVO.pro_Price}" />
	   			 					 <fmt:parseNumber var="dsPrice" integerOnly="true"  type="number" value="${balance}" />
									<p class="proPrice">價格:${dsPrice}點</p>
								</c:if> 
								<c:if test="${proVO.pro_Discount!=100}">
									<span class="proDiscount">原價:${proVO.pro_Price}點</span>
									
									<c:set var="balance" value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}" />
	   			 					 <fmt:parseNumber var="dsPrice" integerOnly="true"  type="number" value="${balance}" />
	   			 		 
	   			 		<p class="card-footer proPrice" style="height:28px;">折扣價:<span style="font-size:36px;"><c:out value="${dsPrice}"/></span>點</p>
	   			 		
								</c:if></td>
						</tr>


						<tr>
							<%
							
							MemVO memVO = (MemVO)session.getAttribute("memVO");
							List<String> list2 = new ArrayList<String>();
							String mem_No;
System.out.println("onePro追蹤 "+session.getAttribute("memVO"));
								if(session.getAttribute("memVO")!=null){
								mem_No = memVO.getMem_No();
								ProTrackService proTrackSvc = new ProTrackService();
								List<ProTrackVO> list = proTrackSvc.getOnePro(mem_No);
								
									for (ProTrackVO p : list) {
										list2.add(p.getPro_No());
									}
								
								proVO = (ProVO) session.getAttribute("proVO");
								String pro_No = proVO.getPro_No();

								if (!list2.contains(pro_No)){
															
							%>


							<td style="padding-left: 50px; padding-top: 13px;">
							<FORM METHOD="post" style="height: 42px; width: 180px;" ACTION="<%=request.getContextPath()%>/pro/proTrackServlet.do">
									<button type="submit" class="btn btn-Secondary"  style="width: 180px; margin-top: 5px; font-size: 20px;border-radius: 5px;">加入追蹤清單</button>
									<input type="hidden" name="pro_No" value="${proVO.pro_No}" >
									<input type="hidden" name="proCar_Price"  value="${dsPrice}">
									<input type="hidden" name="action" value="insertProTrack">
									<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
							</FORM></td>

							<%}else{%>
							
							<td style="padding-left: 100px; padding-top: 13px;">
								<a href="<%=request.getContextPath()%>/pro/proTrackServlet.do?action=deleteProTrack&pro_No=${proVO.pro_No}&mem_No=<%=mem_No%>&requestURL=<%=request.getServletPath()%>">
								<img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/heart.png"
								style="width: 50px;border-radius: 3px;"></a>已加入追蹤</td>

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
									<input type="text" class="proCar_Quantity" id="proCount" name="proCar_Quantity"
										value="1" style="width: 30px; text-align: center">
									<button type="button" id="addPro" style="width: 30px;">+</button>



<!-- 									<button type="submit" class="btn btn-warning addcar"  -->
<!-- 										style="width: 180px; margin: 5px; margin-left: 0px; font-size: 20px;border-radius: 5px;">放入購物車</button> -->
									<button type="button" class="btn btn-warning addcar" 
										style="width: 180px; margin: 5px; margin-left: 0px; font-size: 20px;border-radius: 5px;">放入購物車</button>
									
									<input type="hidden" class="proCar_No" name="proCar_No" value="${proVO.pro_No}">
									<input type="hidden" class="proCar_Name" name="proCar_Name" value="${proVO.pro_Name}"> 
									<input type="hidden" class="proCar_Info" name="proCar_Info" value="${proVO.pro_Info}"> 
									<input type="hidden" class="proCar_Price" name="proCar_Price" value="${dsPrice}">
									<input type="hidden" class="mem_NO" name="mem_NO" value="${memVO.mem_No}">
									<input type="hidden" class="requestURL" name="requestURL" value="<%=request.getServletPath()%>"> 
									<input type="hidden" class="action" name="action" value="addPro">
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

<script src="<%=request.getContextPath()%>/lib/publicfile/include/js/jquery.js"></script>
<script src="<%=request.getContextPath()%>/frontdesk/pro/jquery.fly.min.js" ></script>
<script src="<%=request.getContextPath()%>/lib/publicfile/include/js/sweetalert2.all.js"></script>


<script>

$(function() {
	var offset = $("#end").offset();
	$(".addcar").click(function(event){
		var addcar = $(this);
		var img = $(".proDiv").find('img').attr('src');
		var flyer = $('<img class="u-flyer" src="'+img+'">');
			flyer.fly({
				start: {
					left: event.pageX-300,
					top: event.pageY-250,
				},
				end: {
// 					left: offset.left+10,
// 					top: offset.top+10,
					left: offset.left-600,
					top: offset.top-60,
					width: 0,
					height: 0
				},
				onEnd: function(){
					$("#msg").show().animate({width: '250px'}, 200).fadeOut(1000);
// 					addcar.css("cursor","default").removeClass('orange').unbind('click');
					this.destory();
				}
			});
			
			var action = addcar.parent().find("input.action").val();
	    	var proCar_No = addcar.parent().find("input.proCar_No").val();
	    	var proCar_Name = addcar.parent().find("input.proCar_Name").val();
	    	var proCar_Info = addcar.parent().find("input.proCar_Info").val();
	    	var proCar_Price = addcar.parent().find("input.proCar_Price").val();
	    	var requestURL = addcar.parent().find("input.requestURL").val();
	    	var proCar_Quantity = addcar.parent().find("input.proCar_Quantity").val();
	     	var mem_NO = addcar.parent().find("input.mem_NO").val();
	    		
	     $.ajax({
	      type:"POST",
	      url:'<%=request.getContextPath()%>/pro/shoppingCartServlet.do',
	      data:"&action="+action+"&requestURL="+requestURL
	      	   +"&proCar_No="+proCar_No+"&proCar_Name="+proCar_Name+"&proCar_Info="+proCar_Info
	      	   +"&proCar_Price="+proCar_Price+"&proCar_Quantity="+proCar_Quantity,
//		      dataType: "json",
	      dataType: "text",
//	       cache: true,           // 預設值為 true 防止快取
//	       async: false,           // 預設值為 true 非同步
	      success:function(response){
	    	  
	       setTimeout(function(){location.reload()}, 1500) ;   //重新刷新              
	      }, // success end        
	      error:function(xhr, ajaxOptions, thrownError){
	       swal(
	         'Oops...',
	         '按太快囉!',
	         'error'
	       )
	      } // error end
	     }) //.ajax end 
			
		   
		});
   });
</script>
<!-- 購物車動畫	 -->
<div class="m-sidebar"> 
    <div class="cart"> 
        <i id="end"></i> 
<%--         <img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/1208499.gif">  --%>
    </div> 
</div> 
<div id="msg">已成功加入購物車！</div> 	
<!-- 購物車動畫		 -->

<div class="col-xs-12 col-sm-12">
	<jsp:include page="/lib/publicfile/include/file/footer2.jsp" flush="true"></jsp:include>
</div>	
</body>
</html>