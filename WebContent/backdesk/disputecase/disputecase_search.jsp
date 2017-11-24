<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>Title Page</title>
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
		<!--[if lt IE 9]>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/respond.js/1.4.2/respond.min.js"></script>
		<![endif]-->
	</head>
	<body>
		
		<jsp:useBean id="disputeCaseService" scope="page" class="com.disputecase.model.DisputeCaseService"/>
		
		<form action="/disputecase/disputecase.do" method="post">
			<select size = "1" name="dispute_Case_No">
				<c:forEach var="disputeCaseVO" items="${disputeCaseService.allDisputeCase}">
					<option value="${disputeCaseVO.dispute_Case_No}">${disputeCaseVO.dispute_Case_No}</option>
				</c:forEach>
			</select>
		</form>
		
		<script src="https://code.jquery.com/jquery.js"></script>git
		<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</body>
</html>