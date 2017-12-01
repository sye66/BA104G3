<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/lib/css/style.pro.default.css" type="text/css" />
<link href="<%=request.getContextPath()%>/backdesk/sb-admin-2.css" rel="stylesheet">
<link href="<%=request.getContextPath()%>/backdesk/font-awesome.css" rel="stylesheet">


<title>工具人後端主頁面</title>
<%@page import="java.util.*"%>
<%@ page import="com.getmission.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.proorder.model.*"%>
<%@ page import="com.emp.model.*"%>
<%@ page import="com.artiReport.model.*"%>

<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<%
	GetMissionService getMissionSve = new GetMissionService();
	int missCount1 = 0;//全部任務
	int missCount0 = 0;//一般任務
	int missCount = 0;//檢舉任務
	int missCount2 = 0;//爭議任務
	

	int missA = 0;//修繕
	int missB = 0;//教育
	int missC = 0;//交友
	int missD = 0;//其他
	
	
	int priOrdCount = 0;//訂單審核
	int empCount = 0;//員工授權
	
	List<GetMissionVO> missList = getMissionSve.getAll();
	for(GetMissionVO g : missList){
		missCount1++;
		
		if(g.getMission_Category().equals("修繕")){
			missA++;
		}
		if(g.getMission_Category().equals("教育")){
			missB++;
		}
		if(g.getMission_Category().equals("交友")){
			missC++;
		}
		if(g.getMission_Category().equals("其他")){
			missD++;
		}
		
		if(g.getMission_State().equals(7)||g.getMission_State().equals(72)){
			missCount++;
		}
		if(g.getMission_State().equals(8)){
			missCount2++;
		}
	}
	
	ProOrderService proOrdSvc = new ProOrderService();
	List<ProOrderVO> proOrdList = proOrdSvc.getAll();
	for(ProOrderVO p : proOrdList){
		if(p.getOrd_Shipinfo().equals("未出貨")||p.getOrd_Shipinfo().equals("已取消")){
			priOrdCount++;
		}
	}
	
	EmpService empSvc = new EmpService();
	List<EmpVO> empList = empSvc.getAll();
	for(EmpVO e: empList){
		if(e.getEmp_State().equals("待授權")){
			empCount++;
		}
	}
	
	ArtiReportService artiReportSvc = new ArtiReportService();
	  Set<ArtiReportVO> set= artiReportSvc.getAllReport();
	  
	  //一般任務
	  missCount0=missCount1-missCount-missCount2;
	  
	    
	  
%>

</head>
<body>

	<jsp:include page="/backdesk/backdeskTop.jsp" flush="true" />
	
	
	
	
<%-- 	<jsp:include page="/backdesk/backdeskLeft.jsp" flush="true" /> --%>
	 <div class="col-xs-12 col-sm-12">
	 	<div id="page-wrapper">
            <div class="row">
                <div class="col-xs-12 col-sm-12">
                    <h2 class="page-header" >等待處理案件:</h2>
                </div>
                <!-- /.col-lg-12 -->
            </div>
	 	</div>
         </div>    <!-- /.row -->
	 
	  	<div class="col-xs-12 col-sm-10 col-sm-offset-1 ">
	 		 
<!-- 	 		 <div class="col-xs-12 col-sm-3 "> -->
<!-- 	 				<div class="panel panel-yellow" style="border-color: #f0ad4e"> -->
<!--                         <div class="panel-heading"> -->
<!--                             <div class="row"> -->
<!--                                 <div class="col-xs-12 col-sm-9"> -->
<%--                                     <img src="<%=request.getContextPath()%>/res/images/pro_icons/gg10.png"style="height:40px;"> --%>
<!--                                     <span style="font-size:20px;">會員檢舉審核:</span> -->
<!--                                 </div> -->
<!--                                 <div class="col-xs-12 col-sm-3 text-right"> -->
<!--                                     <div class="huge">26</div> -->
                                    
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                         <a href="#"> -->
<!--                             <div class="panel-footer"> -->
<!--                                 <span class="pull-left" style="font-size:16px;">查看詳情</span> -->
                                
