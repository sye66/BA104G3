<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.emp.model.*"%>
<%@ page import="com.ad.model.*"%>

<%
  AdVO adVO = new AdVO();
%>

<html>
<head>
<title>文章資料 - listOneArtiFrom_Test.jsp</title>
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/post.min.css" />
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/arti_back_style.css" />

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

<html xmlns="http://www.w3.org/1999/xhtml">
<style>
div {
  word-wrap:break-word;
  word-break:normal;
}

a{
   font-size: 24px;
   color: #F00;
  }
  
  
  .title{
   font-size: 18px;
   color: #5B5B00;
  }
  
  .start{
   font-size: 24px;
   color: #4B0091;
  }
  
.end{
   font-size: 24px;
   color: #EA0000;
  }
  


</style>

</head>
<body bgcolor='white'>

<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/artiForm/backdeskLeft_ArtiForm.jsp" flush="true" />

<h4></h4>

    <div class="widgetbox">
        <div class="title">
        <h3> 這裡是討論區廣告資料新增   // <a href="/BA104G3/backdesk/ad/listAllAd_back.jsp">List</a> all AD.  
                           //                 <a href="/BA104G3/backdesk/ad/addAd.jsp">Add</a> a new AD.</h3><br/>
        </div>
        </div>

<hr>


<div class="container">
<div class="col-xs-8 col-sm-8 widget-container-span">
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ad/ad.do" name="form1" enctype="multipart/form-data">
                <div class="widget-box">
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter"> 
                        <jsp:useBean id="empSvc" scope="page" class="com.emp.model.EmpService" />
                        <input type="hidden" name="emp_No" value="${emoVO.emp_No}">${empVO.emp_Name}
                         </h5>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                                <div class="" style="">
                                <input type="hidden" name="ad_No" size="45" value="${adVO.ad_No}">${adVO.ad_No}
                                </div>
                            </div>
                        </div>
                        <div class="widget-toolbar">
                            <div class="" style="width:100px;">
                            
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
                                            (請提供 1280 * 300 尺寸照片)<br>
    <img id="theImage" src="<%=request.getContextPath()%>/image/XXX.jpg=${acVO.ad_No}"
	                     style="height:150px;width:640px;"/>
		                      <input type="file" name="ad_Pic" size="45" id="theBinaryFile" onchange="onLoadBinaryFile()"
			 value="<%= (adVO==null)? "廣告的主題照片" : adVO.getAd_Pic()%>" />
    </div>
                                    </div>
                                    </div>
                                    
                                    <div class="widget-toolbar">
                                    <div class="widget-main padding-6">

                                    </div>
                                    </div>
                                    
                                    <div class="widget-toolbar">
                                     <div class="widget-main padding-6">   
                                    廠商編號 : <input type="text" name="ad_Fty_No"  value="${adVO.ad_Fty_No}">
                                    <hr>
                                    <div class="widget-main padding-6">   
                                    廠商名稱 : <input type="text" name="ad_Fty_Name"  value="${adVO.ad_Fty_Name}">
                                    <hr>
                                    廣告標題 :
                                    <input type="text" name="ad_Desc" size="45" value="${adVO.ad_Desc}">
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="widget-main padding-16">
                         廣告開始 : <input type="text" name="ad_Start"  value="${adVO.ad_Start}">
                         廣告結束 : <input type="text" name="ad_End"  value="${adVO.ad_End}">
                        </div>
                    </div>
                    <div class="widget-header header-color-dark">
                        <h5 class="bigger lighter">
                        </h5>
                        <div class="widget-toolbar">

                            <div class="btn-group">
                            <div>
 
                                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ad/ad.do" style="margin-bottom: 0px;">
<!--  			                    <input type="hidden" name="reply_No"  value="${artiReplyVO.reply_No}">  -->
			                    <input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">
			                    <button class="btn btn-info" type="submit" name="action" value="insertAd">廣告新增</button>
 			                    </FORM>  
                            </div>
                            </div>
                            </div>
                        </div>
                    </div>
                    </FORM>
                </div>
</div>

<hr>

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
    
</body>

<% 
  java.sql.Timestamp arti_Time = null;
  try {
	  arti_Time = adVO.getAd_Start();
   } catch (Exception e) {
	  arti_Time = new java.sql.Timestamp(System.currentTimeMillis());
   }
%>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=arti_Time%>', // value:   new Date(),
        });
</script>
</html>