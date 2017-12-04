<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.rank.model.*"%>
<%@ page import="com.relation.model.*"%>
<%@ page import="com.artiForm.model.*"%>
<%@ page import="com.relation.model.*"%>
<%@ page import="com.missioncomment.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/lib/css/getmission/star.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">

<link rel='stylesheet prefetch' href='http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css'>

<jsp:useBean id="RelationSvc" scope="page" class="com.relation.model.RelationService"/>
<jsp:useBean id="memmemSvc" scope="page" class="com.mem.model.MemService"/>
<jsp:useBean id="getMissionSvc" scope="page" class="com.getmission.model.GetMissionService" />
<% 
	MemVO memVO = (MemVO)session.getAttribute("memVO");
	String mem_No = memVO.getMem_No();
	String mem_No_main = memVO.getMem_No();
	//所有會員
	MemService memSvc = new MemService();
	List<MemVO> getAllMemVO = memSvc.getAll();
	MemVO noVO = memSvc.getOneMem(mem_No);
	MemVO noVO1 = memSvc.getOneMem("OFFICAL000001");
	MemVO noVO2 = memSvc.getOneMem("OFFICAL000002");
	getAllMemVO.remove(noVO);
	getAllMemVO.remove(noVO1);
	getAllMemVO.remove(noVO2);
	pageContext.setAttribute("getAllMemVO", getAllMemVO);
	pageContext.setAttribute("memSvc", memSvc);
	
	//顯示自己排名
	RankService rankSvc = new RankService();
	RankVO rankVO = rankSvc.getOneRank(mem_No);
	pageContext.setAttribute("rankVO",rankVO);
	//顯示自己文章
	ArtiFormService artiSvc = new ArtiFormService();
	Set<ArtiFormVO> set = (Set<ArtiFormVO>)artiSvc.findArtiByMemNo(mem_No_main);
	pageContext.setAttribute("set", set);
	
	//*********************************  智群********************
	
	
	
	//顯示好友
	RelationService relationSvc = new RelationService();
	List<RelationVO> relationVO = relationSvc.getAllFriends(mem_No);
	System.out.println("memNO +"+ mem_No);
	pageContext.setAttribute("relationVO", relationVO);
	
	//顯示誰+你好友
	List<RelationVO> relationVO1 = relationSvc.getWhoAddme(mem_No);
	pageContext.setAttribute("relationVO1", relationVO1);
	
// 	RelationVO relationVO2 = relationSvc.getOneRelationVO(mem_No);
	
	
	//*********************************  智群********************
	
	//抓星星
	MissionCommentService mcSvc = new MissionCommentService();

	List<MissionCommentVO> tryVO = mcSvc.getByReviewer(mem_No);
	pageContext.setAttribute("tryVO", tryVO);
	
	
	for(MissionCommentVO z : tryVO){
		System.out.println(z.getComment_Point()+"+++++++++++++++++++++++++++++++++++++");
	}

	List<MissionCommentVO> tryVO2 = mcSvc.getByListener(mem_No);
	pageContext.setAttribute("tryVO2", tryVO2);
	
%>

      <%request.getSession().setAttribute("memVO" ,memVO); %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
	<style>
/* 		body, html { */
/*     height: 125%; */
/*     background-repeat: no-repeat; */
/*     background-image: linear-gradient(rgb(200, 300, 400), rgb(100, 200, 300)); */
/* } */
/**
 * Profile image component
 */
/* .profile-header-container{ */
/*     margin: 0 auto; */
/*     text-align: center; */
/* } */

.profile-header-img {
    padding: 54px;
}

.profile-header-img > img.img-circle {
    width: 300px;
    height: 300px;
    border: 2px solid #51D2B7;
}

/* .profile-header { */
/*     margin-top: 43px; */
/* } */

/**
 * Ranking component
 */
.rank-label-container {
    margin-top: -19px;
    /* z-index: 1000; */
    text-align: center;
}

/* .label.label-default.rank-label { */
/*     background-color: rgb(81, 210, 183); */
/*     padding: 5px 10px 5px 10px; */
/*     border-radius: 27px; */
/* } */

/* body{padding: 10px 250px; text-align: center; font-family: 'Shadows Into Light', cursive; font-size: 30px;} */

.social {
    position: relative;
    height: 10em;
    width: 50em;
    margin: 150px; 
}

