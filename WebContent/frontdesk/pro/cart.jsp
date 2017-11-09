<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.pro.shoppingcart.*" %>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

 
<style>

.cartPro{ 
	
	border:3px orange double;
	margin:16px;
	background-color: #FFFFFF;
	padding:5px;
}
.breadcrumb li,.breadcrumb li a {
    color: #f90;
	font-size: 16px;   
}
th , td {
	text-align:center;
	border-bottom:3px orange double;
	border-right: 3px orange double;
}
 
</style>

</head>
<body>
<br>
<div class="col-xs-12 col-sm-11 col-sm-offset-1">
		<nav aria-label="breadcrumb" role="navigation">
  			<ol class="breadcrumb">
    			<li class="breadcrumb-item"><a href="#">首頁</a></li>
    			<li class="breadcrumb-item"><a href="<%=request.getContextPath()%>/frontdesk/pro/showProIndex.jsp">積分商城</a></li>
  			</ol>
		</nav>
</div>			
<br>
<% @SuppressWarnings("unchecked")
   Vector<ProCartVO> buylist = (Vector<ProCartVO>) session.getAttribute("shoppingcart");%>
<%if (buylist != null && (buylist.size() > 0)) {%>



       
	<%
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
		
		<td width="100"><div align="center"><b><%=order.getProCar_Price()%></b></div></td>
		<td width="100"><div align="center"><b><%=order.getProCar_Quantity()%></b></div></td>
		<td width="100"><div align="center"><b><%=order.getProCar_Price()*order.getProCar_Quantity()%></b></div></td>
        <td width="100"><div align="center">
          <form name="deleteForm" action="<%=request.getContextPath()%>/pro/shoppingCartServlet.do" method="POST" style="margin-bottom: 0px;">
              <input type="hidden" name="action"  value="deletePro">
              <input type="hidden" name="del" value="<%= index %>">
              <button type="submit" class="btn btn-danger">刪除</button>
          </form></div></td>
	</tr>
</table>	
	<%}%>

<p>
          <form name="checkoutForm" action="<%=request.getContextPath()%>/pro/shoppingCartServlet.do" method="POST" style="margin-bottom: 0px;">
              <input type="hidden" name="action"  value="checkOut"> 
              <button type="submit" class="btn btn-warning" style="width:300px;hight:100px;margin-left:200px">付款結帳</button>
        
          </form>
<%}%>
</body>
</html>