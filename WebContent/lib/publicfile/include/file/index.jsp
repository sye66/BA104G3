<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="com.mem.model.*" %>

<% MemVO memVO = (MemVO)request.getSession().getAttribute("login_memVO"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

  <head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Freelancer - Start Bootstrap Theme</title>

    <!-- Bootstrap core CSS -->
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link href="<%=request.getContextPath()%>/lib/publicfile/include/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="<%=request.getContextPath()%>/lib/publicfile/include/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">


    <!-- Custom styles for this template -->
    <link href="<%=request.getContextPath()%>/lib/publicfile/include/css/freelancer.css" rel="stylesheet">

	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/mem/login_mem.css">
	<link rel=stylesheet type="text/css" href="<%=request.getContextPath()%>/lib/css/index/index.css">



  </head>

  <body id="page-top"  style="font-family:Microsoft JhengHei;">

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top" id="mainNav">
      <div class="container">
        <a class="navbar-brand js-scroll-trigger" href="#page-top"><img src="<%=request.getContextPath() %>/lib/publicfile/include/img/logo/profile_1.png"></a>
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          Menu
          <i class="fa fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
           
            
           
            <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="#contact"><i class="glyphicon glyphicon-send"></i> 發案區　</a></h3>
            </li>
            <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="#contact"><i class="glyphicon glyphicon-screenshot"></i> 接案區　</a></h3>
            </li>
             <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="#contact"><i class="glyphicon glyphicon-user"></i> 排行榜　</a></h3>
            </li>
            <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="#contact"><i class="glyphicon glyphicon-list-alt"></i> 討論區　</a></h3>
            </li>
            <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="#contact"><i class="glyphicon glyphicon-shopping-cart"></i> 積分商城　</a></h3>
            </li>
            <li class="nav-item">
              <h3><a class="nav-link js-scroll-trigger" href="#about"><i class="glyphicon glyphicon-user"></i> 會員中心 　</a></h3>
            </li>
             <h3><li class="nav-item"><a class="nav-link js-scroll-trigger" id="create-user" href="<%=request.getContextPath() %>/frontdesk/mem/loginBox_mem.jsp" >
				
				<c:if test="${not empty login_memVO.mem_id}">
				<li><a style="text-decoration:none;" href='#modal-id1' data-toggle="modal">${login_memVO.mem_id}　<i class="glyphicon glyphicon-log-out"></i> 登出</a></li>
				</c:if>
				<c:if test="${empty login_memVO.mem_id}">
				<li><a style="text-decoration:none;" href='#modal-id' data-toggle="modal">${login_memVO.mem_id}　<i class="glyphicon glyphicon-log-in"></i> 登入/註冊　</a></li>
				</c:if>
				</a>
<%--               <h1><a class="nav-link js-scroll-trigger" href="#portfolio">Portfolio　</a></h1> --%>
            </li></h3>
          </ul>
       </div>
      </div>
    </nav>

  
  
<jsp:include page="/lib/publicfile/include/file/loginBox_mem.jsp" flush="true"></jsp:include>



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
            <img id="caro" src="<%=request.getContextPath() %>/res/image/index/carousel/call-center-2275745.jpg" alt="">
            <div class="container">
                <div class="carousel-caption">
                    <h1>CSS可樂好喝超爽快</h1>
                    <p>你喝過了嗎？</p>
                    <p><a class="btn btn-lg btn-primary" href="#" role="button">Sign up today</a></p>
                </div>
            </div>
        </div>
        <div class="item">
            <img id="caro" src="https://api.fnkr.net/testimg/2800x1200/aaaaaa" alt="">
            <div class="container">
                <div class="carousel-caption">
                    <h1>CSS可樂的外掛真方便</h1>
                    <p>你安裝了嗎？</p>
                    <p><a class="btn btn-lg btn-primary" href="#" role="button">更多</a></p>
                </div>
            </div>
        </div>
        <div class="item active">
            <img id="caro" src="https://api.fnkr.net/testimg/2800x1200/aaaaaa" alt="">
            <div class="container">
                <div class="carousel-caption">
                    <h1>我是標題喔～自己改文案吧</h1>
                    <p>我是內文喔，你可以把字打在這裡呦</p>
                    <p><a class="btn btn-lg btn-primary" href="#" role="button">詳細內容</a></p>
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
        <h2 class="text-center">Portfolio</h2>
        <hr class="star-primary">
        <div class="row">
          <div class="col-sm-4 portfolio-item">
            <a class="portfolio-link" href="#portfolioModal1" data-toggle="modal">
              <div class="caption">
                <div class="caption-content">
                  <i class="fa fa-search-plus fa-3x"></i>
                </div>
              </div>
              <img class="img-fluid" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/cabin.png" alt="">
            </a>
          </div>
          <div class="col-sm-4 portfolio-item">
            <a class="portfolio-link" href="#portfolioModal2" data-toggle="modal">
              <div class="caption">
                <div class="caption-content">
                  <i class="fa fa-search-plus fa-3x"></i>
                </div>
              </div>
              <img class="img-fluid" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/cake.png" alt="">
            </a>
          </div>
          <div class="col-sm-4 portfolio-item">
            <a class="portfolio-link" href="#portfolioModal3" data-toggle="modal">
              <div class="caption">
                <div class="caption-content">
                  <i class="fa fa-search-plus fa-3x"></i>
                </div>
              </div>
              <img class="img-fluid" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/circus.png" alt="">
            </a>
          </div>
          <div class="col-sm-4 portfolio-item">
            <a class="portfolio-link" href="#portfolioModal4" data-toggle="modal">
              <div class="caption">
                <div class="caption-content">
                  <i class="fa fa-search-plus fa-3x"></i>
                </div>
              </div>
              <img class="img-fluid" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/game.png" alt="">
            </a>
          </div>
          <div class="col-sm-4 portfolio-item">
            <a class="portfolio-link" href="#portfolioModal5" data-toggle="modal">
              <div class="caption">
                <div class="caption-content">
                  <i class="fa fa-search-plus fa-3x"></i>
                </div>
              </div>
              <img class="img-fluid" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/safe.png" alt="">
            </a>
          </div>
          <div class="col-sm-4 portfolio-item">
            <a class="portfolio-link" href="#portfolioModal6" data-toggle="modal">
              <div class="caption">
                <div class="caption-content">
                  <i class="fa fa-search-plus fa-3x"></i>
                </div>
              </div>
              <img class="img-fluid" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/submarine.png" alt="">
            </a>
          </div>
        </div>
      </div>
    </section>





    
    <!-- Footer -->
    <footer class="text-center">
      <div class="footer-above">
        <div class="container">
          <div class="row">
            <div class="footer-col col-md-4">
              <h2>Location</h2>
              <p>桃園市平鎮區
                <br>中央路300號</p>
              <br><br>
              <h2>Contact us</h2>
              <p>03-3345678</p>
            </div>
            <div class="footer-col col-md-4">
              <h3>Around the Web</h3>
              <ul class="list-inline">
                <li class="list-inline-item">
                  <a class="btn-social btn-outline" href="https://www.facebook.com/">
                    <i class="fa fa-fw fa-facebook"></i>
                  </a>
                </li>
                <li class="list-inline-item">
                  <a class="btn-social btn-outline" href="https://plus.google.com/">
                    <i class="fa fa-fw fa-google-plus"></i>
                  </a>
                </li>
                <li class="list-inline-item">
                  <a class="btn-social btn-outline" href="https://twitter.com/">
                    <i class="fa fa-fw fa-twitter"></i>
                  </a>
                </li>
              </ul>
            </div>
            <div class="footer-col col-md-4">
              <h3>QR code</h3>
              <p>
                <img src="<%=request.getContextPath()%>/lib/publicfile/include/img/QRcode/static_qr_code_100.jpg"></p>
            </div>
          </div>
        </div>
      </div>
      <div class="footer-below">
        <div class="container">
          <div class="row">
            <div class="col-lg-12">
              Copyright &copy; POTM 2017
            </div>
          </div>
        </div>
      </div>
    </footer>

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
                  <img class="img-fluid img-centered" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/cabin.png" alt="">
                  <p>Use this area of the page to describe your project. The icon above is part of a free icon set by
                    <a href="https://sellfy.com/p/8Q9P/jV3VZ/">Flat Icons</a>. On their website, you can download their free set with 16 icons, or you can purchase the entire set with 146 icons for only $12!</p>
                  <ul class="list-inline item-details">
                    <li>Client:
                      <strong>
                        <a href="http://startbootstrap.com">Start Bootstrap</a>
                      </strong>
                    </li>
                    <li>Date:
                      <strong>
                        <a href="http://startbootstrap.com">April 2014</a>
                      </strong>
                    </li>
                    <li>Service:
                      <strong>
                        <a href="http://startbootstrap.com">Web Development</a>
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
                  <img class="img-fluid img-centered" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/cake.png" alt="">
                  <p>Use this area of the page to describe your project. The icon above is part of a free icon set by
                    <a href="https://sellfy.com/p/8Q9P/jV3VZ/">Flat Icons</a>. On their website, you can download their free set with 16 icons, or you can purchase the entire set with 146 icons for only $12!</p>
                  <ul class="list-inline item-details">
                    <li>Client:
                      <strong>
                        <a href="http://startbootstrap.com">Start Bootstrap</a>
                      </strong>
                    </li>
                    <li>Date:
                      <strong>
                        <a href="http://startbootstrap.com">April 2014</a>
                      </strong>
                    </li>
                    <li>Service:
                      <strong>
                        <a href="http://startbootstrap.com">Web Development</a>
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
                  <img class="img-fluid img-centered" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/circus.png" alt="">
                  <p>Use this area of the page to describe your project. The icon above is part of a free icon set by
                    <a href="https://sellfy.com/p/8Q9P/jV3VZ/">Flat Icons</a>. On their website, you can download their free set with 16 icons, or you can purchase the entire set with 146 icons for only $12!</p>
                  <ul class="list-inline item-details">
                    <li>Client:
                      <strong>
                        <a href="http://startbootstrap.com">Start Bootstrap</a>
                      </strong>
                    </li>
                    <li>Date:
                      <strong>
                        <a href="http://startbootstrap.com">April 2014</a>
                      </strong>
                    </li>
                    <li>Service:
                      <strong>
                        <a href="http://startbootstrap.com">Web Development</a>
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
                  <img class="img-fluid img-centered" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/game.png" alt="">
                  <p>Use this area of the page to describe your project. The icon above is part of a free icon set by
                    <a href="https://sellfy.com/p/8Q9P/jV3VZ/">Flat Icons</a>. On their website, you can download their free set with 16 icons, or you can purchase the entire set with 146 icons for only $12!</p>
                  <ul class="list-inline item-details">
                    <li>Client:
                      <strong>
                        <a href="http://startbootstrap.com">Start Bootstrap</a>
                      </strong>
                    </li>
                    <li>Date:
                      <strong>
                        <a href="http://startbootstrap.com">April 2014</a>
                      </strong>
                    </li>
                    <li>Service:
                      <strong>
                        <a href="http://startbootstrap.com">Web Development</a>
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
                  <img class="img-fluid img-centered" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/safe.png" alt="">
                  <p>Use this area of the page to describe your project. The icon above is part of a free icon set by
                    <a href="https://sellfy.com/p/8Q9P/jV3VZ/">Flat Icons</a>. On their website, you can download their free set with 16 icons, or you can purchase the entire set with 146 icons for only $12!</p>
                  <ul class="list-inline item-details">
                    <li>Client:
                      <strong>
                        <a href="http://startbootstrap.com">Start Bootstrap</a>
                      </strong>
                    </li>
                    <li>Date:
                      <strong>
                        <a href="http://startbootstrap.com">April 2014</a>
                      </strong>
                    </li>
                    <li>Service:
                      <strong>
                        <a href="http://startbootstrap.com">Web Development</a>
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
                  <img class="img-fluid img-centered" src="<%=request.getContextPath()%>/lib/publicfile/include/img/portfolio/submarine.png" alt="">
                  <p>Use this area of the page to describe your project. The icon above is part of a free icon set by
                    <a href="https://sellfy.com/p/8Q9P/jV3VZ/">Flat Icons</a>. On their website, you can download their free set with 16 icons, or you can purchase the entire set with 146 icons for only $12!</p>
                  <ul class="list-inline item-details">
                    <li>Client:
                      <strong>
                        <a href="http://startbootstrap.com">Start Bootstrap</a>
                      </strong>
                    </li>
                    <li>Date:
                      <strong>
                        <a href="http://startbootstrap.com">April 2014</a>
                      </strong>
                    </li>
                    <li>Service:
                      <strong>
                        <a href="http://startbootstrap.com">Web Development</a>
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
  </body>

</html>
