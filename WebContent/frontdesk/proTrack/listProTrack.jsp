<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.protrack.model.*" %>
<%@ page import="com.pro.model.*" %>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

 
<style>

.cartPro2{ 
	width:100%;
	border-bottom:3px #0000E6 solid;
	margin:16px;
	background-color: #DEFFFF;
	padding:5px;
}
.breadcrumb li,.breadcrumb li a {
    color: #f90;
	font-size: 16px;   
}
th  {
	text-align:center;

}

.price{
	color:red;
} 
</style>



</head>
<body>

			
<br>
<% 
	ProTrackService proTrackSvc = new ProTrackService();
	String mem_No = "M000001";
	List<ProTrackVO> listProTrack = proTrackSvc.getOnePro(mem_No);
	ProService proSvc = new ProService();
   	ProVO proVO = null;
%>
<%if (listProTrack != null && (listProTrack.size() > 0)) {%>
	<%
	 for (int index = 0; index < listProTrack.size(); index++) {
		 ProTrackVO proTrackVO = listProTrack.get(index);
		 String pro_No = proTrackVO.getPro_No();
		 proVO= proSvc.getOnePro(pro_No);
		 //算折扣價
		 double price = proVO.getPro_Discount()*proVO.getPro_Price()/100; 
	%>
<table class="cartPro2">	
	<tr>
		<th>照片</th><th>品名</th><th >單價</th><th colspan="2"></th>
	</tr>
	<tr height="30" >
		<td width="120"><img class="card-img-top" width="100"  src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=<%=proVO.getPro_No()%>" alt="Card image cap"></td>
		<td width="100"><div align="center"><b><%=proVO.getPro_Name()%></b></div></td>
		
		<td width="100"><div align="center"><b>$<%=price%></b></div></td>
		
		<td width="100"><div align="center">
		<form METHOD="post"   ACTION="<%=request.getContextPath()%>/pro/shoppingCartServlet.do" >
			<button type="submit" class="btn btn-warning" style="width: 100px;font-size:16px;">放入購物車</button>
			<input type="hidden" name="proCar_No"  value="<%=pro_No%>">
			<input type="hidden" name="mem_No"  value="<%=mem_No%>">
			<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			<input type="hidden" name="action"	value="addPro2">	
		</form></div>
		</td>
		
		
        <td width="100"><div align="center">
          <form name="deleteForm" action="<%=request.getContextPath()%>/pro/proTrackServlet.do" method="POST" >
              <input type="hidden" name="action"  value="deleteProTrack">
              <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
              <input type="hidden" name="pro_No"  value="<%=pro_No%>">
              <input type="hidden" name="mem_No" value="<%=mem_No%>">
              <button type="submit" class="btn btn-danger"><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/trash.png" style="height: 20px;">移除</button>
          </form></div>
        </td>
	</tr>
</table>	
	<% }%>
	
<p>
         
<% }else{%>
	<H1 Style="text-align:center;">尚無商品</H1>
<% }%>


</body>
</html>