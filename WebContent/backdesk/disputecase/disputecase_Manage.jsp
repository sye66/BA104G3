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
<link rel="stylesheet" href="<%=request.getContextPath()%>/lib/publicfile/include/vendor/font-awesome/css/font-awesome.css">
<title>Insert title here</title>
</head>
<body>
	
	<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/missionManage/missiondeskLeft.jsp" flush="true" />
	<div class="container">
	

	<%-- 列出所有爭議案件 --%>
	<%-- include的file占了兩col，寫9個別靠到邊界 --%>
	<div class="col-xs-12 col-sm-4">
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
	<div class="col-xs-12 col-sm-4">
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
	<div class="col-xs-12 col-sm-4">
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
	<div class="col-xs-12 col-sm-12">
		<div class="row">
			<h2>單一爭議案件查詢</h2>
			<form method="post" action="<%=request.getContextPath()%>/disputecase/disputecase.do">
			    <div class="form-group">
					<div class="col-xs-12 col-sm-10">
			            <%-- <label for="get_One_Dispute_Case">查詢單一爭議案件</label> --%>
			            <input type="text" name="dispute_Case_No" id="dispute_Case_No" placeholder="請輸入爭議案件編號" class="form-control">
			            <input type="hidden" name="action" value="get_One_Dispute_Case">
			    	</div>
					<div class="col-xs-12 col-sm-2">
					    <input type="submit" value="送出查詢" class="btn btn-primary">
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="col-xs-12 col-sm-12">
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
							<form method="post" action="disputecase_Reply.jsp">
								<input type="hidden" name="dispute_Case_No" value="<%=disputeCaseVO.getDispute_Case_No()%>">
								<input type="submit" class="btn btn-info" value="回覆此案件">
							</form>
						</td>
						<td>
                            <form method="post" action="<%=request.getContextPath()%>/disputecase/disputecase.do">
								<input type="hidden" name="action" value="delete_Dispute_Case">
								<input type="hidden" name="dispute_Case_No" value="<%=disputeCaseVO.getDispute_Case_No()%>">
                            	<input type="submit" class="btn btn-danger" value="刪除此案件">
                            </form>
                        </td>
                    </tr>
                    <%}%>
              	
            </tbody>
    	</table>
	</div>
	</div>
</body>
</html>