<%--                                 <span class="pull-right"><img src="<%=request.getContextPath()%>/res/images/pro_icons/arrow_right.png"></span> --%>
<!--                                 <div class="clearfix"></div> -->
<!--                             </div> -->
<!--                         </a> -->
<!--                     </div> -->
<!-- 	 			 </div>	 -->
	 			
	 			
	 			<div class="col-xs-12 col-sm-3 col-sm-offset-1">	
	 				<div class="panel panel-yellow" style="border-color: #f0ad4e">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-12 col-sm-9">
                                   <img src="<%=request.getContextPath()%>/res/images/pro_icons/gg02.png"style="height:40px;">
                                    <span style="font-size:20px;">任務檢舉審核:</span>
                                </div>
                                <div class="col-xs-12 col-sm-3 text-right">
                                    <div class="huge"><%=missCount %></div>
                                   
                                </div>
                            </div>
                        </div>
                        <a href="<%=request.getContextPath()%>/backdesk/missionManage/missionManage.jsp">
                            <div class="panel-footer">
                                <span class="pull-left" style="font-size:16px;">查看詳情</span>
                                <span class="pull-right"><img src="<%=request.getContextPath()%>/res/images/pro_icons/arrow_right.png"></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
	 			</div>
	 		
	 		
	 			<div class="col-xs-12 col-sm-3 col-sm-offset-1">
                    <div class="panel panel-yellow" style="border-color: #f0ad4e">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-12 col-sm-9">
                                   <img src="<%=request.getContextPath()%>/res/images/pro_icons/gg03.png"style="height:40px;">
                                    <span style="font-size:20px;">討論區檢舉審核</span>
                                 </div>
                                <div class="col-xs-12 col-sm-3 text-right">
                                    <div class="huge"><%=set.size() %></div>
                                </div>
                            </div>
                        </div>
                        <a href="<%=request.getContextPath()%>/backdesk/artiReport/listAllArtiReport.jsp">
                            <div class="panel-footer">
                                <span class="pull-left" style="font-size:16px;">查看詳情</span>
                                <span class="pull-right"><img src="<%=request.getContextPath()%>/res/images/pro_icons/arrow_right.png"></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
	 		</div>
	 		
	 		
	 		
	 		
	 		
	 		
	 			<div class="col-xs-12 col-sm-3 col-sm-offset-1">	
	 				<div class="panel panel-red" style="border-color: #ff7575">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-12 col-sm-9">
                                   <img src="<%=request.getContextPath()%>/res/images/pro_icons/gg07.png"style="height:40px;">
                                    <span style="font-size:20px;">爭議案件審核:</span>
                                </div>
                                <div class="col-xs-12 col-sm-3 text-right">
                                    <div class="huge"><%=missCount2 %></div>
                                   
                                </div>
                            </div>
                        </div>
                        <a href="<%=request.getContextPath()%>/backdesk/disputecase/disputecase_Manage.jsp">
                            <div class="panel-footer">
                                <span class="pull-left" style="font-size:16px;">查看詳情</span>
                                <span class="pull-right"><img src="<%=request.getContextPath()%>/res/images/pro_icons/arrow_right.png"></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
	 			</div>
	 		
	 		
	 		
	 		
	 		
	 		<div class="col-xs-12 col-sm-3 col-sm-offset-1">
	 				<div class="panel panel-success" style="border-color: #5cb85c">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-12 col-sm-9">
                                    <img src="<%=request.getContextPath()%>/res/images/pro_icons/gg04.png"style="height:40px;">
                                    <span style="font-size:20px;">商城訂單審核:</span>
                                </div>
                                <div class="col-xs-12 col-sm-3 text-right">
                                    <div class="huge"><%=priOrdCount %></div>
                                    
                                </div>
                            </div>
                        </div>
                        <a href="<%=request.getContextPath()%>/backdesk/proOrder/listProOrder_B2.jsp">
                            <div class="panel-footer">
                                <span class="pull-left" style="font-size:16px;">查看詳情</span>
                                
                                <span class="pull-right"><img src="<%=request.getContextPath()%>/res/images/pro_icons/arrow_right.png"></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
	 			 </div>	
                
                
                
                <div class="col-xs-12 col-sm-3 col-sm-offset-1">	
	 				<div class="panel panel-success" style="border-color: #5cb85c">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-12 col-sm-9">
                                   <img src="<%=request.getContextPath()%>/res/images/pro_icons/gg01.png"style="height:40px;">
                                    <span style="font-size:20px;">新進員工授權:</span>
                                </div>
                                <div class="col-xs-12 col-sm-3 text-right">
                                    <div class="huge"><%=empCount %></div>
                                   
                                </div>
                            </div>
                        </div>
                        <a href="<%=request.getContextPath()%>/backdesk/emp/addEmpComp.jsp">
                            <div class="panel-footer">
                                <span class="pull-left" style="font-size:16px;">查看詳情</span>
                                <span class="pull-right"><img src="<%=request.getContextPath()%>/res/images/pro_icons/arrow_right.png"></span>
                                <div class="clearfix"></div>
                            </div>
                        </a>
                    </div>
	 			</div>
                
                
                
                
                
                
            </div>
	
	 		
	 <div class="col-xs-12 col-sm-12">
	 	<div id="page-wrapper">
            <div class="row">
                <div class="col-xs-12 col-sm-12">
                    <h2 class="page-header">統計圖表</h2>
                </div>
                <!-- /.col-lg-12 -->
            </div>
	 	</div>
      </div>    <!-- /.row -->
	
	
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.13.0/moment.min.js"></script>
		
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.bundle.js"></script>		
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.js"></script>		


	 		
	<div class="col-xs-12 col-sm-10 col-sm-offset-1 "> 
	
				<div class="col-xs-12 col-sm-3 col-sm-offset-1">
	 				<div class="panel panel-yellow">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-12 col-sm-9">
                                    <img src="<%=request.getContextPath()%>/res/images/pro_icons/gg21.png"
                                         style="height:40px;">
                                    <span style="font-size:20px;">任務</span>
                                </div>
                                <div class="col-xs-12 col-sm-3 text-right">
                                </div>
                            </div>
                        </div>
                            <div class="panel-footer">
                            	<div style="width: 350px; height: 300px">
  									<canvas id="canvasPie"></canvas>
		 						</div>
                            </div>
                    </div>
	 			 </div>	
	 	
	 	
	 	
				<div class="col-xs-12 col-sm-3 col-sm-offset-1">
	 				<div class="panel panel-yellow">
                        <div class="panel-heading">
                            <div class="row">
                                <div class="col-xs-12 col-sm-9">
                                    <img src="<%=request.getContextPath()%>/res/images/pro_icons/gg21.png"
                                         style="height:40px;">
                                    <span style="font-size:20px;">任務分類</span>
                                </div>
                                <div class="col-xs-12 col-sm-3 text-right">
                                </div>
                            </div>
                        </div>
                            <div class="panel-footer">
                            	<div style="width: 350px; height: 300px">
  									<canvas id="doughnut-chart" ></canvas>
		 						</div>
                            </div>
                    </div>
	 			 </div>	
	
	
	
			
