<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.disputecase.model.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	DisputeCaseService disputeCaseService = new DisputeCaseService();
	List<DisputeCaseVO> listAllCase = disputeCaseService.getAllDisputeCase();
	List<DisputeCaseVO> listAllPendingCase = disputeCaseService.getDisputeCaseByStatus(1);
	List<DisputeCaseVO> listAllHandlingCase = disputeCaseService.getDisputeCaseByStatus(2);
	List<DisputeCaseVO> listAllClosedCase = disputeCaseService.getDisputeCaseByStatus(3);
	List<DisputeCaseVO> listAllRejectCase = disputeCaseService.getDisputeCaseByStatus(4);

	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/disputecase/backdeskLeft_DisputeCase.jsp" flush="true" />
	
	<%-- 列出所有爭議案件 --%>
	<%-- include的file占了兩col，寫9個別靠到邊界 --%>
	<div class="col-lg-3 col-md-6">
	    <div class="panel panel-primary">
	        <div class="panel-heading">
	            <div class="row">
	                <div class="col-xs-3">
	                    <i class="fa fa-comments fa-5x"></i>
	                </div>
	                <div class="col-xs-9 text-right">
	                    <div class="huge">26</div>
	                    <div>New Comments!</div>
	                </div>
	            </div>
	        </div>
	        <a href="#">
	            <div class="panel-footer">
	                <span class="pull-left">View Details</span>
	                <span class="pull-right"><i class="fa fa-arrow-circle-right"></i></span>
	                <div class="clearfix"></div>
	            </div>
	        </a>
	    </div>
	</div>
	<div class="col-xs-12 col-sm-9">
        <table class="table table-hover">
            <h2>爭議案件 - 待處理</h2>
            <thead>
                <tr>
                    <th>案件編號</th>
                    <th>原任務編號</th>
                    <th>提出人</th>
                    <th>發案時間</th>
                </tr>
            </thead>
            <tbody>
                <%for(DisputeCaseVO disputeCaseVO : listAllCase){%>
                    <tr>
                        <td>
                            <%=disputeCaseVO.getDispute_Case_No()%>
                        </td>
                        <td>
                            <%=disputeCaseVO.getMission_No()%>
                        </td>
                        <td>
                            <%=disputeCaseVO.getDispute_Mem_No() %>
                        </td>
                        <td>
                            <%=simpleDateFormat.format(disputeCaseVO.getIssue_Datetime())%>
                        </td>
                        <td>
							<form method="post" action="disputecase_Check.jsp">
								<input type="hidden" name="dispute_Case_No" value="<%=disputeCaseVO.getDispute_Case_No()%>">
								<input type="submit" class="btn btn-info"value="回覆此案鍵">
							</form>
                            <form method="post" action="<%=request.getContextPath()%>/disputecase/disputecase.do">
								<input type="hidden" name="action" value="reply_Dispute_Case">
								<input type="hidden" name="dispute_Case_No" value="<%=disputeCaseVO.getDispute_Case_No()%>">
                            	<input type="submit" class="btn btn-danger"value="刪除此案件">
                            </form>
                        </td>
                    </tr>
                    <%}%>
              	
            </tbody>
    	</table>
	</div>
</body>
</html>