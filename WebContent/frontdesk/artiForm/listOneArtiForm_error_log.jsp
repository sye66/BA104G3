<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.artiForm.model.*"%>
<%@ page import="com.artiClass.model.*"%>
<%@ page import="com.artiReply.model.*"%>
<%@ page import="com.artiReport.model.*"%>
<%@ page import="com.mem.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<jsp:useBean id="artiFormSvc" scope="session" class="com.artiForm.model.ArtiFormService" />
<jsp:useBean id="artireplySvc" scope="page" class="com.artiReply.model.ArtiReplyService" />
<%-- 取出 Controller ArtiFormServlet.java已存入request的ArtiFormVO物件--%>
<%
  //ArtiFormServlet.java(Concroller), 存入req的ArtiFormVO物件
    ArtiFormVO artiFormVO = (ArtiFormVO) request.getAttribute("artiFormVO"); 
    ArtiReplyVO artiReplyVO =new ArtiReplyVO();
    ArtiReportVO artiReportVO = new ArtiReportVO();
	String arti_No = (String) session.getAttribute("arti_No");
	String mem_No = (String) session.getAttribute("mem_No");
%>
<%-- 取出 對應的ArtiClassVO物件--%>

<html>
<head>
<title>文章資料 - listOneArtiFrom_Test.jsp</title>
	<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />
	<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/post.min.css" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<html xmlns="http://www.w3.org/1999/xhtml">
<style>
div {
  word-wrap:break-word;
  word-break:normal;
}

  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>


</head>
<body bgcolor='white'>

<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true" />

<h4></h4>
<table id="table-1">
	<tr><td>
		 <h3>文章資料 - ListOneArtiFrom_ERROR.jsp    ${ arti_No}</h3>
		 <h4><a href="/BA104G3/frontdesk/artiForm/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>
<hr>
<hr>
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" name="form1" enctype="multipart/form-data">
<div class="container">
<div class="col-xs-12 col-sm-11 widget-container-span">
    <div class="widget-box">
    
        <div class="widget-header header-color-dark">
            <h5 class="bigger lighter">${artiFormVO.arti_Title}</h5>
            <div class="widget-toolbar">
                <div class="" style="width:100px;">
                    <div class="" style="">
                    <jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService"/>
                      ${artiClassSvc.getOneClass(artiFormVO.arti_Cls_No).arti_Cls_Name}
                    </div>
                </div>
             </div>
             <div class="widget-toolbar">
                 <div class="" style="width:100px;">
                     <div class="" style="">${artiFormVO.arti_No}</div>
                 </div>
             </div>
             <div class="widget-toolbar"> 
                 <div class="" style="width:100px;">
                     <div class="" style="">${artiFormVO.arti_Status}</div>
                 </div>
             </div>
             <div class="widget-toolbar">
                 <div class="" style="width:100px;">
                     <div class="" style="">${artiFormVO.arti_Like}</div>
                 </div>
             </div>
         </div>
         
        
         <div class="widget-body">
             <div class="widget-toolbox">
                 <div class="btn-toolbar">
                     <div class="btn-group">
                         <div class="widget-toolbar">
                             <div class="widget-main padding-6">
                              <img src="<%=request.getContextPath()%>/tool/showimage.do?action=arti_Pic&arti_No=${artiFormVO.arti_No}"
	                     style="height:350px;width:500px; box-shadow:3px 3px 12px gray;padding:3px;"/>
                              </div>
                          </div>
                          
                              <div class="widget-toolbar">
                                  <div class="widget-main padding-6">
                                  <h4> </h4>
                                  </div>
                               </div>
                                <div class="widget-toolbar">
                                  <div class="widget-main padding-6">
                                  <h4> 系統訊息 : </h4><br>
                                     <font size="4"> @@ 要麻煩請你先登入喔~~~ </font>
                                  </div>
                               </div>
                           </div>
                       </div>
                    </div>
                    <div class="widget-main padding-16">
                    
                    
                    </div>                    
         </div>
		 
         <div class="widget-header header-color-dark">
         <h5 class="bigger lighter">${artiFormVO.arti_Time}</h5>


		</div>
		
           </div>
       </div>
   </div>
  </FORM>
<hr>	


<hr>

<hr>


</body>

 <jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />
</html>