<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.rank.model.*"%>
<%@ page import="com.relation.model.*"%>
<%@ page import="com.artiForm.model.*"%>
<%@ page import="com.relation.model.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

<jsp:useBean id="RelationSvc" scope="page" class="com.relation.model.RelationService"/>
<jsp:useBean id="memmemSvc" scope="page" class="com.mem.model.MemService"/>

<% 
	MemVO memVO = (MemVO)session.getAttribute("memVO");
	String mem_No = memVO.getMem_No();
	String mem_No_main = memVO.getMem_No();
	//所有會員
	MemService memSvc = new MemService();
	List<MemVO> getAllMemVO = memSvc.getAll();
	String str = new String();
	MemVO memVO2 = new MemVO();
	for(int i = 0; i < getAllMemVO.size(); i++){
		if(memVO.getMem_No().equals(getAllMemVO.get(i).getMem_No()));
		str = getAllMemVO.get(i).getMem_No();
		memVO2 = memSvc.getOneMem(str);
		getAllMemVO.remove(memVO2);
	}
	pageContext.setAttribute("getAllMemVO", getAllMemVO);
	//顯示自己排名
	RankService rankSvc = new RankService();
	RankVO rankVO = rankSvc.getOneRank(mem_No);
	pageContext.setAttribute("rankVO",rankVO);
	//顯示自己文章
	ArtiFormService artiSvc = new ArtiFormService();
	Set<ArtiFormVO> set = (Set<ArtiFormVO>)artiSvc.findArtiByMemNo(mem_No_main);
	pageContext.setAttribute("set", set);
	//顯示好友
	RelationService relationSvc = new RelationService();
	List<RelationVO> relationVO = relationSvc.getAllRelationWithMem_No(mem_No);
	pageContext.setAttribute("relationVO", relationVO);
	
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
			<div class="panel panel-primary">
 				  <div class="panel-heading">
 				    <h3 class="panel-title">其他使用者</h3>
 				  </div>
 				  <div class="panel-body">
 				    <table class="table table-hover">
 				    	<c:forEach var="all" items="${getAllMemVO}" varStatus="om">
 				    	
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
		</div>
	</div>
</div>
	
	<jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />

</body>
	<script>
		    $(function(){
		        $('[data-toggle="tooltip"]').tooltip();
		    })
		</script>
</html>

