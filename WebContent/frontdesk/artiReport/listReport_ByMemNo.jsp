<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.artiForm.model.*"%>
<%@ page import="com.artiReport.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.emp.model.*"%>

<jsp:useBean id="memSvc" scope="session" class="com.mem.model.MemService" />
<jsp:useBean id="artiReportSvc1" scope="page" class="com.artiReport.model.ArtiReportService" />
<jsp:useBean id="artiFormSvc" scope="session" class="com.artiForm.model.ArtiFormService" />
<%
    ArtiFormVO artiformVO = new ArtiFormVO();
    ArtiReportVO artiReportVO = new ArtiReportVO();
    ArtiReportService artiReportSvc = new ArtiReportService();

    EmpVO empVO = (EmpVO) session.getAttribute("empVO");
    MemVO memVO = (MemVO) session.getAttribute("memVO");
	String mem_No = memVO.getMem_No();
 	request.setAttribute("mem_No",mem_No);

 	Set<ArtiReportVO> set = (Set<ArtiReportVO>)artiReportSvc.findReportByMemNo(mem_No);
    pageContext.setAttribute("set",set);
%>

<html>
<head><title>個人檢舉列表</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/artiAll.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/reply.min.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />
<style>

</style>

</head>
<body bgcolor='white'>

<hr>
<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true" />
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<jsp:include page="/frontdesk/ad/listOneAd.jsp" flush="true" />


<div class="page-header position-relative">
                <div class="title">
                    <div class="list">
                       <a  href="/BA104G3/frontdesk/artiForm/listAllArtiForm.jsp"><h1>所有文章列表 </h1></a>
                    </div>
                </div>
                    
                <div class="title">
                      <div class="search">
                        <h1>
                       <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do"  name="form1" enctype="multipart/form-data">
                         <input type="text" size="40"  class="" name="arti_No"  placeholder="請輸入檢舉的文章編號 (EX:AR00000001)">
                        <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
    			         <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
                        <button class="btn btn-info" type="submit" name="action" value="getOneArti"> GO!!! </button>
                        </FORM>
                        </h1>
                      </div>
                  </div>
                    <!--Header Buttons-->
                    
                    <div class="header-buttons">
                     <c:if test="${memVO.mem_State == 1}">
                        <a class="refresh" href="/BA104G3/frontdesk/artiReport/listReport_ByMemNo.jsp">
                            <i></i>Report return
                        </a>
                        </c:if>
                    <c:if test="${memVO.mem_State == 1}">
                        <a class="sidebar-toggler" href="/BA104G3/frontdesk/ad/listMusic.jsp">
                            <i></i>Relax Music
                        </a>
                        </c:if>
                        <c:if test="${memVO.mem_State == 1}">
                        <a class="refresh" id="refresh-toggler" href="/BA104G3/frontdesk/artiForm/listArti_ByMemNo.jsp">
                            <i>Personal</i>
                        </a>
                            </c:if>
                            <c:if test="${memVO.mem_State == 1}">
                        <a class="fullscreen" id="fullscreen-toggler" href="/BA104G3/frontdesk/artiForm/addArtiForm.jsp">
                            <i> POST </i>
                        </a>
                         </c:if>
                        <a class="sidebar-toggler" href="/BA104G3/frontdesk/ad/GroupChat.jsp">
                            <i>Chat</i>
                        </a>
                    </div>
                        
                    </div>
<div class="container" style="font-size: 18px; text-align: center;">       
<%@ include file="/frontdesk/page1.file" %>                        
	<c:forEach var="artiReportVO" items="${set}" varStatus="s" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" >
   </div>    

<div class="container">
<c:forEach var="artiReportVO" items="${artiReportSvc1.findReportByMemNo(mem_No)}" >
<div class="col-xs-12 col-sm-12 widget-container-span">
                <div class="widget-box">
                    <div class="widget-header header-color-dark">
                    
                        <h5 class="bigger lighter"> ${artiFormSvc.getOneArtiForm(artiReportVO.arti_No).arti_Title} </h5>
                        
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">
			                    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" style="margin-bottom: 0px;">
			                        <input type="hidden" name="arti_No"  value="${artiFormVO.arti_No}">
			                        <input type="hidden" name="report_No"  value="${artiReportVO.report_No}">
			                        <input type="hidden" name="mem_No"  value="${artiReportVO.mem_No}">
			                        <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                        <button class="btn btn-danger" type="submit" name="action" value="deleteReport">刪除檢舉</button>
 			                    </FORM>
                            
                                </div>
                            </div>
                        </div>
                        
                      <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">

                                </div>
                            </div>
                        </div>
                        

                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">${artiReportVO.arti_No}</div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">${artiReportVO.report_No}</div>
                            </div>
                        </div>
                        
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">
                                ${artiReportVO.report_Time}
                                </div>
                            </div>
                        </div>
                        
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">
                                ${artiFormSvc.getOneArtiForm(artiReportVO.arti_No).mem_No}
                                </div>
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
                                            <img src="<%=request.getContextPath()%>/tool/showimage.do?action=mem_Pic&mem_No=${artiReportVO.mem_No}&mem_${memSvc.getOneMem(artiReportVO.mem_No).mem_Pic}"
	                     style="height: 120px;width: 150px; box-shadow:3px 3px 12px gray;padding:3px;"/>
	                                        <p>${memSvc.getOneMem(artiReportVO.mem_No).mem_Name}</p>
	                                        </div>
                                        </div>
                                    </div>
                                    <div class="widget-toolbar">
                                        <font size="3" style="font-family:Microsoft JhengHei;"> ${artiReportVO.report_Desc} </font>                        
                                    </div>
                                     <div class="widget-toolbar">
                                        <font size="3" style="font-family:Microsoft JhengHei;"> ${artiReportVO.rep_Re_Desc} </font>                        
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                    </div>
	</c:forEach>
</div>
</c:forEach>
<div class="container" style="font-size: 18px; text-align: center;">    
 <%@ include file="/backdesk/page2.file" %> 
 </div>     
</html>
<br> </b>
</body>
 <jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />
</html>