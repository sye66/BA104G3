<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.artiReply.model.*"%>

<%
    ArtiReplyVO artiReplyVO = (ArtiReplyVO) request.getAttribute("artiReplyVO41"); //EmpServlet.java (Concroller), 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>


<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>回覆文章資料修改 - update_artiReply_input.jsp</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/revised.min.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />

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

<table id="table-1">
	<tr><td>
		 <h3>回覆文章資料修改 - update_artiReply_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/artiReply/selectReply_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回文章回覆首頁</a></h4>
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

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" name="form1" enctype="multipart/form-data">


<div class="col-xs-12 col-sm-11 widget-container-span">
                <div class="widget-box">
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter">
                        <input type="hidden" name="mem_No" value="<%=artiReplyVO.getMem_No()%>"><%=artiReplyVO.getMem_No()%>
                         </h5>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">
                                <jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService"/>
                                <div class="" style="">${artiClassSvc.getOneClass(artiReplyVO41.arti_Cls_No).arti_Cls_Name }</div>
                                <input type="hidden" name="arti_Cls_No" value="<%=artiReplyVO.getArti_Cls_No()%>">
                                </div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">
                                <input type="hidden" name="arti_No" size="45"	value="<%=artiReplyVO.getArti_No()%>" /><%=artiReplyVO.getArti_No()%>
                                </div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">
                                <input type="hidden" name="reply_No" size="45"	value="<%=artiReplyVO.getReply_No()%>" /><%=artiReplyVO.getReply_No()%>
                                </div>
                            </div>
                        </div>
                        
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">
                               
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
    <img src="<%=request.getContextPath()%>/tool/showimage.do?action=mem_Pic&mem_No=${memVO.mem_No}"
	                     style="height:100px;width:120px;"/>
    </div>
                                    </div>
                                    </div>
                                    <div class="widget-toolbar">
                                    <div class="widget-main padding-6">
                                        <i class="icon-remove bigger-110"></i>
                                         回覆標題 :<font color=red><b>*</b></font>
                                        <jsp:useBean id="artiFormSvc" scope="page" class="com.artiForm.model.ArtiFormService" />
                                        ${artiFormSvc.getOneArtiForm(artiReplyVO.arti_No).arti_Title}
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="widget-main padding-16">
                        <TEXTAREA style="height:200px; width:100%;">
                        <input type="hidden" name="reply_Desc" size="45" value="<%= (artiReplyVO==null)? "【@@?】 " : artiReplyVO.getReply_Desc()%>"/>
                        </TEXTAREA>
                        
                        </div>
                    </div>
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter">
                        <input type="hidden" name="reply_Time" id="f_date1" type="text" value="<%=artiReplyVO.getReply_Time()%>" /><%=artiReplyVO.getReply_Time()%>
                        </h5>
                        <div class="widget-toolbar">
                            <div class="btn-group">
                            <div>
                                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" style="margin-bottom: 0px;">
                                <input type="hidden" name="reply_No"  value="${artiReplyVO41.reply_No}">
			                    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
 			                    <button class="btn btn-success" type="submit" name="action" value="updateReply">修改回覆</button>
			                    </FORM>
                            </div>
                            </div>
                            <div class="btn-group">
                            <div>
                            
                            </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
    

<br>

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
 		   value: '<%=artiReplyVO.getReply_Time()%>', // value:   new Date(),
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