.social li {
    display: block;
    height: 4em;
    line-height: 4em;
    margin: -2.2em;
    position: absolute;
    -webkit-transition: -webkit-transform .7s;
    -moz-transition: -moz-transform .7s;
    -ms-transition: -ms-transform .7s;
    -o-transition: -o-transform .7s;
    transition: transform .7s;
    -webkit-transform: rotate(45deg);
    -moz-transform: rotate(45deg);
    -ms-transform: rotate(45deg);
    -o-transform: rotate(45deg);
    transform: rotate(45deg);
    text-align: center;
    width: 4em;

}

.social a {
    color: #fffdf0;
    display: block;
    height: 10em;
    line-height: 0;
    text-align: center;
    -webkit-transform: rotate(-45deg);
    -moz-transform: rotate(-45deg);
    -ms-transform: rotate(-45deg);
    -o-transform: rotate(-45deg);
    transform: rotate(-45deg);
    width: 4em; 
  
}

.social li:hover {
  -webkit-transform: scale(1.3,1.3) rotate(45deg);
    -moz-transform: scale(1.3,1.3) rotate(45deg);
  -ms-transform: scale(1.3,1.3) rotate(45deg);
    -o-transform: scale(1.3,1.3) rotate(45deg);
  transform: scale(1.3,1.3) rotate(45deg);
}

.jump:hover {
  -webkit-transform: scale(1.3,1.3) ;
    -moz-transform: scale(1.3,1.3) ;
  -ms-transform: scale(1.3,1.3) ;
    -o-transform: scale(1.3,1.3) ;
  transform: scale(1.3,1.3) ;
}

.facebook {
    background: #155b9d;
    left: 0;
    top: 0%;
    padding:50px;
}

.twitter {
    background: #1a9ec4;
    bottom: 0;
    left: 25%;
     padding:50px;
}

.pinterest {
    background: #e11a30;
    left: 50%;
    top: 0%;
     padding:50px;
}
.behance {
    background: #3f7aa3;
    bottom: 0;
    left: 75%;
     padding:50px;
}

