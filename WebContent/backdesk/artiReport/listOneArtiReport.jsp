<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.artiReport.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
ArtiReportService artiReportSvc = new ArtiReportService();
ArtiReportVO artiReportVO = (ArtiReportVO) request.getAttribute("artiReportSet"); 
%>
<html>
<head>
<title> 檢舉文章資料 - listOneArtiReport.jsp </title>
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/revised.min.css" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style>
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

<style>
  table {
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

<h4>此頁暫練習採用 Script 的寫法取值:</h4>
<table id="table-1">
	<tr><td>
		 <h3>文章檢舉資料 - ListOneArtiReport.jsp</h3>
		 <h4><a href="selectReport_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回文章檢舉首頁</a></h4>
	</td></tr>
</table>
<hr>

<div class="col-xs-12 col-sm-11 widget-container-span">
                <div class="widget-box">
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter"> ${artiReportVO.mem_No}  </h5>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                            <jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService"/>
			                ${artiClassSvc.getOneClass(artiReportVO.arti_Cls_No).arti_Cls_Name }</div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">${artiReportVO.report_Status}</div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style=""> ${artiReportVO.arti_No}</div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style=""> ${artiReportVO.report_No}</div>
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
                                    <img src="<%=request.getContextPath()%>/tool/showimage.do?action=arti_Pic&arti_No=${artiFormVO.getOneArtiForm(artiReply.arti_No)}"
	                     style="height:250px;width:300px; box-shadow:3px 3px 12px gray;padding:3px;"/>
                                    </div>
                                    </div>
                                    </div>
                                    
                                    <div class="widget-toolbar">
                                    <div class="widget-main padding-6">
                                    <div class="pic">
                                    <img src="<%=request.getContextPath()%>/tool/showimage.do?action=mem_Pic&mem_No=${artiReplyVO.mem_No}&mem_${memSvc.getOneMem(memVO.mem_No).mem_pic}"
	                     style="height:120px;width:150px; box-shadow:3px 3px 12px gray;padding:3px;"/>
                                    </div>
                                    </div>
                                    </div>
                                    
                                    <div class="widget-toolbar">
                                    <div class="widget-main padding-6">
                                        <i class="icon-remove bigger-110"></i>
                                        <h4> 被檢舉文章標題 : </h4><br>
                                        <jsp:useBean id="artiFormSvc" scope="page" class="com.artiForm.model.ArtiFormService" />
		                                ${artiFormSvc.getOneArtiForm(artiReportVO.arti_No).arti_Title}
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="widget-main padding-16">
                        <h4>詳細檢舉內文 : </h4><br>
                        ${artiReportVO.report_Desc}
                        </div>
                    </div>
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter"> ${artiReportVO.report_Time} </h5>
                        <div class="widget-toolbar">
                            <div class="btn-group">
                            <div>
                            <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" >
			                <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			                <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
                            <button class="btn btn-success" type="submit" name="action" value="getOneReport_For_Update">修改檢舉</button>
		                    </FORM>
                            </div>
                            </div>
                            <div class="btn-group">
                            <div>
                            <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" >
			                <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			                <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                <button class="btn btn-danger" type="submit" name="action" value="deleteReport">刪除檢舉</button>
                            </FORM>  
                            </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
 
</body>
</html>