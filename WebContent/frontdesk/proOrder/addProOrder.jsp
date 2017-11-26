<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.proorder.model.*"%>
<%@ page import="com.pro.shoppingcart.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.pro.model.*"%>
<%@ page import="java.util.*"%>

<%
  MemVO memVO = (MemVO) session.getAttribute("memVO");		
  
%>
<html>
<head>
<title>訂單</title>

<style>
.cartPro3{ 
	text-align:center; 
	border:3px #FFBA3B solid;
	background-color: #FFFFE8;
	
}
.price{
	color:red;
} 
.totalPrice2{
	color:red;
}
tr th , td { 
text-align:center; 
/* 	border-bottom:3px orange double; */
/* 	border-right: 3px orange double; */
} 
</style>



</head>
<body>
<!-- TOP -->
<div class="row">
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/proNavbar.jsp" flush="true"/> 
<%-- <jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"></jsp:include> --%>
</div></div>
<!-- 商城TOP -->
<div class="col-xs-12 col-sm-12 ">
<jsp:include page="/frontdesk/pro/selectProTOP.jsp" flush="true" />	
</div>


<div class="col-xs-12 col-sm-6 col-sm-offset-3">
	<br>
		<nav aria-label="breadcrumb" role="navigation">
  			<ol class="breadcrumb">
    			<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">首頁</a></li>
    			<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp">積分商城</a></li>
  				<li class="breadcrumb-item active">購物車</li>
  			
  			</ol>
		</nav>
	
</div>
<!-- 進度條 -->
<div class="col-xs-12 col-sm-12">
<div class="col-xs-12 col-sm-6  col-sm-offset-3" >
		<table>
			<tr>
				<td>&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/res/images/pro_icons/resizeApi(1).png"></td>
				<td style="font-size:20px;text-align:center;height:24px;">購物車明細&nbsp;&nbsp;</td>
				<td><img src="<%=request.getContextPath()%>/res/images/pro_icons/arrows.png">&nbsp;&nbsp;</td>
				
				<td><img src="<%=request.getContextPath()%>/res/images/pro_icons/resizeApi(2).png"></td>
				<td style="font-size:20px;text-align:center;height:24px;">填寫訂單&nbsp;&nbsp;</td>
				<td><img src="<%=request.getContextPath()%>/res/images/pro_icons/arrows.png">&nbsp;&nbsp;</td>
				
				<td><img src="<%=request.getContextPath()%>/res/images/pro_icons/006-number-2.png"></td>
				<td style="font-size:20px;text-align:center;height:24px;">完成訂購</td>
			</tr>
		</table>
		<br>
	</div>

</div>	
<!-- 進度條 -->
<div class="col-xs-12 col-sm-3 col-sm-offset-3">
 


<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/pro/proOrderServlet.do" name="form1">

<br>
			<div class="form-group"><h3>姓名</h3>
            <input type="TEXT" name="ord_Consignee" size="36" placeholder="請輸入中文或英文姓名" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Name()%>" />
    		</div>
									
			<div class="form-group"><h3>市話號碼</h3>
            <input type="TEXT" name="mem_Tel" size="36" placeholder="EX:03-3345678" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Tel()%>" />
			</div>
			
			<div class="form-group"><h3>手機號碼</h3>
            <input type="TEXT" name="mem_Pho" size="36" placeholder="EX:0978978978" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Pho()%>" />
			
			</div>
			
			
<%----------------地址 -------------------------------------------%>



			<div class="form-group"><h3>通訊地址</h3>
            <input type="TEXT" name="ord_Address" size="36" placeholder="XXX路XXX巷XX弄XX號" class="form-control input-lg" tabindex="3"
			value="<%= (memVO==null)? "": memVO.getMem_Address()%>" />
			
			</div>
			
<%----------------地址 -------------------------------------------%>
		
	
			
			<input type="hidden" name="mem_No" value="<%=memVO.getMem_No()%>">
<%-- 			<input type="hidden" name="ord_Price" value="${totalPrice}"> --%>
			<input type="hidden" name="ord_Price" value="${totalPrice}">
			<input type="hidden" name="action" value="insert">
			<button type="submit" class="btn btn-success" style="font-size:26px;width:450px;border-radius: 5px;">確認送出訂單</button>
			</FORM>			
	
			
</div>		
<!-- 購物車瀏覽			 -->
<div class="col-xs-12 col-sm-3 ">
<br><br>
<table class="cartPro3">	
		<tr>
			<th>照片</th><th>品名</th><th>單價</th><th >數量</th><th>小計</th>
		</tr>
	<%
	int count= 0;
	
	@SuppressWarnings("unchecked")
	Vector<ProCartVO> buylist =  (Vector<ProCartVO>) session.getAttribute("shoppingcart");
	
	 if (buylist != null && (buylist.size() > 0)) {
		 count = buylist.size();
	 	Integer totalPrice=0;	
	 for (int index = 0; index < buylist.size(); index++) {
		 
		 ProCartVO order = buylist.get(index);
	%>
	
		<tr height="30" >
			<td width="120"><img class="card-img-top" width="100"  src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=<%=order.getProCar_No()%>" alt="Card image cap"></td>
			<td width="100"><div align="center"><b><%=order.getProCar_Name()%></b></div></td>
		
			<td width="100"><div align="center" id="proPrice">&nbsp;<span style="color:red;"><%=order.getProCar_Price()%></span>&nbsp;點
			</div></td>
			<td width="100">
				<div align="center">
					<%=order.getProCar_Quantity()%>	
				</div>
			</td>
			<td width="100" class="price">
			
				<div align="center">&nbsp;<span style="color:red;"><%=order.getProCar_Price()*order.getProCar_Quantity()%></span>&nbsp;點</div>
			</td>
			
			
          
	</tr>
		<tr><%totalPrice=totalPrice+(int)(order.getProCar_Price()*order.getProCar_Quantity()); }%>
        	
        	<td width="200" colspan="2">
        		<h3 >共<%=buylist.size()%>項商品</h3>
			
    		</td>
    		<td width="200" colspan="3">
    		
    			<h3 >總計扣除:&nbsp;<span style="color:red;">${totalPrice}</span>&nbsp;點</h3>
    		</td>
    	</tr>
    	
</table>	
	
<%}%>	
	 
</div>	  


<div class="col-xs-12 col-sm-12">
	<jsp:include page="/lib/publicfile/include/file/footer2.jsp" flush="true"></jsp:include>
</div>		
</body>
</html>