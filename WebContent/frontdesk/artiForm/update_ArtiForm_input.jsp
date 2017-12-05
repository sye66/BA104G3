<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.artiForm.model.*"%>
<%@ page import="com.mem.model.*"%>
<%
    ArtiFormVO artiFormVO = (ArtiFormVO) request.getAttribute("artiFormVO"); //EmpServlet.java (Concroller), 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
    MemVO memVO = (MemVO)session.getAttribute("memVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>員工資料修改 - update_artiForm_input.jsp</title>

	<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />
	<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/post.min.css" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style>
  
</style>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body bgcolor='white'>
<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true" />

<table id="table-1">
	<tr><td>
		 <h3>文章資料修改 - update_artiForm_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/artiForm/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<br><br><br><br><br><br>
<div class="container">
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" name="form1" enctype="multipart/form-data">

<div class="col-xs-12 col-sm-11 widget-container-span">
    <div class="widget-box">
        <div class="widget-header header-color-dark">
            原訂標題 : <h5 class="bigger lighter">${artiFormVO.arti_Title}</h5><br>
            <div class="widget-toolbar">
                <div class="" style="width:100px;">
                    <div class="" style="">
                    <jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService" />
                                                  分類:<font color=red><b>*</b></font>
		            <select size="1" name="arti_Cls_No">
			        <c:forEach var="artiClassVO" items="${artiClassSvc.all}">
				    <option value="${artiClassVO.arti_Cls_No}" ${(artiFormVO.arti_Cls_No==artiClassVO.arti_Cls_No)?'selected':'' } >${artiClassVO.arti_Cls_Name}
			        </c:forEach>
			        </select>
                    </div>
                </div>
             </div>
             <div class="widget-toolbar">
                 <div class="" style="width:100px;">
                     <div class="" style="">
                     <input type="hidden" name="arti_No" value="<%=artiFormVO.getArti_No()%>"><%=artiFormVO.getArti_No()%>
                     </div>
                 </div>
             </div>
             <div class="widget-toolbar">
                 <div class="" style="width:100px;">
                     <div class="" style="">
                     <input type="hidden" name="arti_Status" value="<%=artiFormVO.getArti_Status()%>"><%=artiFormVO.getArti_Status()%>
                     </div>
                 </div>
             </div>
             <div class="widget-toolbar">
                 <div class="" style="width:100px;">
                     <div class="" style="">
                     <input type="hidden" name="arti_Like" value="<%=artiFormVO.getArti_Like()%>"><%=artiFormVO.getArti_Like()%>
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
                             更正標題 : <input type="TEXT" name="arti_Title" size="45"	value="<%=artiFormVO.getArti_Title()%>" />
                             

                              </div>
                          </div>
                     
                         <div class="widget-toolbar">
                             <div class="widget-main padding-6">
                             文章附圖:<br/>
                             <img id="theImage" src="<%=request.getContextPath()%>/tool/showimage.do?action=arti_Pic_update&arti_No=${artiFormVO.arti_No}"
	                     style="height:111px;width:120px;"/> <br>
		<input type="file" name="arti_Pic" size="45" value="<%=artiFormVO.getArti_Pic()%>"  id="theBinaryFile" onchange="onLoadBinaryFile()"/>
                              </div>
                          </div>
                              <div class="widget-toolbar">
                                  <div class="widget-main padding-6">
                                  <img src="<%=request.getContextPath()%>/tool/showimage.do?action=mem_Pic&mem_No=${artiFormVO.mem_No}&mem_${memSvc.getOneMem(memVO.mem_No).mem_Pic}"
	                     style="height:120px;width:150px;"/>
                                  </div>
                               </div>
                                <div class="widget-toolbar">
                                  <div class="widget-main padding-6">
                                  <input type="hidden" name="mem_No" value="<%=artiFormVO.getMem_No()%>"><%=memVO.getMem_Name()%>
                                  </div>
                               </div>

                           </div>
                       </div>
                    </div>
                    <div class="widget-main padding-16">
                    <h4>詳細內文 : </h4><br/>
                    <input type="TEXTAREA" style="height:200px; width:100%" name="describe" size="45"	value="<%=artiFormVO.getDescribe()%>" />
                    </div>                    
         </div>
		 
         <div class="widget-header header-color-dark">
         <h5 class="bigger lighter">
         <input type="hidden" name="arti_Time" id="f_date1" type="text" value="<%=artiFormVO.getArti_Time()%>" />
         </h5>
         <div class="widget-toolbar">
             <div class="" style="width:100px;">
		    </div>
		</div>
		
		<div class="widget-toolbar">
             <div class="" style="width:100px;">
       <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" >
            <input type="hidden" name="arti_No"  value="<%=artiFormVO.getArti_No()%>">
            <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
            <button class="btn btn-success" type="submit" name="action" value="updateArti">修改文章</button>
		    </div>
		</div>

                  </div>
              </div>
           </div>
       </div>
   </div>

<hr />
<br>

</body>
 <jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />
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
 		   value: '<%=artiFormVO.getArti_Time()%>', // value:   new Date(),
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