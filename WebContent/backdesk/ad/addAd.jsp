<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ad.model.*"%>

<%
  AdVO adVO = (AdVO) request.getAttribute("adVO");
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
  
  
  .title{
   font-size: 18px;
   color: #5B5B00;
  }
  
  .start{
   font-size: 24px;
   color: #4B0091;
  }
  
.end{
   font-size: 24px;
   color: #EA0000;
  }
  


</style>

</head>
<body bgcolor='white'>

<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/artiForm/backdeskLeft_ArtiForm.jsp" flush="true" />

<h4></h4>

    <div class="widgetbox">
        <div class="title">
        <h3> 這裡是討論區廣告資料新增   // <a href="/BA104G3/backdesk/ad/listAllAd_back.jsp">List</a> all AD.  
                           //                 <a href="/BA104G3/backdesk/ad/addAd.jsp">Add</a> a new AD.</h3><br/>
        </div>
        </div>

<hr>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ad/ad.do" name="form1" enctype="multipart/form-data">

<div class="col-xs-8 col-sm-8 widget-container-span">
                <div class="widget-box">
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter"> ${adVO.ad_No} </h5>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">
                                <jsp:useBean id="adSvc" scope="page" class="com.ad.model.AdService"/>
                                ${adVO.ad_Fty_No}
                                </div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">${adVO.ad_Fty_Name}</div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style=""> </div>
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
                        <img src="<%=request.getContextPath()%>/tool/showimage.do?action=ad_Pic&ad_No=${adVO.ad_No}"
	                     style="height:250px;width:900px; box-shadow:3px 3px 12px gray;padding:3px;"/>
                              </div>
    </div>
                                    </div>
                                    </div>
                                    <div class="widget-toolbar">
                                    <div class="widget-main padding-6">
     
                                    </div>
                                    </div>
                                    
                                    <div class="widget-toolbar">
                                    <div class="widget-main padding-6">
                                      <p class="title"> 廣告標題 : ${adVO.ad_Desc} </p>
                                      <p class="start"> 廣告開始時間 : ${adVO.ad_Start} </p>
                                      <p class="end"> 廣告結束時間 : ${adVO.ad_End}</p>
                                    </div>
                                    </div>
                                    
                                </div>
                            </div>
                        
                        <div class="widget-main padding-16">
                        <h4></h4><br>

                        </div>
                    </div>
                    
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter"></h5>
                        <div class="widget-toolbar">
                        
                            <div class="btn-group">
                            <div>
                            <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ad/ad.do" >
			                <input type="hidden" name="ad_No"  value="${adVO.ad_No}">
			                <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                <button class="btn btn-danger" type="submit" name="action" value="deleteAd">刪除廣告</button>
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