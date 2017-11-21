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
    
    String mem_No = (String) session.getAttribute("arti_No");
	session.setAttribute("mem_No",mem_No);
    
	String arti_No = (String) session.getAttribute("arti_No");
	session.setAttribute("arti_No",arti_No);
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

  
</style>

</head>
<body bgcolor='white'>

<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true" />

<h4></h4>
<table id="table-1">
	<tr><td>
		 <h3>文章資料 - ListOneArtiFrom_改版.jsp    ${ arti_No}</h3>
		 <h4><a href="/BA104G3/frontdesk/artiForm/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>
<hr>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" name="form1" enctype="multipart/form-data">

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
                                  <img src="<%=request.getContextPath()%>/tool/showimage.do?action=mem_Pic&mem_No=${artiFormVO.mem_No}&mem_${memSvc.getOneMem(memVO.mem_No).mem_pic}"
	                     style="height:120px;width:150px; box-shadow:3px 3px 12px gray;padding:3px;"/>
	                              <p>${artiFormVO.mem_No}&${memSvc.getOneMem(artiFormVO.mem_No).mem_Name}</p>
                                  </div>
                               </div>
                                <div class="widget-toolbar">
                                  <div class="widget-main padding-6">
                                  <h4>詳細內文 : </h4><br>
                                   <font size="4">${artiFormVO.describe}</font>
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
         
         <div class="widget-toolbar">
             <div class="" style="width:100px;">
                 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" >
			    <input type="hidden" name="mem_No"  value="${artiFormVO.mem_No}">
    			<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
                <button class="btn btn-link" type="submit" name="action" value="giveOneLike">讚ㄧ個! </button>
		        </FORM>		
		    </div>
		</div>
		
		<div class="widget-toolbar">
            <div class="" style="width:100px;">
               <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" >
			   <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			   <input type="hidden" name="mem_No"  value="${memVO.mem_No}">
			   <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
               <button class="btn btn-success" type="submit" name="action" value="getOneArti_For_Update">修改文章</button>
		       </FORM>
		    </div>
		</div>
		
		<div class="widget-toolbar">
            <div class="" style="width:100px;">
                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" >
			    <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			    <input type="hidden" name="mem_No"  value="${memVO.mem_No}">
			    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			    <button class="btn btn-danger" type="submit" name="action" value="deleteArti">刪除文章</button>
                </FORM>
             </div>
		</div>
</FORM>

		<div class="widget-toolbar">
            <div class="" style="width:100px;">
		        <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" >
		        <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
		        <input type="hidden" name="mem_No"  value="${artiFormVO.mem_No}">
                <button class="btn btn-info" type="submit" name="action" value="listReply_ByArtiNo"> 查看回覆</button>
                </FORM>
		    </div>
		</div>
           </div>
       </div>
   </div>
<hr>	

<div class="widget-body">
    <div class="widget-toolbox">
            <div class="btn-group">             
                 <img src="<%=request.getContextPath()%>/tool/showimage.do?action=mem_Pic&mem_No=${memVO.mem_No}"
	                     style="height: 120px;width: 150px; box-shadow:3px 3px 12px gray;padding:3px;"/>
                                    
    <div class="widget-toolbar">
        <div class="widget-main padding-6">                   
                                    
 		    <div class="widget-toolbar">
                <div class="" style="width:100px;">
		        <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" >
		        <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
		        <input type="hidden" name="arti_Cls_No"  value="${artiFormVO.arti_Cls_No}">
		        <input type="hidden" name="mem_No"  value="${memVO.mem_No}">
                <button class="btn btn-primary" type="submit" name="action" value="insertReply"> 回覆文章</button>
                
		        </div>
		    </div>
                                    
        </div>
    </div>
                                    
            <div class="widget-toolbar">
                <div class="widget-main padding-2">
                    <div class="pic"> 
                     <input type="TEXTAREA" style="height: 80px; width:100%" name="reply_Desc" size="45"	value="<%= (artiReplyVO==null)? " @@? " : artiReplyVO.getReply_Desc()%>" />
                     </div>
                 </div>
             </div>
                                          
             </div>
         </div>
</FORM>
</div>
<hr>

<div class="widget-body">
    <div class="widget-toolbox">
        <div class="btn-toolbar">
            <div class="btn-group">
            
            <img src="<%=request.getContextPath()%>/tool/showimage.do?action=mem_Pic&mem_No=${memVO.mem_No}"
	                     style="height: 120px;width: 150px; box-shadow:3px 3px 12px gray;padding:3px;"/>
                                    
    <div class="widget-toolbar">
        <div class="widget-main padding-6">
                                    
             <div class="widget-toolbar">
                 <div class="" style="width:100px;">
		         <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" >
		         <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
		         <input type="hidden" name="arti_Cls_No"  value="${artiFormVO.arti_Cls_No}">
		         <input type="hidden" name="mem_No"  value="${memVO.mem_No}">
		         <input type="hidden" name="report_Desc"  value="${artiReportVO.report_Desc}">
                 <button class="btn btn-warning" type="submit" name="action" value="insertReport"> 檢舉文章</button>
		         </FORM>
		        </div>
		    </div>
                                    
        </div>
    </div>
                                    
            <div class="widget-toolbar">
                <div class="widget-main padding-2">
                    <div class="pic">
                                            
                     <input type="TEXTAREA" style="height: 80px; width:100%" name="reply_Desc" size="45"	value="<%= (artiReportVO==null)? " @@? " : artiReportVO.getReport_Desc()%>" />
                      ${artiReportVO.report_Desc}
    
                     </div>
                 </div>
             </div>
                                          
             </div>
         </div>
     </div>
</div>
<hr>

	<jsp:include page="/frontdesk/artiReply/listReply_ByArtiNo.jsp" flush="true" />

</body>

 <jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />
</html>