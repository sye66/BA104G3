<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="com.pro.shoppingcart.*" %>
<%@ page import="com.pro.model.*"%>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

<style>
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

.cartPro{ 
	width:100%;
	border-bottom:3px #FFBA3B solid;
	margin:16px;
	background-color: #FFFFE8;
	padding:5px;
}
.breadcrumb li,.breadcrumb li a {
    color: #f90;
	font-size: 16px;   
}
th , td { 
text-align:center; 
/* 	border-bottom:3px orange double; */
/* 	border-right: 3px orange double; */
} 
.totalPrice2{
/* 	margin-left:500px; */
	color:red;
}
.price{
	color:red;
} 
</style>

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
<% 
	@SuppressWarnings("unchecked")
    Vector<ProCartVO> buylist = (Vector<ProCartVO>) session.getAttribute("shoppingcart");
	int quantity = 0;
	int count = 0;
	if(buylist != null && (buylist.size() > 0)){
		count = buylist.size();
	}
%>
<jsp:useBean id="proClassSvc" scope="page" class="com.proclass.model.ProClassService" />
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
							<button type="submit" class="btn btn-secondary" style="font-size:16px;"><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/resizeApi.png" style="height: 20px;">搜尋</button>
        					<input type="hidden" name="action" value="listPro_ByCompositeQuery">
						</td>	
					</tr>		
				</table>
			</FORM>	
		</div><!--搜尋結束 -->
		<!-- 購物車_通知 -->
		<div class="col-xs-12 col-sm-2 ">
				<span>&nbsp;&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/frontdesk/pro/cart.jsp"><img alt="購物車" src="<%=request.getContextPath()%>/res/images/pro_icons/cart01.gif" style="height: 40px;"></a></span>
			<span class="badge" ><%=count%></span>
			<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>					
			<span><a href="
<%-- 				<%=request.getContextPath()%>/frontdesk/pro/cart.jsp --%>
				">
				<img alt="通知" src="<%=request.getContextPath()%>/res/images/pro_icons/1183340.gif" style="height: 40px;"></a></span>					
<span class="badge" >10</span>	
		</div><!-- 購物車_通知 結束-->
		<div class="col-xs-12 col-sm-3"><!--空 --></div>
		
	</div><!--搜尋結束 12 -->


<div class="col-xs-12 col-sm-12 "><br></div>
<div class="col-xs-12 col-sm-6 col-sm-offset-3">
		<nav aria-label="breadcrumb" role="navigation">
  			<ol class="breadcrumb">
    			<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">首頁</a></li>
    			<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp">積分商城</a></li>
  				<li class="breadcrumb-item active">購物車</li>
  			
  			</ol>
		</nav>
</div>
<div class="col-xs-12 col-sm-6 col-sm-offset-3">



		<div role="tabpanel" >
			<!-- 標籤面板：標籤區 -->
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active">
					<a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab" style="width:400px;text-align:center;background-color:#FFFFBB;"><h4>購物車</h4></a></li>
				<li role="presentation">
					<a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab" style="width:400px;text-align:center;background-color:#96FFFF; "><h4>商品追蹤清單</h4></a></li>
			</ul>

			<!-- 標籤面板：內容區 -->
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="tab1">
<!-- 					<table class="table table-hover"> -->





<%if (buylist != null && (buylist.size() > 0)) {%>
	<%
	 double totalPrice=0;	
	 for (int index = 0; index < buylist.size(); index++) {
		 
		 ProCartVO order = buylist.get(index);
	%>
	<table class="cartPro">	
		<tr>
			<th>照片</th><th>品名</th><th >單價</th><th >數量</th><th>小計</th><th>異動</th>
		</tr>
		<tr height="30" >
			<td width="120"><img class="card-img-top" width="100"  src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=<%=order.getProCar_No()%>" alt="Card image cap"></td>
			<td width="100"><div align="center"><b><%=order.getProCar_Name()%></b></div></td>
		
			<td width="100"><div align="center" id="proPrice"><b>$<%=order.getProCar_Price()%></b></div></td>
			<td width="100">
				<div align="center">
					<button type="button" id="backPro"  style="width: 30px;">-</button>
					<input type="text" id="proCount" name="proCar_Quantity" value="<%=order.getProCar_Quantity()%>"  style="width: 30px;text-align:center">	
					<button type="button" id="addPro"  style="width: 30px;">+</button>
				</div>
			</td>
			<td width="100" class="price">
				<div align="center"><b id="totlPrice">$<%=order.getProCar_Price()*order.getProCar_Quantity()%></b></div>
			</td>
        	<td width="100"><div align="center">
           <form name="deleteForm"  action="<%=request.getContextPath()%>/pro/shoppingCartServlet.do" method="POST" style="margin-bottom: 0px;">
              <input type="hidden" name="action"  value="deletePro">
              <input type="hidden" name="del" value="<%= index %>">
              <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
              <button type="submit" class="btn btn-danger"><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/trash.png">移除</button>
          </form></div></td>
	</tr>
</table>	
	<%totalPrice=totalPrice+(order.getProCar_Price()*order.getProCar_Quantity()); }%>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-sm-3 col-sm-offset-3"><h1 class="" >共<%=buylist.size()%>項商品</h1></div>
			<div class="col-xs-12 col-sm-4"><h1 class="totalPrice2" >總計:$<%=totalPrice %></h1></div>
<!-- 			<div class="col-xs-12 col-sm-2"> -->
		</div>
	</div>
	
	
	
<p>
          <form name="checkoutForm" action="<%=request.getContextPath()%>/pro/shoppingCartServlet.do" method="POST" style="margin-bottom: 0px;">
              <input type="hidden" name="action"  value="checkOut"> 
              <button type="submit" class="btn btn-warning" style="width:100%;height:60px;margin:16px;font-size:30px">付款結帳</button>
        
          </form>
<% }else{%>
	<H1 Style="text-align:center;">尚無商品</H1>
<% }%>
<!-- 					</table> -->
				</div>
				<div role="tabpanel" class="tab-pane" id="tab2">
					<jsp:include page="/frontdesk/proTrack/listProTrack.jsp" flush="true" />	
				</div>
				

				</div>
			</div>
		</div>












			
<br>
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>


<script type="text/javascript">
	$(document).ready(function() {
		$("#backPro").click(function() {
			var proCount = $("#proCount").val() * 1;
			if (proCount > 1) {
				$("#proCount").val(proCount - 1);
// 				var pCount =$("#proCount").val() * 1;
// 				var pPrice =$("#proPrice").html() * 1;
// 				$("#totlPrice").html(pCount*pPrice);
			}
			
			
		});

		$("#addPro").click(function() {
			var proCount = $("#proCount").val() * 1;
			if (proCount < 10) {
				$("#proCount").val(proCount + 1);
// 				var pCount =$("#proCount").val() * 1;
// 				var pPrice =$("#proPrice").html() * 1;
// 				$("#totlPrice").html(pCount*pPrice);
			}
			
		});
	});

	
</script>


</body>
</html>