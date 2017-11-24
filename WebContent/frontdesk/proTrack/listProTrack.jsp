<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.protrack.model.*" %>
<%@ page import="com.pro.model.*" %>
<%@ page import="com.mem.model.*" %>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

 
<style>

.cartPro2{ 
	width:918px;
	border-bottom:3px #FFBA3B solid;
	border-left:1px #CCC solid;
	border-right:1px #CCC solid;
	background-color: #DEFFFF;
	
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



<% 
	MemVO memVO = (MemVO) session.getAttribute("memVO");
	String mem_No = null;
	List<ProTrackVO> listProTrack = null;
	if(session.getAttribute("memVO")!=null){
		mem_No = memVO.getMem_No();
System.out.println("session取得的會員編號 "+mem_No);
		ProTrackService proTrackSvc = new ProTrackService();
		listProTrack = proTrackSvc.getOnePro(mem_No);
	}
	
%>
<%

	ProService proSvc = new ProService();
	ProVO proVO = null;
	if (listProTrack != null && (listProTrack.size() > 0)) {%>
	<%
	 for (int index2 = 0; index2 < listProTrack.size(); index2++) {
		 ProTrackVO proTrackVO = listProTrack.get(index2);
		 String pro_No = proTrackVO.getPro_No();
		 proVO= proSvc.getOnePro(pro_No);
		 //算折扣價
		 Integer price =(int) proVO.getPro_Discount()*proVO.getPro_Price()/100; 
	%>
<table class="cartPro2">	
	<tr>
		<th>照片</th><th>品名</th><th >單價</th><th colspan="2">更動</th>
	</tr>
	<tr height="30" >
		<td width="120"><img class="card-img-top" width="100"  src="<%=request.getContextPath()%>/tool/showimage.do?action=propic&pro_No=<%=proVO.getPro_No()%>" alt="Card image cap"></td>
		<td width="100"><div align="center"><b><%=proVO.getPro_Name()%></b></div></td>
		
		<td width="100"><div align="center"><b><%=price%></b>點</div></td>
		
		<td width="100"><div align="center">
		<form METHOD="post"   ACTION="<%=request.getContextPath()%>/pro/shoppingCartServlet.do" >
			
			<input type="hidden" class="proCar_No"  value="<%=pro_No%>">
			<input type="hidden" class="mem_No"  value="<%=mem_No%>">
			<input type="hidden" class="requestURL" value="<%=request.getServletPath()%>">
			<input type="hidden" class="action"	value="addPro2">	
			<button type="button" class="btn btn-warning add2" style="width: 100px;font-size:16px;">放入購物車</button>
		</form></div>
		</td>
		
		
        <td width="100"><div align="center">
          <form name="deleteForm" action="<%=request.getContextPath()%>/pro/proTrackServlet.do" method="POST" >
              <input type="hidden" class="action" name="action"  value="deleteProTrack">
              <input type="hidden" class="requestURL" value="<%=request.getServletPath()%>">
              <input type="hidden" class="pro_No"  value="<%=pro_No%>">
              <input type="hidden" class="mem_No" value="<%=mem_No%>">
              <button type="button" class="btn btn-danger deletBtn2"><img alt="" src="<%=request.getContextPath()%>/res/images/pro_icons/trash.png" style="height: 20px;">移除</button>
          </form></div>
        </td>
	</tr>
</table>	
	<% }%>
	
<p>
         
<% }else{%>
	<H1 Style="text-align:center;">尚無商品</H1>
<% }%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.11.5/sweetalert2.all.js"></script>

<script type="text/javascript">
$(document).ready(function(){
  $( ".deletBtn2" ).on( "click", function( event ) {
         var $item = $( this );         
         swal({
      title: 'Are you sure?',
      text: "確定刪除商品嗎?",
      type: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#3085d6',
      cancelButtonColor: '#d33',
      confirmButtonText: 'Yes!',
      confirmButtonClass: 'btn btn-success',
      cancelButtonClass: 'btn btn-danger'      
    }).then(function () {
     	
    	var action = $item.parent().find("input.action").val();
    	var requestURL = $item.parent().find("input.requestURL").val();
    	var pro_No = $item.parent().find("input.pro_No").val();
    	var mem_No = $item.parent().find("input.mem_No").val();
     $.ajax({
      type:"POST",
      url:'<%=request.getContextPath()%>/pro/proTrackServlet.do',
      data: "&action="+action+"&requestURL="+requestURL+"&pro_No="+pro_No+"&mem_No="+mem_No,
//      dataType: "json",
      dataType: "text",
//       cache: true,           // 預設值為 true 防止快取
//       async: false,           // 預設值為 true 非同步
      success:function(response){
       swal(
        'Sucess!',
        '已刪除此商品追蹤',
        'success'
       )
       setTimeout(function(){location.reload()}, 1500) ;   //重新刷新              
      }, // success end        
      error:function(xhr, ajaxOptions, thrownError){
       swal(
         'Oops...',
         '出錯瞜!',
         'error'
       )
      } // error end
     }) //.ajax end 
    }); //then end
         
       }); //click end
 });//document ready end

</script>

<script type="text/javascript">
$(document).ready(function(){
  $( ".add2" ).on( "click", function( event ) {
         var $item = $( this );         
         swal(
        	 'Sucess!',
             '已放入購物車',
             'success'      
           ).then(function () {
     	
    	var action = $item.parent().find("input.action").val();
    	var requestURL = $item.parent().find("input.requestURL").val();
    	var proCar_No = $item.parent().find("input.proCar_No").val();
    	var mem_No = $item.parent().find("input.mem_No").val();
     $.ajax({
      type:"POST",
      url:'<%=request.getContextPath()%>/pro/shoppingCartServlet.do',
      data: "&action="+action+"&requestURL="+requestURL+"&proCar_No="+proCar_No+"&mem_No="+mem_No,
//      dataType: "json",
      dataType: "text",
//       cache: true,           // 預設值為 true 防止快取
//       async: false,           // 預設值為 true 非同步
      success:function(response){
       
       setTimeout(function(){location.reload()}, 500) ;   //重新刷新              
      }, // success end        
      error:function(xhr, ajaxOptions, thrownError){
       swal(
         'Oops...',
         '出錯瞜!',
         'error'
       )
      } // error end
     }) //.ajax end 
    }); //then end
   }); //click end
 });//document ready end

</script>
</body>
</html>