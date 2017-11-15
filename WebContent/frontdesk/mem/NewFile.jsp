<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="RelationSvc" scope="page" class="com.relation.model.RelationService"/>


<c:forEach var="RelationVO" items="${RelationSvc.all}">
	${RelationVO.mem_No}<br>
	${RelationVO.related_Mem_No}<br>
	${RelationVO.relation_Status}<br>
</c:forEach>