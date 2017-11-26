<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	 <link rel="stylesheet" href="<%=request.getContextPath()%>/lib/css/recharge/credit.css">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/login_mem.css">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/index/index.css">
    <title>工具人出租</title>
</head>
<body>


<!-- navbar====================================================================== -->


<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"></jsp:include>

<br><br><br><br><br><br><br>
<!-- navbar====================================================================== -->




<!-- 麵包屑 -->

<div class="row">
 <div class="col-xs-12 col-sm-10">
	<ol class="breadcrumb">
	<li>
		<a href="<%=request.getContextPath()%>/lib/publicfile/include/file/index.jsp">首頁</a>
	</li>
	<li>
		<a href="<%=request.getContextPath()%>/frontdesk/mem/memCenter.jsp">會員中心</a>
	</li>
	<!-- <li class="active">媽我上電視了</li> -->
	</ol>
</div>
</div>


<!-- 註冊表單====================================================================== -->


<%-- 錯誤處理 --%>

<c:if test="${not empty errorMsgs}">
	<font style="color:#da0">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:#00f">${message}</li>
		</c:forEach>
	</ul>
</c:if>





<!-- memPageLeft====================================================================== -->



<jsp:include page="/frontdesk/mem/memPageLeft.jsp" flush="true"></jsp:include>


<div class="col-xs-12 col-sm-9">



           
        <div class="demo-container-fluid">
            <h1>After <small>(interactive, exciting)</small></h1>
            <div class="card-wrapper"></div>

            <div class="form-container active">
                <form action="">
                    <p class="small">Start typing in here to take over and try it out</p>
                    <div class="row collapse">
                        <div class="small-6 columns">
                            <input placeholder="Card number" type="text" name="number">
                        </div>
                        <div class="small-6 columns">
                            <input placeholder="Full name" type="text" name="name">
                        </div>
                    </div>
                    <div class="row collapse">
                        <div class="small-3 columns">
                            <input placeholder="MM/YY" type="text" name="expiry">
                        </div>

                        <div class="small-3 columns">
                            <input placeholder="CVC" type="text" name="cvc">
                        </div>

                        <div class="small-6 columns">
                            <input type="submit" value="Submit" class="button postfix">
                        </div>
                    </div>
                </form>
            </div>
        </div>

    </div>


            
            
            
            
        </div>
</div>
</div>

<!-- memPageLeft====================================================================== -->




<!-- footer====================================================================== -->
<br><br><br><br><br><br><br><br><br><br><br><br><br><br>


<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>


<!-- footer====================================================================== -->
<script>
      (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

      ga('create', 'UA-51659791-1', 'jessepollak.github.io');
      ga('send', 'pageview');
      
    </script>
    <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/8.0/highlight.min.js"></script>
    <script src="<%=request.getContextPath()%>/lib/js/recharge/credit.js"></script>
    <script src="https://rawgit.com/jessepollak/card/master/dist/card.js"></script>
    <script>
        $('code').each(function(i, e) {hljs.highlightBlock(e)});
        var card = new Card({ form: '.active form', container: '.card-wrapper' })
    </script>
            


</body>
</html>