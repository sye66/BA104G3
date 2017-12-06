<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.artiForm.model.*"%>
<%@ page import="com.artiClass.model.*"%>
<%@ page import="com.artiReply.model.*"%>
<%@ page import="com.artiReport.model.*"%>
<%@ page import="com.emp.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
  EmpVO empVO = (EmpVO) session.getAttribute("empVO");
  
  ArtiReportService artiReportSvc = new ArtiReportService();
  ArtiReportVO artiReportVO = (ArtiReportVO) request.getAttribute("artiReportSet"); 
  session.setAttribute("artiReportVO",artiReportVO);
 %>

<html>
<head>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/reply.min.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/arti_back_style.css" />

<title>文章檢舉資料 - listOneArtiReply.jsp</title>

<style>
    a{
   font-size: 24px;
   color: #F00;
  }
</style>

</head>
<body bgcolor='white'>

<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/artiForm/backdeskLeft_ArtiForm.jsp" flush="true" />


<div class="title">
        <h3> 這裡是討論區文章資料查詢 -- 列出單ㄧ文章的檢舉   // <a href="/BA104G3/backdesk/artiReport/listAllArtiReport.jsp">List</a> all Article Reply.  
         <br/>
        </div>


	<div class="col-xs-8 col-sm-8 widget-container-span">
                <div class="widget-box">
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter"> ${artiReportSet.mem_No} </h5>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                            <div class="" style="">${artiReportSet.report_Status}</div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                            <div class="" style="">${artiReportSet.rep_Re_Desc}</div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">${artiReportSet.arti_No}</div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">${artiReportSet.report_No}</div>
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
    <img src="<%=request.getContextPath()%>/tool/showimage.do?action=mem_Pic&mem_No=${memVO.mem_No}"
	                     style="height:100px;width:120px;"/>
    </div>
                                    </div>
                                    </div>
                                    <div class="widget-toolbar">
                                    <div class="widget-main padding-6">
                                        <i class="icon-remove bigger-110"></i>
                                        <jsp:useBean id="artiFormSvc" scope="page" class="com.artiForm.model.ArtiFormService" />
                                        ${artiFormSvc.getOneArtiForm(artiReportSet.arti_No).arti_Title}
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="widget-main padding-16">
                            ${artiReportSet.report_Desc}
                        </div>
                        
             <div class="widget-toolbar">
                 <div class="btn-group">
					<div class="col-xs-12 col-sm-8">
						<button class="btn btn-warning" type="button" onclick="ReportSample()">懶人1</button>
						</div>
					</div>	
              </div>
              
              <div class="widget-toolbar">
                 <div class="btn-group">
					<div class="col-xs-12 col-sm-8">
						<button class="btn btn-warning" type="button" onclick="ReportSample2()">懶人2</button>
						</div>
					</div>	
              </div>
              
             <div class="widget-toolbar">
                 <div class="btn-group">
					<div class="col-xs-12 col-sm-8">
						<button class="btn btn-warning" type="button" onclick="ReportSample3()">懶人3</button>
						</div>
					</div>	
              </div>
                        
                        <div class="widget-main padding-16">
                             <div>
                                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" style="margin-bottom: 0px;">
                                <input type="text" name="rep_Re_Desc" size="126" id="rep_Re_Desc" value="${artiReportSet.rep_Re_Desc}">
                                <input type="hidden" name="report_No"  value="${artiReportSet.report_No}">
                                <input type="hidden" name="mem_No"  value="${artiReportSet.mem_No}">
                                <input type="hidden" name="arti_No"  value="${artiReportSet.arti_No}">
                                <input type="hidden" name="report_Desc"  value="${artiReportSet.report_Desc}">
                                <input type="hidden" name="report_Time"  value="${artiReportSet.report_Time}">
                                <input type="hidden" name="report_Status"  value="${artiReportSet.report_Status}">
                                <input type="hidden" name="emp_No"  value="${empVO.emp_No}">
			                    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
 			                    <button class="btn btn-success" type="submit" name="action" value="Report_Reply">檢舉回覆</button>
			                    </FORM>
			                    
                            </div>
                        </div>
                    </div>
                    
                    
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter">${artiReportSet.report_Time}</h5>
                        <div class="widget-toolbar">
                            <div class="btn-group">

                            </div>
                            <div class="btn-group">
                            <div>
                                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" style="margin-bottom: 0px;">
			                    <input type="hidden" name="report_No"  value="${artiReportSet.report_No}">
			                    <input type="hidden" name="emp_No"  value="${empVO.emp_No}">
			                    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                    <button class="btn btn-danger" type="submit" name="action" value="deleteReportFMBack">刪除檢舉</button>
 			                    </FORM>  
                            </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
                <hr>
                
                <div class="widget-main padding-28">
                          </div>
                        </div>     
</body>

<!--神奇方法 -->
<script type="text/javascript">
    function ReportSample(){
    	var no = document.getElementById("rep_Re_Desc");			
    	    no.value="[不太懂施主你的標準阿~~~]";
	}
    
    function ReportSample2(){
    	var no = document.getElementById("rep_Re_Desc");			
    	    no.value="[有病要去看醫生阿~~~]";
	}
    
    function ReportSample3(){
    	var no = document.getElementById("rep_Re_Desc");			
    	    no.value="[腦袋有BUG神難修阿~~~]";
	}
</script>
<!--神奇方法 -->
</html>