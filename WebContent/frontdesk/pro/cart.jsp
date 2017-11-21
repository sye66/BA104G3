<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.pro.shoppingcart.*"%>
<%@ page import="com.protrack.model.*" %>
<%@ page import="com.pro.model.*"%>
<%@ page import="com.proorder.model.*"%>
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
	width:918px;
	border-bottom:3px #FFBA3B solid;
	border-left:1px #CCC solid;
	border-right:1px #CCC solid;
	background-color: #FFFFE8;
	
}
.breadcrumb li,.breadcrumb li a {
    color: #f90;
	font-size: 16px;   
}
th , td { 
text-align:center; 

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
	int count = 0;
	int count2 = 0;
	int count3 = 0;
	MemVO memVO =(MemVO) session.getAttribute("memVO");
	
	if(session.getAttribute("memVO")!=null){

		String mem_No =	memVO.getMem_No();
	
	
	//追蹤
	
	ProTrackService proTrackSvc = new ProTrackService();
	List<ProTrackVO> listProTrack = proTrackSvc.getOnePro(mem_No);
	if(listProTrack != null && (listProTrack.size() > 0)){
		count2 = listProTrack.size();
	
	}
	//清單

	ProOrderService proOrderSvc = new ProOrderService();
	List<ProOrderVO> listProOrder = proOrderSvc.listProOrder(mem_No);
	if(listProOrder != null && (listProOrder.size() > 0)){
		count3 = listProOrder.size();
		
	 }
	}	
	
	ProService proSvc = new ProService();
	List<ProVO> list = proSvc.getAll();
	@SuppressWarnings("unchecked")
	Vector<ProCartVO> buylist =  (Vector<ProCartVO>) session.getAttribute("shoppingcart");
	
	if(buylist != null && (buylist.size() > 0)){
		count = buylist.size();
	}
%>
<jsp:useBean id="proClassSvc" scope="page" class="com.proclass.model.ProClassService" />

<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/proNavbar.jsp" flush="true"/> 
</div>
<!-- 商城TOP -->
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/selectProTOP.jsp" flush="true" />	
</div>

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
<div class="col-xs-12 col-sm-12 " >
		<table>
			<tr>
				<td>&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/res/images/pro_icons/resizeApi(1).png"></td>
				<td style="font-size:20px;text-align:center;height:24px;">購物車明細&nbsp;&nbsp;</td>
				<td><img src="<%=request.getContextPath()%>/res/images/pro_icons/arrows.png">&nbsp;&nbsp;</td>
				
				<td><img src="<%=request.getContextPath()%>/res/images/pro_icons/004-number-1.png"></td>
				<td style="font-size:20px;text-align:center;height:24px;">填寫訂單&nbsp;&nbsp;</td>
				<td><img src="<%=request.getContextPath()%>/res/images/pro_icons/arrows.png">&nbsp;&nbsp;</td>
				
				<td><img src="<%=request.getContextPath()%>/res/images/pro_icons/006-number-2.png"></td>
				<td style="font-size:20px;text-align:center;height:24px;">完成訂購</td>
				<td style="width:100px;"></td>
				<td><h3>您目前擁有積分共:&nbsp;<span style="color:red;font-size:36px;"><%=memVO.getMem_Point()%></span>&nbsp;點</h3></td>
			</tr>
		</table>
		<br>
		
	</div>


		<div role="tabpanel" >
			<!-- 標籤面板：標籤區 -->
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active">
					<a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab" style="width:458px;text-align:center;background-color:#FFFFBB;border:1px 1px 1px 1px #CCC solid;"><h4>購物車(<%=count%>)</h4></a></li>
				<li role="presentation">
					<a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab" style="width:458px;text-align:center;background-color:#96FFFF;border:1px 1px 1px 1px #CCC solid;"><h4>商品追蹤清單(<%=count2%>)</h4></a></li>
			</ul>

			<!-- 標籤面板：內容區 -->
			<div class="tab-content">
				<div role="tabpanel" class="tab-pane active" id="tab1">
<!-- 					<table class="table table-hover"> -->





<%if (buylist != null && (buylist.size() > 0)) {%>
	<%
	int i=0;
	 Integer totalPrice=0;	
	 for (int index = 0; index < buylist.size(); index++) {
		 i++;
		 ProCartVO order = buylist.get(index);
	%>
	<table class="cartPro" id="tab">	
		<tr>
			<th>照片</th><th>品名</th><th >單價</th><th >數量</th><th>小計</th><th>更動</th>
		</tr>
		<tr height="30" >
			<td width="120"><img class="card-img-top" width="100"  src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=<%=order.getProCar_No()%>" alt="Card image cap"></td>
			<td width="100"><div align="center"><b><%=order.getProCar_Name()%></b></div></td>
		
			<td width="100"><div align="center" id="proPrice"><span class="price"><%=order.getProCar_Price()%></span>點</div></td>
			<td width="100">
				<div align="center">
					<button type="button" class="min" style="width: 30px;">-</button>
					<input type="text" class="text_box" name="proCar_Quantity" value="<%=order.getProCar_Quantity()%>"  style="width: 30px;text-align:center">	
					<button type="button"  class="add"  style="width: 30px;">+</button>
				</div>
			</td>
			<td width="100">
				<div>&nbsp;<span style="color:red;" id="minPrice"><%=order.getProCar_Price()*order.getProCar_Quantity()%></span>&nbsp;點</div>
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
	<%totalPrice=totalPrice+(int)(order.getProCar_Price()*order.getProCar_Quantity()); }%>
	<div class="container">
		<div class="row">           
			<div class="col-xs-12 col-sm-3 col-sm-offset-3"><h3>共&nbsp;<span style="color:red;"><%=buylist.size()%></span>&nbsp;項商品</h3></div>
			<div class="col-xs-12 col-sm-4"><h2>總計:&nbsp;<span style="color:red;" id="total"><%=totalPrice%></span>&nbsp;點</h2></div>
<!-- 			<div class="col-xs-12 col-sm-2"> -->
		</div>
	</div>
		<%if(memVO.getMem_Point()<totalPrice){%>
			<form name="checkoutForm" action="<%=request.getContextPath()%>/frontdesk/stored_history/rechage_credit.jsp" method="POST" style="margin-bottom: 0px;">
              
              <button type="submit" class="btn btn-danger" style="width:100%;height:60px;font-size:30px">請儲值</button>
          </form>
		<%}else{ %>
			
	

          <form name="checkoutForm" action="<%=request.getContextPath()%>/pro/shoppingCartServlet.do" method="POST" style="margin-bottom: 0px;">
              <input type="hidden" name="action"  value="checkOut"> 
              <button type="submit" class="btn btn-warning" style="width:100%;height:60px;font-size:30px">付款結帳</button>
        
          </form>
          <%} %>
<% }else{%>
	<H1 Style="text-align:center;background-color:#FFFFBB;">尚無商品<a href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp">快到商城購物</a></H1>
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
// $(function(){   
// 	$(".add").click(function(){  
// 	        var t = $(this).parent().find('input[class*=text_box]'); 
// 	        t.val(parseInt(t.val())+1); 
// 	        setTotal();  
// 	    })  
	  
// 	    $(".min").click(function(){  
// 	        var t = $(this).parent().find("input[class*=text_box]");  
// 	        t.val(parseInt(t.val())-1);  
// 	        if(parseInt(t.val())<0){  
// 	            t.val(0);  
// 	        }  
// 	        setTotal()  
// 	    })  
	      
// 	    function setTotal(){  
// 	        var sum = 0;  
// 	        $("#tab td").each(function(){  
	          
// 	        var num = parseInt($(this).find("input[class*=text_box]").val()); 
// 	        var price = parseInt($(this).find("span[class*=price]").text());  
// 	        price=price*1;
// 	        console.log("num="+num+!isNaN(num));
// 	        console.log("price="+price+!isNaN(price));
// 	        console.log("===================");
// 	        	if(isNaN(num)){
//         			num=1;	
//         		}
// 	        	if(isNaN(price)){
// 	        		price=1;
// 	        	}
// 	        	sum += num*price;
	        
// 	        })  
// 	        $("#total").html(sum.toFixed(0));  
// 	    }  
// 	    setTotal();  
	  
// 	})   
</script>
<br><br>
</body>
</html>