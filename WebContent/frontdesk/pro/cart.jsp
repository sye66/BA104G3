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
<title>工具人出租</title>

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
<body >
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

<div class="row">
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/proNavbar.jsp" flush="true"/> 
</div></div>
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
				<td>&nbsp;<img src="<%=request.getContextPath()%>/res/images/pro_icons/resizeApi(1).png"></td>
				<td style="font-size:20px;text-align:center;height:24px;width:110px;">購物車明細</td>
				<td>&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/res/images/pro_icons/arrows.png">&nbsp;&nbsp;</td>
				
				<td><img src="<%=request.getContextPath()%>/res/images/pro_icons/004-number-1.png"></td>
				<td style="font-size:20px;text-align:center;height:24px;width:110px;">填寫訂單&nbsp;&nbsp;</td>
				<td><img src="<%=request.getContextPath()%>/res/images/pro_icons/arrows.png">&nbsp;&nbsp;</td>
				
				<td><img src="<%=request.getContextPath()%>/res/images/pro_icons/006-number-2.png"></td>
				<td style="font-size:20px;text-align:center;height:24px;width:110px;">完成訂購</td>
				<td style="width:100px;"></td>
				<td><h3>您目前擁有積分共:&nbsp;<span style="color:red;font-size:36px;" id="haveMoney"><%=memVO.getMem_Point()%></span>&nbsp;點</h3></td>
			</tr>
		</table>
		<br>
		
	</div>


		<div role="tabpanel" >
			<!-- 標籤面板：標籤區 -->
			<ul class="nav nav-tabs" role="tablist">
				<li role="presentation" class="active">
					<a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab" style="width:457px;text-align:center;background-color:#FFFFBB;border:1px 1px 1px 1px #CCC solid;"><h4>購物車(<%=count%>)</h4></a></li>
				<li role="presentation">
					<a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab" style="width:457px;text-align:center;background-color:#96FFFF;border:1px 1px 1px 1px #CCC solid;"><h4>商品追蹤清單(<%=count2%>)</h4></a></li>
			</ul>

			<!-- 標籤面板：內容區 -->
			<div class="tab-content" style="width:100%;">
			
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
	<table class="cartPro" id="tab001" style="width:100%;">	
		<tr>
			<th>照片</th><th>品名</th><th >單價</th><th >數量</th><th>小計</th><th>更動</th>
		</tr>
		<tr height="30" >
		
			<td width="120px">
				<img class="card-img-top" width="100"  src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=<%=order.getProCar_No()%>" alt="Card image cap"></td>
			<td width="100px">
				<div align="center"><b><%=order.getProCar_Name()%></b></div></td>
			<td width="70px">
				<div align="center" id="proPrice"><span class="price0001"><%=order.getProCar_Price()%></span>點</div></td>
			<td width="100px">
				<div align="center">
					<button type="button" class="min" style="width: 30px;">-</button>
					<input type="text" class="text_box" name="proCar_Quantity" value="<%=order.getProCar_Quantity()%>"  style="width: 30px;text-align:center">	
					<input   type="hidden" class="pro_No"  value="<%=order.getProCar_No()%>">
					<button type="button"  class="add"  style="width: 30px;">+</button>
				</div>	
			</td>
			<td width="100px">
				<div>&nbsp;<span style="color:red;" class="minPrice" id="minPrice"><%=order.getProCar_Price()*order.getProCar_Quantity()%></span>&nbsp;點</div>
			</td>
			
        	<td width="100"><div align="center">
           <form name="deleteForm"  action="<%=request.getContextPath()%>/pro/shoppingCartServlet.do" method="POST" style="margin-bottom: 0px;">
              <input type="hidden" name="action"  value="deletePro">
              <input type="hidden" class="del" name="del" value="<%= index %>">
               
              <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
              <button type="button" class="btn btn-danger deletBtn" value="<%= index %>"><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/trash.png">移除</button>
<%--               <button type="submit" class="btn btn-danger "><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/trash.png">移除</button> --%>
          </form></div></td>
	</tr>
</table>	
	<%totalPrice=totalPrice+(int)(order.getProCar_Price()*order.getProCar_Quantity()); }%>
	<div class="container">
		<div class="row">           
			<div class="col-xs-12 col-sm-3 col-sm-offset-3"><h3>共&nbsp;<span style="color:red;"><%=buylist.size()%></span>&nbsp;項商品</h3></div>
			<div class="col-xs-12 col-sm-4"><h3>總計:&nbsp;<span style="color:red;" id="total"><%=totalPrice%></span>&nbsp;點</h3></div>
