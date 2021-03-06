<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>IBM Article: Home</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/arti_back_style.css" />
<style>

    table#table-1 {
    box-shadow: 0 17px 50px 0 rgba(0, 0, 0, 0.01), 0 12px 15px 0 rgba(0, 0, 0, 0.1), 0 0px 50px 0   #8A5CB8, 0 12px 15px 0   #5C5CB8;
    border-radius: 20px;
    text-align: center;
    width: 80%;
    height: 60px;
    padding-top: 30px;
    color: #4cae4c;
    margin : 20px;
    margin-left : 20px;
  }
  
  h3{
    width: 80%;
    height: 25px;  
    margin : 20px;
  }
  
  body{margin:40px;}
  
    a{
   font-size: 24px;
   color: #F00;
  }
  
</style>

</head>
<body bgcolor='white'>


<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	<jsp:include page="/backdesk/artiForm/backdeskLeft_ArtiForm.jsp" flush="true" />



<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

    <div class="widgetbox">
        <div class="title"><h3>討論區文章回覆查詢 : <a href="/BA104G3/backdesk/artiReply/listAllArtiReply_back.jsp">List</a> all Article reply. </h3>
        </div>
                 <div class="widgetcontent userlistwidget nopadding">
                     <ul>

                         <li>
                             <div class="avatar"><img src="images/thumbs/avatar1.png" alt="" /></div>
                                  <div class="info">
                                  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" >
                                  <b> 請輸入回覆文章編號 (如 RE0007001):</b>
                                  <input type="text" name="reply_No">
                                  <button class="btn btn-primary" type="submit" name="action" value="getOneReplyFMback_For_Display"> 送出查詢 </button>
                                  </FORM>
                                  </div><!--info-->
                        </li>
                        <li>
                            <div class="avatar"><img src="images/thumbs/avatar2.png" alt="" /></div>
                                <div class="info">
                                <jsp:useBean id="artiFormSvc" scope="page" class="com.artiForm.model.ArtiFormService" />
                               <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do " enctype="multipart/form-data">
                               <b>請選擇回覆的主題文章標題 :</b>
                               <select size="1" name="arti_No">
                               <c:forEach var="artiFromVO" items="${artiFormSvc.all}" >
                               <option value="${artiFromVO.arti_No}"${(artiFormVO.arti_No==artiReplyVO.arti_No)?'selected':'' }>${artiFromVO.arti_Title}
                               </c:forEach>   
                               </select>
                                <button class="btn btn-primary" type="submit" name="action" value="listReply_ByArtiNo"> 送出查詢 </button>
                                </FORM>
                                </div><!--info-->
                        </li>
                            <li>
                                <div class="avatar"><img src="images/thumbs/avatar1.png" alt="" /></div>
                                    <div class="info">
                                     <jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService"/>
                                     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiReply/artiReply.do" >
                                     <b><font color=orange> 選擇回覆的文章分類 : </font></b>
                                     <select size="1" name="arti_Cls_No">
                                     <c:forEach var="artiClassVO" items="${artiClassSvc.all}" > 
                                     <option value="${artiClassVO.arti_Cls_No}" ${(artiClassVO.arti_Cls_No==artiReplyVO.arti_Cls_No)?'selected':'' }>${artiClassVO.arti_Cls_Name}
                                     </c:forEach>   
                                     </select>
                                     <button class="btn btn-primary" type="submit" name="action" value="listReply_ByArtiClsNo"> 送出查詢 </button>
                                    </FORM>
                                    
                                    </div><!--info-->
                            </li>

                        </ul>
                    </div><!--widgetcontent-->
    </div><!--widgetbox-->
</body>
</html>