<!-- 	 			<div class="col-xs-12 col-sm-3 col-sm-offset-1"> -->
<!-- 	 				<div class="panel panel-danger"> -->
<!--                         <div class="panel-heading"> -->
<!--                             <div class="row"> -->
<!--                                 <div class="col-xs-12 col-sm-9"> -->
<%--                                     <img src="<%=request.getContextPath()%>/res/images/pro_icons/gg21.png" --%>
<!--                                          style="height:40px;"> -->
<!--                                     <span style="font-size:20px;">本周新進會員數:</span> -->
<!--                                 </div> -->
<!--                                 <div class="col-xs-12 col-sm-3 text-right"> -->
<!--                                 </div> -->
<!--                             </div> -->
<!--                         </div> -->
<!--                             <div class="panel-footer"> -->
<!--                             <canvas id="myChart"></canvas> -->
<!--                                 <div class="clearfix"></div> -->
<!--                             </div> -->
<!--                    	</div> -->
<!-- 	 			 <div id="flot-placeholder" style="width:350px;height:300px"></div> -->
<!-- 	 			 </div>	 -->
	 		
	 	
	 	
	  
	
            
    </div> 
<script>
 //資料標題
            var labels= ['一般任務<%=missCount0%>','被檢舉任務<%=missCount%>','爭議任務<%=missCount2%>'];

            var ctx = document.getElementById('canvasPie').getContext('2d');
            var pieChart = new Chart(ctx, {
              type: 'pie',
              data : {
                labels:labels,
                datasets: [{
                    //預設資料
                    data:[<%=missCount0%>,<%=missCount%>,<%=missCount2%>],
                    backgroundColor: [
                    //資料顏色
                                "#00A1FF",
                                "#FFff04",
                                 "#FF0004"
                    ],
                }],
              }
            });
</script> 

<script>
new Chart(document.getElementById("doughnut-chart"), {
    type: 'doughnut',
    data: {
      labels: ["修繕<%=missA%>", "教育<%=missB%>", "交友<%=missC%>", "其他<%=missD%>"],
      datasets: [
        {
         
          backgroundColor: ["#E800E8", "#2894FF","#FFD306","#FF8040"],
          data: [<%=missA%>,<%=missB%>,<%=missC%>,<%=missD%>]
        }
      ]
    },
    options: {
      title: {
        display: true,
       
      }
    }
});
</script> 

<script>
var ctx = document.getElementById("myChart").getContext('2d');
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
        datasets: [{
            label: '新進會員',
            data: [12,5, 3, 5, 2, 3,10],
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(255, 99, 132, 0.2)',
                'rgba(255, 99, 132, 0.2)',
                'rgba(255, 99, 132, 0.2)',
                'rgba(255, 99, 132, 0.2)',
                'rgba(255, 99, 132, 0.2)',
                'rgba(255, 99, 132, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(255, 99, 132, 1)',
                'rgba(255, 99, 132,1)',
                'rgba(255, 99, 132, 1)',
                'rgba(255, 99, 132,1)',
                'rgba(255, 99, 132,1)',
                'rgba(255, 99, 132, 1)'
            ],
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            yAxes: [{
                ticks: {
                    beginAtZero:true
                }
            }]
        }
    }
});
</script>
	
</body>
</html>