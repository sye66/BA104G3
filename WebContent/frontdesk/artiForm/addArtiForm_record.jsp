<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.artiForm.model.*"%>

<%
  ArtiFormVO artiFormVO = (ArtiFormVO) request.getAttribute("artiFormVO");

%>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title> 主題文章新增 - AddArtiForm.jsp</title>

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
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>主題文章新增 - addArtiForm.jsp</h3></td><td>
		 <h4><a href="select_page.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料新增:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" name="form1" enctype="multipart/form-data">
<table>
	<tr>
		<td>文章編號:</td>
		<td><input  type="hidden" name="arti_No" size="45" 
			 value="<%= (artiFormVO==null)? "AR00000066" : artiFormVO.getArti_No()%>" /></td>
	</tr>
	
	<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
	<tr>
		<td>發文會員:</td>
		<td>
				<input type="hidden" name="mem_No" size="45" value="${memVO.mem_No}" ${(artiFormVO.mem_No==memVO.mem_No)?'selected':'' } >${memVO.mem_No}
		</td>
	</tr>
	<tr>
		<td>文章標題:</td>
		<td><input type="TEXT" name="arti_Title" size="45" 
			 value="<%= (artiFormVO==null)? "【問題】" : artiFormVO.getArti_Title()%>" /></td>
	</tr>
	<tr>
		<td>文章人氣:</td>
		<td><input  type="hidden" name="arti_Like" size="45" 
			 value="<%= (artiFormVO==null)? "11" : artiFormVO.getArti_Like()%>" /></td>
	</tr>
	<tr>
		<td>文章內容:</td>
		<td><TEXTAREA name="describe" size="45"  value="<%= (artiFormVO==null)? " 彈吉他碰到的問題 這樣有解嗎 " : artiFormVO.getDescribe()%>" />
			 </TEXTAREA></td>
	</tr>
	<tr>
		<td>PO文時間:</td>
		<td><input type="hidden" name="arti_Time" id="f_date1" type="text"></td>
	</tr>
	<tr>
		<td>文章附圖:</td>
		<td>
		<img id="theImage" src="<%=request.getContextPath()%>/image/XXX.jpg=${artiFormVO.arti_No}"
	                     style="height:111px;width:120px;"/>
		<input type="file" name="arti_Pic" size="45" id="theBinaryFile" onchange="onLoadBinaryFile()"
			 value="<%= (artiFormVO==null)? "吳永志" : artiFormVO.getArti_Pic()%>" /></td>
	</tr>
	<tr>
		<td>文章狀態:</td>
		<td><input  type="hidden" name="arti_Status" size="45"
			 value="<%= (artiFormVO==null)? "1" : artiFormVO.getArti_Status()%>" /></td>
	</tr>

	<jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService" />
	<tr>
		<td>文章分類:<font color=red><b>*</b></font></td>
		<td><select size="1" name="arti_Cls_No">
		<c:forEach var="artiClassVO" items="${artiClassSvc.all}" > 
		<option value="${artiClassVO.arti_Cls_No}" ${(artiFormVO.arti_Cls_No==artiClassVO.arti_Cls_No)?'selected':'' } >${artiClassVO.arti_Cls_Name}<br>
		</c:forEach>
		</td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="insertArti">
<input type="submit" value="送出新增"></FORM>
</body>

<% 
  java.sql.Timestamp arti_Time = null;
  try {
	  arti_Time = artiFormVO.getArti_Time();
   } catch (Exception e) {
	  arti_Time = new java.sql.Timestamp(System.currentTimeMillis());
   }
%>
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
		   value: '<%=arti_Time%>', // value:   new Date(),
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