<!-- 			<div class="col-xs-12 col-sm-2"> -->
		</div>
	</div>
			<form name="checkoutForm" action="<%=request.getContextPath()%>/frontdesk/stored_history/rechage_credit.jsp" method="POST" style="margin-bottom: 0px;">
              
              <button id="noMoney" type="submit" class="btn btn-danger" style="width:100%;height:60px;font-size:30px;display:none;">請儲值</button>
          </form>
			
	

          <form name="checkoutForm" action="<%=request.getContextPath()%>/pro/shoppingCartServlet.do" method="POST" style="margin-bottom: 0px;">
              <input   type="hidden" name="action"  value="checkOut"> 
             
              <button id="checkOut" type="submit" class="btn btn-warning" style="width:100%;height:60px;font-size:30px;display:none;">付款結帳</button>
        
          </form>
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

<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.5/sweetalert2.all.js"></script>
<script type="text/javascript">
$(function(){
	var qun = 0;
	var pro_No = "";
	$(".add").click(function(){  
		var t = $(this).parent().find('input.text_box'); 
        t.val(parseInt(t.val())+1);
       
        qun = parseInt(t.val());
        
        pro_No = $(this).parent().find("input.pro_No").val();
        
    	var price = $(this).parent().parent().parent().find("span.price0001").text();
    	var minPrice =$(this).parent().parent().parent().find("span.minPrice");	  
    	var sum = t.val()*price;	
    		minPrice.text(sum);
    		setTotal();
	    })  
	  
	    $(".min").click(function(){  
	    	var  t = $(this).parent().find("input.text_box");  
	        t.val(parseInt(t.val())-1);  
	        if(parseInt(t.val())<1){  
	            t.val(1);  
	        }
	        
	        qun = parseInt(t.val());
	        if(qun<1){  
	            qun=1;  
	        }
	        
	        pro_No = $(this).parent().find("input.pro_No").val();
	        
	        var price = $(this).parent().parent().parent().find("span.price0001").text();
		    var minPrice =$(this).parent().parent().parent().find("span.minPrice");	  
		    var sum = t.val()*price;	
		    	minPrice.text(sum);	
		    	setTotal();
	    })  
	    function setTotal(){  
        var sum = 0;  
        var haveMoney = $("#haveMoney").text(); 
         $("#tab001 tr td ").each(function(){  
          
        var a =  $(this).find("span[class*=minPrice]").text();
        if(!isNaN(parseInt(a))){
        	  sum += parseInt(a);
        }
       
        if(sum>haveMoney){
        	$("#noMoney").css('display', 'initial');
        	$("#checkOut").css('display', 'none');
        }
        if(sum<=haveMoney){
        	$("#checkOut").css('display', 'initial');
        	$("#noMoney").css('display', 'none');
        	
        }
        
        })  
        $("#total").html(sum.toFixed(0));
         
        if(!pro_No==""){
     	
         $.ajax({
             type:"POST",
             url:'<%=request.getContextPath()%>/pro/shoppingCartServlet.do',
             data:"&action="+'changePro'+"&pro_No="+pro_No+"&qun="+qun, 
//             dataType: "json",
             dataType: "text",
//              cache: true,           // 預設值為 true 防止快取
//              async: false,           // 預設值為 true 非同步
             success:function(response){
             
             }, // success end        
             error:function(xhr, ajaxOptions, thrownError){
//               swal(
//                 'Oops...',
//                 '出錯瞜!',
//                 'error'
//               )
             } // error end
            }) //.ajax end 
        }//if 
    }  
    setTotal();  
	}) 
</script>

<script type="text/javascript">
$(document).ready(function(){
  $( ".deletBtn" ).on( "click", function( event ) {
         var $item = $( this );         
         swal({
      text: "確定刪除商品嗎?",
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes!',
      confirmButtonClass: 'btn btn-success',
      cancelButtonClass: 'btn btn-danger'      
    }).then(function () {
     $.ajax({
      type:"POST",
      url:'<%=request.getContextPath()%>/pro/shoppingCartServlet.do?action=deletePro&del='+$item.val(),
//       data: $( "#formSchdule" ).serialize(),
//      dataType: "json",
      dataType: "text",
//       cache: true,           // 預設值為 true 防止快取
//       async: false,           // 預設值為 true 非同步
      success:function(response){
       swal(
        '已刪除此商品',
        
       )
       setTimeout(function(){location.reload()}, 1500) ;   //重新刷新              
      }, // success end        
      error:function(xhr, ajaxOptions, thrownError){
       swal(
         '按太快瞜!',
         'error'
       )
      } // error end
     }) //.ajax end 
    }); //then end
         
       }); //click end
 });//document ready end

</script>





<div class="col-xs-12 col-sm-12">
<br><br><br><br>
		<jsp:include page="/lib/publicfile/include/file/footer2.jsp" flush="true"></jsp:include>
</div>	
</body>
</html>