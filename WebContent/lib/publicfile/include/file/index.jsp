<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>

<jsp:useBean id="MemSvc" scope="page" class="com.mem.model.MemService"/>



<% MemVO memVO = (MemVO)request.getSession().getAttribute("memVO"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>工具人出租</title>

    <!-- Bootstrap core CSS -->
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link href="<%=request.getContextPath()%>/lib/publicfile/include/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="<%=request.getContextPath()%>/lib/publicfile/include/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<!--     <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css"> -->
<!--     <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css"> -->


    <!-- Custom styles for this template -->
    <link href="<%=request.getContextPath()%>/lib/publicfile/include/css/freelancer.css" rel="stylesheet">

	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/login_mem.css">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/index/index.css">



  </head>

  <body id="page-top"  style="font-family:Microsoft JhengHei;">

<!-- navbar====================================================================== -->



<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true"></jsp:include>
<br><br><br><br><br><br>

<!-- navbar====================================================================== -->




<!-- 旋轉木馬 ===================================================-->




<div id="carousel-id" class="carousel slide" data-ride="carousel">
    <!-- 幻燈片小圓點區 -->
   <%--  <ol class="carousel-indicators">
        <li data-target="#carousel-id" data-slide-to="0" class=""></li>
        <li data-target="#carousel-id" data-slide-to="1" class=""></li>
        <li data-target="#carousel-id" data-slide-to="2" class="active"></li>
    </ol> --%>
    <!-- 幻燈片主圖區 -->
    <div class="carousel-inner">
        <div class="item">
            <img id="caro" src="<%=request.getContextPath() %>/res/images/mem/index/carousel/carousel_1.jpg" alt="">
            <div class="container">
                <div class="carousel-caption">
                    <h1 style="font-size:100px">家裡狗狗怎樣都教不會嗎?</h1>
                    <p>這邊除了可以找到你的狗友們，更能找到訓練專家!</p>
<!--                     <p><a class="btn btn-lg btn-primary" href="#" role="button">Sign up today</a></p> -->
                </div>
            </div>
        </div>
        <div class="item">
            <img id="caro" src="<%=request.getContextPath() %>/res/images/mem/index/carousel/carousel_2.jpg" alt="">
            <div class="container">
                <div class="carousel-caption">
                    <h1 style="font-size:100px">最棒的下午茶蛋糕在哪裡?</h1>
                    <p>自己動手做，喜歡烘培的朋友們趕快來交流!</p>
<!--                     <p><a class="btn btn-lg btn-primary" href="#" role="button">更多</a></p> -->
                </div>
            </div>
        </div>
        <div class="item active">
            <img id="caro" src="<%=request.getContextPath() %>/res/images/mem/index/carousel/carousel_3.jpg" alt="">
            <div class="container">
                <div class="carousel-caption">
                    <h1 style="font-size:100px">想要找獨家私房菜嗎?</h1>
                    <p style="font-size:20px">這裡不僅能找到同好饕友，更有獨家手路菜等你發掘!</p>
<!--                     <p><a class="btn btn-lg btn-primary" href="#" role="button">詳細內容</a></p> -->
                </div>
            </div>
        </div>
         <div class="item">
            <img id="caro" src="<%=request.getContextPath() %>/res/images/mem/index/carousel/carousel_4.jpg" alt="">
            <div class="container">
                <div class="carousel-caption">
                    <h1 style="font-size:100px">找不到好口碑婚攝、商攝嗎?</h1>
                    <p>專家都在這，想學攝影或找同好更不能錯過!</p>
<!--                     <p><a class="btn btn-lg btn-primary" href="#" role="button">詳細內容</a></p> -->
                </div>
            </div>
        </div>
        <div class="item">
            <img id="caro" src="<%=request.getContextPath() %>/res/images/mem/index/carousel/carousel_5.jpg" alt="">
            <div class="container">
                <div class="carousel-caption">
                    <h1 style="font-size:100px">想完成小時後學樂器的夢嗎?</h1>
                    <p>也許你可以把你拿手的專長與他人教學互長!</p>
<!--                     <p><a class="btn btn-lg btn-primary" href="#" role="button">詳細內容</a></p> -->
                </div>
            </div>
        </div>
    </div>
    </div>
    
    <!-- 上下頁控制區 -->
    <a class="left carousel-control" href="#carousel-id" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
    <a class="right carousel-control" href="#carousel-id" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
</div>  




<!-- 旋轉木馬 ===================================================-->



  <!-- Header -->
    <header class="masthead">
      <div class="container">
        <img class="img-fluid" src="<%=request.getContextPath()%>/lib/publicfile/include/img/panda.jpg" alt="">
        <div class="intro-text">
          <span class="name">Start Bootstrap</span>
          <hr class="star-light">
          <span class="skills">Web Developer - Graphic Artist - User Experience Designer</span>
        </div>
      </div>
    </header>






 <!-- Portfolio Grid Section -->
    <section id="portfolio">
      <div class="container">
        <h2 class="text-center">POTM</h2>
        <hr class="star-primary">
        <div class="row">
          <div class="col-sm-4 portfolio-item">
            <a class="portfolio-link" href="#portfolioModal1" data-toggle="modal">
              <div class="caption">
                <div class="caption-content">
                  <i class="fa fa-search-plus fa-3x"></i>
                </div>
              </div>
              <img class="img-fluid" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/indexPhoto_1.png" alt="">
            </a>
          </div>
          <div class="col-sm-4 portfolio-item">
            <a class="portfolio-link" href="#portfolioModal2" data-toggle="modal">
              <div class="caption">
                <div class="caption-content">
                  <i class="fa fa-search-plus fa-3x"></i>
                </div>
              </div>
              <img class="img-fluid" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/indexPhoto_2.png" alt="">
            </a>
          </div>
          <div class="col-sm-4 portfolio-item">
            <a class="portfolio-link" href="#portfolioModal3" data-toggle="modal">
              <div class="caption">
                <div class="caption-content">
                  <i class="fa fa-search-plus fa-3x"></i>
                </div>
              </div>
              <img class="img-fluid" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/indexPhoto_3.png" alt="">
            </a>
          </div>
          <div class="col-sm-4 portfolio-item">
            <a class="portfolio-link" href="#portfolioModal4" data-toggle="modal">
              <div class="caption">
                <div class="caption-content">
                  <i class="fa fa-search-plus fa-3x"></i>
                </div>
              </div>
              <img class="img-fluid" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/indexPhoto_4.png" alt="">
            </a>
          </div>
          <div class="col-sm-4 portfolio-item">
            <a class="portfolio-link" href="#portfolioModal5" data-toggle="modal">
              <div class="caption">
                <div class="caption-content">
                  <i class="fa fa-search-plus fa-3x"></i>
                </div>
              </div>
              <img class="img-fluid" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/indexPhoto_5.png" alt="">
            </a>
          </div>
          <div class="col-sm-4 portfolio-item">
            <a class="portfolio-link" href="#portfolioModal6" data-toggle="modal">
              <div class="caption">
                <div class="caption-content">
                  <i class="fa fa-search-plus fa-3x"></i>
                </div>
              </div>
              <img class="img-fluid" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/indexPhoto_6.png" alt="">
            </a>
          </div>
        </div>
      </div>
    </section>





    
  

    <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes) -->
    <div class="scroll-top d-lg-none">
      <a class="btn btn-primary js-scroll-trigger" href="#page-top">
        <i class="fa fa-chevron-up"></i>
      </a>
    </div>

    <!-- Portfolio Modals -->
    <div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="close-modal" data-dismiss="modal">
            <div class="lr">
              <div class="rl"></div>
            </div>
          </div>
          <div class="container">
            <div class="row">
              <div class="col-lg-8 mx-auto">
                <div class="modal-body">
                  <h2>Project Title</h2>
                  <hr class="star-primary">
                  <img class="img-fluid img-centered" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/indexPhoto_1.png" alt="">
                  <p>原本以為稍微漏水沒關係，完全沒想到，一年後會釀成這般悲劇??找不到信任的修繕人員嗎?這個平台能找到讓你安心的服務</p>
                  <ul class="list-inline item-details">
                    <li>Client:
                      <strong>
                        <a href="#">POTM</a>
                      </strong>
                    </li>
                    <li>Date:
                      <strong>
                        <a href="#">June 2017</a>
                      </strong>
                    </li>
                    <li>Service:
                      <strong>
                        <a href="#">Web Development</a>
                      </strong>
                    </li>
                  </ul>
                  <button class="btn btn-success" type="button" data-dismiss="modal">
                    <i class="fa fa-times"></i>
                    Close</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="portfolio-modal modal fade" id="portfolioModal2" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="close-modal" data-dismiss="modal">
            <div class="lr">
              <div class="rl"></div>
            </div>
          </div>
          <div class="container">
            <div class="row">
              <div class="col-lg-8 mx-auto">
                <div class="modal-body">
                  <h2>Project Title</h2>
                  <hr class="star-primary">
                  <img class="img-fluid img-centered" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/indexPhoto_2.png" alt="">
                  <p>進行配對邀約時，我們只會提供一份簡易版本讓對方評估是否選擇約會，不會公開在任何公用空間。簡易資料內容只包含基本條件，而姓名、照片、電話等個人資料都不會提供，請您放心。</p>
                  <ul class="list-inline item-details">
                    <li>Client:
                      <strong>
                        <a href="#">POTM</a>
                      </strong>
                    </li>
                    <li>Date:
                      <strong>
                        <a href="#">Junes 2017</a>
                      </strong>
                    </li>
                    <li>Service:
                      <strong>
                        <a href="#">Web Development</a>
                      </strong>
                    </li>
                  </ul>
                  <button class="btn btn-success" type="button" data-dismiss="modal">
                    <i class="fa fa-times"></i>
                    Close</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="portfolio-modal modal fade" id="portfolioModal3" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="close-modal" data-dismiss="modal">
            <div class="lr">
              <div class="rl"></div>
            </div>
          </div>
          <div class="container">
            <div class="row">
              <div class="col-lg-8 mx-auto">
                <div class="modal-body">
                  <h2>Project Title</h2>
                  <hr class="star-primary">
                  <img class="img-fluid img-centered" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/indexPhoto_3.png" alt="">
                  <p>相信大多數人都有學習過彈鋼琴的經驗，其實在彈奏這種鍵盤樂器時，可是要同時考慮旋律、節奏、和聲等複數以上的要素，因此可以自然養成對音樂要求整體平衡的能力。這裡一定能找到你的良師益友</p>
                  <ul class="list-inline item-details">
                    <li>Client:
                      <strong>
                        <a href="#">POTM</a>
                      </strong>
                    </li>
                    <li>Date:
                      <strong>
                        <a href="#">June 2017</a>
                      </strong>
                    </li>
                    <li>Service:
                      <strong>
                        <a href="#">Web Development</a>
                      </strong>
                    </li>
                  </ul>
                  <button class="btn btn-success" type="button" data-dismiss="modal">
                    <i class="fa fa-times"></i>
                    Close</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="portfolio-modal modal fade" id="portfolioModal4" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="close-modal" data-dismiss="modal">
            <div class="lr">
              <div class="rl"></div>
            </div>
          </div>
          <div class="container">
            <div class="row">
              <div class="col-lg-8 mx-auto">
                <div class="modal-body">
                  <h2>Project Title</h2>
                  <hr class="star-primary">
                  <img class="img-fluid img-centered" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/indexPhoto_4.png" alt="">
                  <p>在只有景觀窗的情況下，每一次的拍攝都要非常精準，才能捕捉到瞬間的美，如果一個閃神，眼前所見的景色就會產生不同的變化。歡迎好攝之友來交流!</p>
                  <ul class="list-inline item-details">
                    <li>Client:
                      <strong>
                        <a href="#">Start Bootstrap</a>
                      </strong>
                    </li>
                    <li>Date:
                      <strong>
                        <a href="#">June 2017</a>
                      </strong>
                    </li>
                    <li>Service:
                      <strong>
                        <a href="#">Web Development</a>
                      </strong>
                    </li>
                  </ul>
                  <button class="btn btn-success" type="button" data-dismiss="modal">
                    <i class="fa fa-times"></i>
                    Close</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="portfolio-modal modal fade" id="portfolioModal5" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="close-modal" data-dismiss="modal">
            <div class="lr">
              <div class="rl"></div>
            </div>
          </div>
          <div class="container">
            <div class="row">
              <div class="col-lg-8 mx-auto">
                <div class="modal-body">
                  <h2>Project Title</h2>
                  <hr class="star-primary">
                  <img class="img-fluid img-centered" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/indexPhoto_5.png" alt="">
                  <p>延伸提供的實體交友服務，擁有另外獨立的顧客資料庫。我們安排更多的機會，讓我們的會員參與各種類型的互動；同時也致力於一對一配對約會，依據每位會員需求，提供最完善的服務。</p>
                  <ul class="list-inline item-details">
                    <li>Client:
                      <strong>
                        <a href="#">POTM</a>
                      </strong>
                    </li>
                    <li>Date:
                      <strong>
                        <a href="#">June 2017</a>
                      </strong>
                    </li>
                    <li>Service:
                      <strong>
                        <a href="#">Web Development</a>
                      </strong>
                    </li>
                  </ul>
                  <button class="btn btn-success" type="button" data-dismiss="modal">
                    <i class="fa fa-times"></i>
                    Close</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="portfolio-modal modal fade" id="portfolioModal6" tabindex="-1" role="dialog" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="close-modal" data-dismiss="modal">
            <div class="lr">
              <div class="rl"></div>
            </div>
          </div>
          <div class="container">
            <div class="row">
              <div class="col-lg-8 mx-auto">
                <div class="modal-body">
                  <h2>Project Title</h2>
                  <hr class="star-primary">
                  <img class="img-fluid img-centered" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/indexPhoto_6.png" alt="">
                  <p>每週固定安排各式新奇有趣的主題活動，包括手作輕食、品酒教學、遊艇派對、兩性講座等有趣特別的活動，滿足種不同興趣喜好或樂於嘗試的會員。</p>
                  <ul class="list-inline item-details">
                    <li>Client:
                      <strong>
                        <a href="#">POTM</a>
                      </strong>
                    </li>
                    <li>Date:
                      <strong>
                        <a href="#">June 2017</a>
                      </strong>
                    </li>
                    <li>Service:
                      <strong>
                        <a href="#">Web Development</a>
                      </strong>
                    </li>
                  </ul>
                  <button class="btn btn-success" type="button" data-dismiss="modal">
                    <i class="fa fa-times"></i>
                    Close</button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    
    
