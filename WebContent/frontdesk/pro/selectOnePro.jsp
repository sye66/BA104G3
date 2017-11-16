<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.pro.model.*"%>
<%@ page import="com.protrack.model.*"%>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
	<!--搜尋 12-->
	<div class="col-xs-12 col-sm-12 " id="ontopDiv">
		<!--搜尋 -->
		<div class="col-xs-12 col-sm-4 col-sm-offset-3">
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/pro.do" name="form1">
				<table >
					<tr style="font-size:20px;text-align:center;">
			      	    <td style="width:200px;"></td>	
						<td><select size="1" name="pro_Class_No" style="height: 36px;">
         					   <option value="">分類
        					   <c:forEach var="proClassVO" items="${proClassSvc.all}" > 
        					   <option value="${proClassVO.pro_Class_No}">${proClassVO.pro_Class_Name}
        				 	   </c:forEach>   
       						</select>
						</td>
						<td>
							<input type="text" name="pro_Name" value="" placeholder="請輸入商品關鍵字" style="height: 36px;marager-top:0px;">
						</td>	
						<td>
							<button type="submit" class="btn btn-secondary" style="font-size:16px;"><img alt="" src="../res/images/pro_icons/resizeApi.png" style="height: 20px;">搜尋</button>
        					<input type="hidden" name="action" value="listPro_ByCompositeQuery">
						</td>	
					</tr>		
				</table>
			</FORM>	
		</div><!--搜尋結束 -->
		<!-- 購物車_通知 -->
		<div class="col-xs-12 col-sm-2 ">
				<span>&nbsp;&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/frontdesk/pro/cart.jsp"><img alt="購物車" src="../res/images/pro_icons/cart01.gif" style="height: 40px;"></a></span>
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>					
			<span><a href="
<%-- 				<%=request.getContextPath()%>/frontdesk/pro/cart.jsp --%>
				">
				<img alt="通知" src="../res/images/pro_icons/1183340.gif" style="height: 40px;"></a></span>					
		</div><!-- 購物車_通知 結束-->
		<div class="col-xs-12 col-sm-3"><!--空 --></div>
		
	</div><!--搜尋結束 12 -->
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
									<p class="proPrice">折扣價:$${(proVO.pro_Price)*(proVO.pro_Discount)/100}</p>
								</c:if></td>
						</tr>


						<tr>
							<%
								// 					HttpSession session = req.getSession();
								// 					MemVO memVO = (MemVO)session.getAttribute("register_memVO");
								// 	目前寫死M000001
								// 					String mem_No = memVO.getMem_no();
								String mem_No = "M000001";
								ProTrackService proTrackSvc = new ProTrackService();
								List<ProTrackVO> list = proTrackSvc.getOnePro(mem_No);
								List<String> list2 = new ArrayList<String>();
								for (ProTrackVO p : list) {
									list2.add(p.getPro_No());

								}

								ProVO proVO = (ProVO) request.getAttribute("proVO");
								String pro_No = proVO.getPro_No();

								if (!list2.contains(pro_No)) {
								
							%>


							<td style="padding-left: 130px; padding-top: 13px;">
							<FORM METHOD="post" style="height: 42px; width: 180px;" ACTION="<%=request.getContextPath()%>/pro/proTrackServlet.do">
									<button type="submit" class="btn btn-Secondary" 
											style="width: 180px; margin-top: 5px; font-size: 20px;">加入追蹤清單</button>
									<input type="hidden" name="pro_No" value="${proVO.pro_No}" 
											type="hidden" name="proCar_Price"
										    value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}">
									<input type="hidden" name="action" value="insertProTrack">
									<input type="hidden" name="requestURL"
											value="<%=request.getServletPath()%>">
							</FORM></td>

							<%}else{%>
							
							<td style="padding-left: 130px; padding-top: 13px;">
								<img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/heart.png"
								style="width: 50px;">已加入追蹤</td>

							<%}%>
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
									<input type="hidden" name="proCar_Price" value="${(proVO.pro_Price)*(proVO.pro_Discount)/100}">
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