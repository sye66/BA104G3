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

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>

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
        <div class="title"><h3>討論區廣告查詢 : <a href="/BA104G3/backdesk/ad/listAllAd_back.jsp">List</a> all AD.
         /                 <a href="/BA104G3/backdesk/ad/addAd.jsp">Add</a> a new AD.</h3><br/>
        </div>
                 <div class="widgetcontent userlistwidget nopadding">
                     <ul>

                         <li>
                             <div class="avatar"><img src="images/thumbs/avatar1.png" alt="" /></div>
                                  <div class="info">
                                  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ad/ad.do" >
                                  <b> 請輸入廣告編號 (如 AD00000001):</b>
                                  <input type="text" name="ad_No">
                                  <button class="btn btn-primary" type="submit" name="action" value="getOneAd_For_Display"> 送出查詢 </button>
                                  </FORM>
                                  </div><!--info-->
                        </li>
                        <li>
                            <div class="avatar"><img src="images/thumbs/avatar2.png" alt="" /></div>
                                <div class="info">
                                 <jsp:useBean id="adSvc" scope="page" class="com.ad.model.AdService" />
                                 
                                <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ad/ad.do " enctype="multipart/form-data">
                                <b>選擇廣告商名稱 :</b>
                                <select size="1" name="ad_Fty_No">
                                <c:forEach var="adVO" items="${adSvc.allAd}" > 
                                <option value="${adVO.ad_Fty_No}">${adVO.ad_Fty_Name}
                                </c:forEach>
                                </select>
                                <input type="hidden" name="ad_Fty_No">
                               <button class="btn btn-primary" type="submit" name="action" value="listAd_ByFtyNo"> 送出查詢 </button>
                               </FORM>
                                </div><!--info-->
                        </li>

                        </ul>
                    </div><!--widgetcontent-->
    </div><!--widgetbox-->

</body>
</html>