.colorgraph {
  height: 7px;
  border-top: 0;
  background: #c4e17f;
  border-radius: 5px;
  background-image: -webkit-linear-gradient(left, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
  background-image: -moz-linear-gradient(left, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
  background-image: -o-linear-gradient(left, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
  background-image: linear-gradient(to right, #c4e17f, #c4e17f 12.5%, #f7fdca 12.5%, #f7fdca 25%, #fecf71 25%, #fecf71 37.5%, #f0776c 37.5%, #f0776c 50%, #db9dbe 50%, #db9dbe 62.5%, #c49cde 62.5%, #c49cde 75%, #669ae1 75%, #669ae1 87.5%, #62c2e4 87.5%, #62c2e4);
}

	</style>
	
</head>

<body style="background-color : #fff">
	<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true" />
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>

	<div class="container">
	<div class="row">
		<div class="col-xs-12 col-sm-4">
			<div class="profile-header-container">   
    		<div class="profile-header-img">
                <img class="img-circle" id="img" weight="150" height="150" src="<%=request.getContextPath() %>/personalShowPic/personalShowPic.do?mem_No=${memVO.mem_No}">
                <!-- badge -->
                <div class="rank-label-container">
                    <span class="label label-default rank-label">${memVO.mem_Intro}</span>
                </div>
            </div>
        </div>
		</div>
		<div class="col-xs-12 col-sm-8">
			<ul class="social">
                <li class="facebook"><a href="<%=request.getContextPath()%>/frontdesk/personal/personalMissionHistory.jsp">歷史查詢</a></li>
                <li class="twitter"><a href="<%=request.getContextPath()%>/frontdesk/mem/memUpdateFile.jsp">修改資料</a></li>
                <li class="pinterest"><img src="#"><i class="fa fa-pinterest-p fa-3x"></i></li>
                <li class="behance"><a href="<%=request.getContextPath()%>/frontdesk/personal/personalAchieve.jsp">成就查詢</a></li>
            </ul>
		</div>
	</div>
</div>

	<div class="container">
	<div class="row">
		<div class="col-xs-12 col-sm-12">
	<hr class="colorgraph"> 
		</div>
	</div>
</div>	

<div class="container">
	<div class="row">
		<div class="col-xs-12 col-sm-4">
		
<!-- 		//*********************************  智群******************** -->
		
			<div class="panel panel-primary">
 				  <div class="panel-heading">
 				    <h3 class="panel-title"> 好友</h3>
 				  </div>
 				  <div class="panel-body">
 				    <table class="table table-hover">
 				    	<c:forEach var="relationVO" items="<%=relationVO%>" varStatus="om">
 				    	<c:if test="${relationVO.relation_Status==1}">
 				    	<c:if test="${(om.count%3)==1}">
 				    		<tr>
	 				    		<td class="jump">
	 				    			<a href="<%=request.getContextPath()%>/all/all.do?mem_No=${relationVO.mem_No}">
	 				    			<img id="img" width="50px" height="50px" data-toggle="tooltip" title="${memSvc.getOneMem(relationVO.getMem_No()).getMem_Intro()}" src="<%=request.getContextPath() %>/personalShowPic/personalShowPic.do?mem_No=${memSvc.getOneMem(relationVO.getMem_No()).getMem_No()}">
	 				    			</a>
	 				    		</td>
 				    	</c:if>
 				    	<c:if test="${(om.count%3)==2}">
	 				    		<td class="jump">
	 				    			<a href="<%=request.getContextPath()%>/all/all.do?mem_No=${relationVO.mem_No}">
	 				    			<img id="img" width="50px" height="50px" data-toggle="tooltip" title="${memSvc.getOneMem(relationVO.getMem_No()).getMem_Intro()}" src="<%=request.getContextPath() %>/personalShowPic/personalShowPic.do?mem_No=${memSvc.getOneMem(relationVO.getMem_No()).getMem_No()}">
	 				    			</a>
	 				    		</td>	
 				    	</c:if>
 				    	<c:if test="${(om.count%3)==0}">
	 				    		<td class="jump">
	 				    			<a href="<%=request.getContextPath()%>/all/all.do?mem_No=${relationVO.mem_No}">
	 				    			<img id="img" width="50px" height="50px" data-toggle="tooltip" title="${memSvc.getOneMem(relationVO.getMem_No()).getMem_Intro()}" src="<%=request.getContextPath() %>/personalShowPic/personalShowPic.do?mem_No=${memSvc.getOneMem(relationVO.getMem_No()).getMem_No()}">
	 				    			</a>
	 				    		</td>	
	 				    	</tr>
 				    	</c:if>
 				    	</c:if>
 				    	</c:forEach>
 				    </table>				
 				  </div>
 				</div>
			<div class="panel panel-primary">
 				  <div class="panel-heading">
 				    <h3 class="panel-title"> 向你申請加入好友</h3>
 				  </div>
 				  <div class="panel-body">
 				    <table class="table table-hover">
 				    	<c:forEach var="relationVO1" items="<%=relationVO1%>" varStatus="om">
<%--  				    	<c:if test="${relationVO1.relation_Status==0}"> --%>
 				    	<c:if test="${(om.count%3)==1}">
 				    		<tr>
	 				    		<td class="jump">
	 				    			<a href="<%=request.getContextPath()%>/all/all.do?mem_No=${memSvc.getOneMem(relationVO1.getMem_No()).getMem_No()}">
	 				    			<img id="img" width="50px" height="50px" data-toggle="tooltip" title="${memSvc.getOneMem(relationVO1.getMem_No()).getMem_Intro()}" src="<%=request.getContextPath() %>/personalShowPic/personalShowPic.do?mem_No=${memSvc.getOneMem(relationVO1.getMem_No()).getMem_No()}">
	 				    			</a>
	 				    		</td>
 				    	</c:if>
 				    	<c:if test="${(om.count%3)==2}">
	 				    		<td class="jump">
	 				    			<a href="<%=request.getContextPath()%>/all/all.do?mem_No=${memSvc.getOneMem(relationVO1.getMem_No()).getMem_No()}">
	 				    			<img id="img" width="50px" height="50px" data-toggle="tooltip" title="${memSvc.getOneMem(relationVO1.getMem_No()).getMem_Intro()}" src="<%=request.getContextPath() %>/personalShowPic/personalShowPic.do?mem_No=${memSvc.getOneMem(relationVO1.getMem_No()).getMem_No()}">
	 				    			</a>
	 				    		</td>	
 				    	</c:if>
 				    	<c:if test="${(om.count%3)==0}">
	 				    		<td class="jump">
	 				    			<a href="<%=request.getContextPath()%>/all/all.do?mem_No=${memSvc.getOneMem(relationVO1.getMem_No()).getMem_No()}">
	 				    			<img id="img" width="50px" height="50px" data-toggle="tooltip" title="${memSvc.getOneMem(relationVO1.getMem_No()).getMem_Intro()}" src="<%=request.getContextPath() %>/personalShowPic/personalShowPic.do?mem_No=${memSvc.getOneMem(relationVO1.getMem_No()).getMem_No()}">
	 				    			</a>
	 				    		</td>	
	 				    	</tr>
 				    	</c:if>
<%--  				    	</c:if> --%>
 				    	</c:forEach>
 				    </table>				
 				  </div>
 				</div>
 				
<!--  				//*********************************  智群******************** -->
 				
			<div class="panel panel-primary">
 				  <div class="panel-heading">
 				    <h3 class="panel-title"> 會員列表</h3>
 				  </div>
 				  <div class="panel-body">
 				    <table class="table table-hover">
 				    	<c:forEach var="all" items="${getAllMemVO}" varStatus="om">
 				    	<c:if test="${relationVO.relation_Status!=1}">
 				    	<c:if test="${(om.count%3)==1}">
 				    		<tr>
	 				    		<td class="jump">
	 				    			<a href="<%=request.getContextPath()%>/all/all.do?mem_No=${all.mem_No}">
	 				    			<img id="img" width="50px" height="50px" data-toggle="tooltip" title="${all.mem_Intro}" src="<%=request.getContextPath() %>/personalShowPic/personalShowPic.do?mem_No=${all.mem_No}">
	 				    			</a>
	 				    		</td>
 				    	</c:if>
 				    	<c:if test="${(om.count%3)==2}">
	 				    		<td class="jump">
	 				    			<a href="<%=request.getContextPath()%>/all/all.do?mem_No=${all.mem_No}">
	 				    			<img id="img" width="50px" height="50px" data-toggle="tooltip" title="${all.mem_Intro}" src="<%=request.getContextPath() %>/personalShowPic/personalShowPic.do?mem_No=${all.mem_No}">
	 				    			</a>
	 				    		</td>	
 				    	</c:if>
 				    	<c:if test="${(om.count%3)==0}">
	 				    		<td class="jump">
	 				    			<a href="<%=request.getContextPath()%>/all/all.do?mem_No=${all.mem_No}">
	 				    			<img id="img" width="50px" height="50px" data-toggle="tooltip" title="${all.mem_Intro}" src="<%=request.getContextPath() %>/personalShowPic/personalShowPic.do?mem_No=${all.mem_No}">
	 				    			</a>
	 				    		</td>	
	 				    	</tr>
 				    	</c:if>
 				    	</c:if>
 				    	</c:forEach>
 				    </table>				
 				  </div>
 				</div>
		</div>
		<div class="col-xs-12 col-sm-4">
			<div class="panel panel-info">
					  <div class="panel-heading">
					    <h3 class="panel-title">看看吧</h3>
					  </div>
					  <div class="panel-body">
					    <table class="table table-hover">
					    	<!-- <caption>我是表格標題</caption> -->
					    	<thead>
					    		<th>
					    			<a href="<%=request.getContextPath()%>/frontdesk/artiForm/listArti_ByMemNo.jsp">
					    			<button class="btn btn-warning">前往個人文章頁面</button></a>
					    		</th>
					    	</thead>
					    	<tbody>
					    	<c:forEach var="artiFormVO" items="${set}">
					    		<tr>
					    			<td>你發表了《${artiFormVO.arti_No}》這篇文章</td>
					    		</tr>
					    		<tr>
					    			<td>有${artiFormVO.arti_Like}個人說你的文章讚!</td>
					    		</tr>
					    	</c:forEach>
					    	</tbody>
					    </table>
					  </div>
					</div>
					<br>
					<br>
					<br>
					
					<div class="panel panel-info">
					  <div class="panel-heading">
					    <h3 class="panel-title">所發的評論區</h3>
					  </div>
					<table class="table">
	<c:forEach var="qqVO" items="${tryVO}"  varStatus="s">
      <tr>
        <td>
          <div class='rating-stars text-center' style="width:300px">
    <ul id='stars${s.index}' >
      <li class='star ' title='Poor' data-value='1' name="comment_Point" value="1">
        <i class='fa fa-star fa-fw'></i>
      </li>
      <li class='star' title='Fair' data-value='2' name="comment_Point" value="2">
        <i class='fa fa-star fa-fw'></i>
      </li>
      <li class='star' title='Good' data-value='3' name="comment_Point" value="3">
        <i class='fa fa-star fa-fw'></i>
      </li>
      <li class='star' title='Excellent' data-value='4' name="comment_Point" value="4">
        <i class='fa fa-star fa-fw'></i>
      </li>
      <li class='star' title='WOW!!!' data-value='5' name="comment_Point" value="5">
        <i class='fa fa-star fa-fw'></i>
      </li>
    </ul>
  </div> 
        </td>
</tr>
<tr>
				<td>
					<h6>被評論者</h6><p style="font-size:15px;color:mediumslateblue">${memmemSvc.getOneMem(qqVO.listener).mem_Id}</p>
					<h6>任務名</h6><p style="font-size:15px;color:mediumslateblue">${getMissionSvc.getOneMission(qqVO.mission_No).mission_Name}</p>
					<h6>評論細節</h6><p style="font-size:15px;color:mediumslateblue">${qqVO.comment_Detail}</p>
					<script>
					$(document).ready(function(){
					var s = ${qqVO.comment_Point};
						 for (i = 0; i < s; i++) {
							 $("#stars${s.index} li").eq(i).addClass("selected")
						    }
					});
					</script>
				</td>
			<tr>
	</c:forEach>


    </table>

		</div>
		
		
		</div>
		
		<div class="col-xs-12 col-sm-4">
			<div class="panel panel-info">
					  <div class="panel-heading">
					    <h3 class="panel-title">個人排名</h3>
					  </div>
					  <div class="panel-body">
					    <table class="table table-hover">
					    	<!-- <caption>我是表格標題</caption> -->
					    	<thead>
					    		<tr>
					    			<img src="<%=request.getContextPath()%>/frontdesk/personal/image/good.png">
					    		</tr>
					    		<tr>
					    			
					    			<th>單日數量排行</th>
					    			<th>單日積分排行</th>
					    		</tr>
					    	</thead>
					    	<tbody>
					    		<tr>
					    			<td>${rankVO.day_Number_Rank}</td>
					    			<td>${rankVO.day_Score_Rank}</td>
					    		</tr>
					    	</tbody>
					    </table>
					  </div>
					</div>
					
					<div class="panel panel-success">
					  <div class="panel-heading">
					    <h3 class="panel-title">被評論區</h3>
					  </div>
					<table class="table">
	<c:forEach var="qqVO2" items="${tryVO2}"  varStatus="s2">
      <tr>
        <td>
          <div class='rating-stars text-center' style="width:300px">
    <ul id='stars${s2.index}-2' >
      <li class='star ' title='Poor' data-value='1' name="comment_Point" value="1">
        <i class='fa fa-star fa-fw'></i>
      </li>
      <li class='star' title='Fair' data-value='2' name="comment_Point" value="2">
        <i class='fa fa-star fa-fw'></i>
      </li>
      <li class='star' title='Good' data-value='3' name="comment_Point" value="3">
        <i class='fa fa-star fa-fw'></i>
      </li>
      <li class='star' title='Excellent' data-value='4' name="comment_Point" value="4">
        <i class='fa fa-star fa-fw'></i>
      </li>
      <li class='star' title='WOW!!!' data-value='5' name="comment_Point" value="5">
        <i class='fa fa-star fa-fw'></i>
      </li>
    </ul>
  </div> 
        </td>
</tr>
<tr>
				<td>
					<h6>評論者</h6><p style="font-size:15px;color:deeppink">${memmemSvc.getOneMem(qqVO2.listener).mem_Id}</p>
					<h6>任務名</h6><p style="font-size:15px;color:deeppink">${getMissionSvc.getOneMission(qqVO2.mission_No).mission_Name}</p>
					<h6>評論細節</h6><p style="font-size:15px;color:deeppink">${qqVO2.comment_Detail}</p>
					<script>
					$(document).ready(function(){
					var s = ${qqVO2.comment_Point};
						 for (i = 0; i < s; i++) {
							 $("#stars${s2.index}-2 li").eq(i).addClass("selected")
						    }
					});
					</script>
				</td>
			<tr>
	</c:forEach>


    </table>
		</div>
		</div>
		
	</div>
</div>
<<<<<<< HEAD
	
	
=======


>>>>>>> branch 'master' of https://github.com/sanderxavalon/BA104G3

 <script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<<<<<<< HEAD
<script src="<%=request.getContextPath()%>/lib/js/getmission/lookStar.js"></script>
=======
<%-- <script src="<%=request.getContextPath()%>/lib/js/getmission/star.js"></script> --%>
>>>>>>> branch 'master' of https://github.com/sanderxavalon/BA104G3
	
	<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />

</body>
	<script>
		    $(function(){
		        $('[data-toggle="tooltip"]').tooltip();
		    })
		</script>
</html>

