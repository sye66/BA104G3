<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.artiForm.model.*"%>
<%@ page import="com.artiClass.model.*"%>
<%@ page import="com.artiReply.model.*"%>
<%@ page import="com.artiReport.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<jsp:useBean id="artiFormSvc" scope="session" class="com.artiForm.model.ArtiFormService" />
<jsp:useBean id="artireplySvc" scope="page" class="com.artiReply.model.ArtiReplyService" />
<%-- 取出 Controller ArtiFormServlet.java已存入request的ArtiFormVO物件--%>
<%
  //ArtiFormServlet.java(Concroller), 存入req的ArtiFormVO物件
    ArtiFormVO artiFormVO = (ArtiFormVO) request.getAttribute("artiFormVO"); 
    ArtiReplyVO artiReplyVO = new ArtiReplyVO();
    ArtiReportVO artiReportVO = new ArtiReportVO(); 
%>
<%-- 取出 對應的ArtiClassVO物件--%>
<%
  ArtiClassDAO dao = new ArtiClassDAO();
  ArtiClassVO artiClassVO = dao.findByPrimaryKey(artiFormVO.getArti_Cls_No());
%>

<html>
<head>
<title>文章資料 - listOneArtiFrom_Test.jsp</title>
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/post.min.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/arti_back_style.css" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<html xmlns="http://www.w3.org/1999/xhtml">
<style>
div {
  word-wrap:break-word;
  word-break:normal;
}

  a{
   font-size: 24px;
   color: #F00;
  }

</style>

</head>
<body bgcolor='white'>


<h4></h4>

    <div class="widgetbox">
        <div class="title">
        <h3> 這裡是討論區文章資料查詢 -- 列出文章跟回覆   // <a href="/BA104G3/backdesk/artiForm/listAllArtiForm_back.jsp">List</a> all Article.  
                           //                 <a href="/BA104G3/frontdesk/artiForm/addArtiForm.jsp">Add</a> a new Article.</h3><br/>
        </div>
        </div>

<hr>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" name="form1" enctype="multipart/form-data">

<div class="col-xs-8 col-sm-8 widget-container-span">
                <div class="widget-box">
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter"> ${artiFormVO.arti_Title} </h5>
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
                                            <div class="pic">
                        <img src="<%=request.getContextPath()%>/tool/showimage.do?action=arti_Pic&arti_No=${artiFormVO.arti_No}"
	                     style="height:250px;width:300px; box-shadow:3px 3px 12px gray;padding:3px;"/>
                              </div>
    </div>
                                    </div>
                                    </div>
                                    <div class="widget-toolbar">
                                    <div class="widget-main padding-6">
                        <img src="<%=request.getContextPath()%>/tool/showimage.do?action=mem_Pic&mem_No=${artiFormVO.mem_No}&mem_${memSvc.getOneMem(memVO.mem_No).mem_pic}"
	                     style="height:120px;width:150px; box-shadow:3px 3px 12px gray;padding:3px;"/>
                                    </div>
                                    </div>
                                    
                                    <div class="widget-toolbar">
                                    <div class="widget-main padding-6">
                        
                                    </div>
                                    </div>
                                    
                                </div>
                            </div>
                        
                        <div class="widget-main padding-16">
                        <h4>詳細內文 : </h4><br>
                        ${artiFormVO.describe}
                        </div>
                    </div>
                    
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter">${artiFormVO.arti_Time}</h5>
                        <div class="widget-toolbar">
                        
                            <div class="btn-group">
                            <div>
                            <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" >
			                <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			                <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                <button class="btn btn-danger" type="submit" name="action" value="deleteArtiFMBack">刪除文章</button>
                            </FORM>
                            </div>
                            </div>
                           
                            <div class="btn-group">
                            <div>
                              
                            </div>
                            </div>
                            
                            </div>
                        </div>
                    </div>
                </div>
               
		</FORM>
<hr>



</body>
</html>