<!-- footer====================================================================== -->
<br><br><br><br><br><br><br>


<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true"></jsp:include>


<!-- footer====================================================================== -->
    
    
    

    <!-- Bootstrap core JavaScript -->
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/vendor/jquery/jquery.js"></script>
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/vendor/jquery-easing/jquery.easing.min.js"></script>



    <script src="<%=request.getContextPath()%>/lib/publicfile/include/vendor/jquery/jquery-3.2.1.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/vendor/bootstrap/js/bootstrap330.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<%--     <script src="<%=request.getContextPath()%>/front/jquery-twzipcode-master/jquery.twzipcode.js"></script> <!-- 台灣地址選擇器 --> --%>
<%--     <script src="<%=request.getContextPath()%>/front/MDP/jquery-ui.multidatespicker.js"></script> --%>



    <!-- Contact Form JavaScript -->
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/js/jqBootstrapValidation.js"></script>
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/js/contact_me.js"></script>

    <!-- Custom scripts for this template -->
    <script src="<%=request.getContextPath()%>/lib/publicfile/include/js/freelancer.min.js"></script>
    
    
    <c:if test="${memVO.mem_State ==9}">
  <script>
  swal('Oops !','你被停權囉！ 請至你的信箱收信' , 'error');
   </script>
   </c:if>
    
    
    
  </body>

</html>
