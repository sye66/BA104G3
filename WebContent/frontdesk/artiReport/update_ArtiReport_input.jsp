<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.artiReport.model.*"%>

<%
    ArtiReportVO artiReportVO = (ArtiReportVO) request.getAttribute("artiReportVO"); //EmpServlet.java (Concroller), 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)

%>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>檢舉文章資料修改 - update_artiReport_input.jsp</title>

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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true" />

<table id="table-1">
	<tr><td>
		 <h3>檢舉文章資料修改 - update_artiReport_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/artiReport/selectReport_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回文章回覆首頁</a></h4>
	</td></tr>
</table>

<h3>回覆資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<div class="container">
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReport/artiReport.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>回覆編號:<font color=red><b>*</b></font></td>
		<td><input type="hidden" name="report_No" value="<%=artiReportVO.getReport_No()%>"><%=artiReportVO.getReport_No()%></td>
	</tr>
	<tr>
		<td>發文會員:</td>
		<td><input type="hidden" name="mem_No" value="<%=artiReportVO.getMem_No()%>"><%=artiReportVO.getMem_No()%></td>
	</tr>
	<tr>
		<td>文章編號:</td>
		<td><input type="hidden" name="arti_Title" size="45"	value="<%=artiReportVO.getArti_No()%>" /><%=artiReportVO.getArti_No()%></td>
	</tr>
	<jsp:useBean id="artiFormSvc" scope="page" class="com.artiForm.model.ArtiFormService" />
	<tr>
		<td>文章標題:<font color=red><b>*</b></font></td>
		<td><select size="1" name="arti_No">
			<c:forEach var="artiFormVO" items="${artiFormSvc.all}">
				<option value="${artiFormVO.arti_No}" ${(artiReplyVO.arti_No==artiFormVO.arti_No)?'selected':'' } >${artiFormVO.arti_Title}
			</c:forEach>
		</select></td>
	</tr>
		<td>回覆內容:</td>
		<td><TEXTAREA name="report_Desc" value="<%=artiReportVO.getReport_Desc()%>"></TEXTAREA></td>
	</tr>
		<td>回覆時間:</td>
		<td><input type="hidden" name="report_Time" id="f_date1" type="text" value="<%=artiReportVO.getReport_Time()%>" /><%=artiReportVO.getReport_Time()%></td>
	</tr>
	<tr>
	
	</tr>
	<tr>
		<td>文章分類:</td>
		<td><input type="hidden" name="arti_Cls_No" value="<%=artiReportVO.getArti_Cls_No()%>"><%=artiReportVO.getArti_Cls_No()%></td>
	</tr>
	
</table>
<br>
<input type="hidden" name="action" value="updateReply">
<input type="hidden" name="arti_No" value="<%=artiReportVO.getReport_No()%>">
<input type="submit" value="送出修改"></FORM>
</div>
 <jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />
</body>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/build/jquery.datetimepicker.full.min.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
           theme: '',              //theme: 'dark',
 	       timepicker:false,       //timepicker:true,
 	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
 		   value: '<%=artiReportVO.getReport_Time()%>', // value:   new Date(),
        });
</script>

<script type="text/javascript">
        function onLoadBinaryFile() {
            var theFile = document.getElementById("theBinaryFile");

            // 確定選取了一個二進位檔案，而非其他格式。
            if (theFile.files.length != 0 && theFile.files[0].type.match(/image.*/)) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    var theImg = document.getElementById("theImage");
                    theImg.src = e.target.result;
                };
                reader.onerror = function (e) {
                    alert("例外狀況，無法讀取二進位檔");
                };

                // 讀取二進位檔案。
                reader.readAsDataURL(theFile.files[0]);
            }
            else {
                alert("請選取一個二進位檔");
            }
        }
    </script>
    
</html>