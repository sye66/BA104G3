<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.rank.model.*"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	RankService rankSvc = new RankService();
	List<RankVO> list = rankSvc.getAll();
	pageContext.setAttribute("list",list);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<div class="container">
			<div class="row">
				<div class="col-xs-12 col-sm-6">
					<div class="panel panel-primary">
					  <div class="panel-heading">
					    <h3 class="panel-title">任務數量排行榜</h3>
					  </div>
					  <div class="panel-body">
					    <table class="table table-hover">
					    	<!-- <caption>我是表格標題</caption> -->
					    	<thead>
					    		<ul class="nav nav-tabs" role="tablist">
					        <li role="presentation" class="active">
					            <a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">周排行</a>
					        </li>
					        <li role="presentation">
					            <a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">月排行</a>
					        </li>
					        <li role="presentation">
					            <a href="#tab3" aria-controls="tab3" role="tab" data-toggle="tab">季排行</a>
					        </li>
					    </ul>

					    	</thead>
					    	<tbody>
					    		<tr>
					    			<div class="col-xs-12 col-sm-4">
					    			<td>	
					    				<img src="images/03.png">
					    			</td>	
					    			</div>
					    			<div class="col-xs-12 col-sm-8">
					    			<td>
					    					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Labore ad praesentium accusamus beatae deserunt, dolorem, eos temporibus dolore quod sint!
					    			</td>
					    			</div>	
					    		<tr>
					    			<div class="col-xs-12 col-sm-4">
					    			<td>	
					    				<img src="images/03.png">
					    			</td>	
					    			</div>
					    			<div class="col-xs-12 col-sm-8">
					    			<td>
					    					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Labore ad praesentium accusamus beatae deserunt, dolorem, eos temporibus dolore quod sint!
					    			</td>
					    			</div>	
					    		</tr>
					    	</tbody>
					    </table>

					  </div>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6">
					<div class="panel panel-primary">
					  <div class="panel-heading">
					    <h3 class="panel-title">積分排行榜</h3>
					  </div>
					  <table class="table table-hover">
					    	<!-- <caption>我是表格標題</caption> -->
					    	<thead>
					    		<ul class="nav nav-tabs" role="tablist">
					        <li role="presentation" class="active">
					            <a href="#tab1" aria-controls="tab1" role="tab" data-toggle="tab">周排行</a>
					        </li>
					        <li role="presentation">
					            <a href="#tab2" aria-controls="tab2" role="tab" data-toggle="tab">月排行</a>
					        </li>
					        <li role="presentation">
					            <a href="#tab3" aria-controls="tab3" role="tab" data-toggle="tab">季排行</a>
					        </li>
					    </ul>
					    	</thead>
					    	<tbody>
					    		<tr>
					    			<div class="col-xs-12 col-sm-4">
					    			<td>	
					    				<img src="images/03.png">
					    			</td>	
					    			</div>
					    			<div class="col-xs-12 col-sm-8">
					    			<td>
					    					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Labore ad praesentium accusamus beatae deserunt, dolorem, eos temporibus dolore quod sint!
					    			</td>
					    			</div>	
					    		</tr>
					    		<tr>
					    			<div class="col-xs-12 col-sm-4">
					    			<td>	
					    				<img src="images/03.png">
					    			</td>	
					    			</div>
					    			<div class="col-xs-12 col-sm-8">
					    			<td>
					    					Lorem ipsum dolor sit amet, consectetur adipisicing elit. Labore ad praesentium accusamus beatae deserunt, dolorem, eos temporibus dolore quod sint!
					    			</td>
					    			</div>	
					    		</tr>
					    	</tbody>
					    </table>

					</div>
				</div>
			</div>
		</div>

</body>
</html>