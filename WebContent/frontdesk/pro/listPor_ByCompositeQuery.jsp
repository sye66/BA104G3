<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.proclass.model.*"%>

<%-- �U�νƦX�d��-�i�ѫȤ��select_page.jsp�H�N�W�����Q�d�ߪ���� --%>
<%-- �����u�@���ƦX�d�߮ɤ����G�m�ߡA�i���ݭn�A�W�[�����B�e�X�ק�B�R�����\��--%>


<jsp:useBean id="proClassSvc" scope="page" class="com.proclass.model.ProClassService" />


<html>
<head><title>�ƦX�d�� - listPro_ByCompositeQuery.jsp</title>

<style>
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 800px;
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

<h4>
���U�νƦX�d��  - �i�ѫȤ�� select_page.jsp �H�N�W�����Q�d�ߪ����<br>
�������u�@���ƦX�d�߮ɤ����G�m�ߡA�i���ݭn�A�W�[�����B�e�X�ק�B�R�����\��</h4>

<table>
	<tr>
		<th>�ӫ~�s��</th>
		<th>�ӫ~�W��</th>
		<th>�ӫ~����</th>
		<th>����</th>
		<th>���A</th>
		<th>�馩</th>
		<th>����</th>
	</tr>
	<c:forEach var="proVO" items="${listPro_ByCompositeQuery}">
		<tr align='center' valign='middle'>
			<td>${proVO.pro_No}</td>
			<td>${proVO.pro_Name}</td>
			<td>${proVO.pro_Info}</td>
			<td>${proVO.pro_Price}</td>
			<td>${proVO.pro_Status}</td>
			<td>${proVO.pro_Discount}</td>	
			<td>
				<c:forEach var="proClassVO" items="${proClassSvc.all}">
			        <c:if test="${proVO.pro_Class_No==proClassVO.pro_Class_No}">
	                   	${proClassVO.pro_Class_Name}
                    </c:if>
                </c:forEach>
			</td>
		</tr>
	</c:forEach>
</table>

</body>
</html>