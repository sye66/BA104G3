<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.artiForm.model.*"%>

<%
  ArtiFormVO artiFormVO = (ArtiFormVO) request.getAttribute("artiFormVO");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--
 * CKFinder
 * ========
 * http://cksource.com/ckfinder
 * Copyright (C) 2007-2015, CKSource - Frederico Knabben. All rights reserved.
 *
 * The software, this file and its contents are subject to the CKFinder
 * License. Please read the license.txt file before using, installing, copying,
 * modifying or distribute this file or part of its contents. The contents of
 * this file is part of the Source Code of CKFinder.
-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<jsp:include page="/lib/publicfile/include/file/navbar.jsp" flush="true" />

<jsp:include page="/frontdesk/ad/listOneAd.jsp" flush="true" />

	<title>CKFinder - Sample - CKEditor Integration</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="robots" content="noindex, nofollow" />
	<link href="ckfinder.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="../ckfinder.js"></script>
	
	<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/booystrap.min.css" />
	<link rel="stylesheet" href="/BA104G3/lib/css/arti_ref/post.min.css" />
</head>

<body>

<div class="container">
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" name="form1" enctype="multipart/form-data">

<div class="col-xs-12 col-sm-12 widget-container-span">
    <div class="widget-box">
        <div class="widget-header header-color-dark">
            <h5 class="bigger lighter">
            <h1>工具人 -- 會員神靠北秘密基地 </h1>
            </h5>
            
            <div class="widget-toolbar">
               <div class="" style="width:100px;">

                 </div>
             </div>
             
             <div class="widget-toolbar">
                 <div class="" style="width:100px;">
                     <div class="" style="">
                     <input type="hidden" name="arti_No" size="45" 
			 value="<%= (artiFormVO==null)? "AR00000001" : artiFormVO.getArti_No()%>" />
                     </div>
                 </div>
             </div>
             <div class="widget-toolbar">
                 <div class="" style="width:100px;">
                     <div class="" style="">
                     <input type="hidden" name="arti_Status" size="45"
			 value="<%= (artiFormVO==null)? "ㄧ般" : artiFormVO.getArti_Status()%>" />
                     </div>
                 </div>
             </div>
             <div class="widget-toolbar">
                 <div class="" style="width:100px;">
                     <div class="" style="">
                     <input type="hidden" name="arti_Like" size="45" 
			 value="<%= (artiFormVO==null)? 0 : artiFormVO.getArti_Like()%>" />
                     </div>
                 </div>
             </div>
         </div>

         <div class="widget-body">
         
          <input type="hidden" name="mem_No" size="45"
			 value="<%= (artiFormVO==null)? "M000001" : artiFormVO.getMem_No()%>" />
			 <h3>請輸入主題文章標題 : </h3> <input type="text" id="title" name="arti_Title" size="80" 
			 value="<%= (artiFormVO==null)? "【問題】" : artiFormVO.getArti_Title()%>" /><br>
			 
             <div class="widget-toolbox">
                 <div class="btn-toolbar">        
                     <div class="btn-group">
                     
                         <div class="widget-toolbar">
                             <div class="widget-main padding-6">
                              <i class="icon-ok bigger-110"></i>
                              
                    <div class="" style=""><h3>文章分類 : </h3>
                   <jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService" />
                   <select size="1" name="arti_Cls_No">
		           <c:forEach var="artiClassVO" items="${artiClassSvc.all}" > 
		           <option value="${artiClassVO.arti_Cls_No}" ${(artiFormVO.arti_Cls_No==artiClassVO.arti_Cls_No)?'selected':'' } >${artiClassVO.arti_Cls_Name}<br>
		           </c:forEach>
		           </select>
                   </div><br><br>
                   
                              <h3>文章主題照片 : </h3><br>
                              <img id="theImage" src="<%=request.getContextPath()%>/image/XXX.jpg=${artiFormVO.arti_No}"
	                     style="height:150px;width:180px;"/>
		                      <input type="file" name="arti_Pic" size="45" id="theBinaryFile" onchange="onLoadBinaryFile()"
			 value="<%= (artiFormVO==null)? "PO文選的照片" : artiFormVO.getArti_Pic()%>" />
                              </div>
                          </div>
                          
                          <input id="editor1" name="describe" rows="10" cols="80"
		 value="<%= (artiFormVO==null)? "@@? " : artiFormVO.getDescribe()%>"></input>
                           </div>
                       </div>
                  </div>                    
         </div>
		 
         <div class="widget-header header-color-dark">
         <h5 class="bigger lighter"><input type="hidden" name="arti_Time" id="f_date1" /></h5>
             <div class="widget-toolbar">
                 <div class="btn-group">

                 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/artiForm/artiForm.do" >
		        <input type="hidden" name="describe"  value="${artiFormVO.describe}">	        
                <button class="btn btn-info" type="submit" name="action" value="insertArti"> 新增文章 </button>
                </FORM>

                  </div>
              </div>

              <div class="widget-toolbar">
                 <div class="btn-group">
                 <button class="btn btn-sm btn-warning">
                  <a href="/BA104G3/frontdesk/artiForm/listAllArtiForm.jsp"> 取消 </a> 
                  </button>
                  </div>
              </div>
              
 <!--              <div class="widget-toolbar">
					<div class="col-xs-12 col-sm-8">
						<button class="btn btn-warning" type="button" onclick="ArtiSample()">Magic</button>
					</div>	
              </div>
 -->               
           </div>
       </div>
   </div>
</FORM>
</div>
	<script src="//cdn.ckeditor.com/4.5.6/standard-all/ckeditor.js"></script>
	<script>
		// Note: in this sample we use CKEditor with two extra plugins:
		// - uploadimage to support pasting and dragging images,
		// - image2 (instead of image) to provide images with captions.
		// Additionally, the CSS style for the editing area has been slightly modified to provide responsive images during editing.
		// All these modifications are not required by CKFinder, they just provide better user experience.
		if ( typeof CKEDITOR !== 'undefined' ) {
			CKEDITOR.addCss( 'img {max-width:100%; height: auto;}' );
			var editor = CKEDITOR.replace( 'editor1', {
				extraPlugins: 'uploadimage,image2',
				removePlugins: 'image',
				height:350
			} );

			// Just call CKFinder.setupCKEditor and pass the CKEditor instance as the first argument.
			// The second parameter (optional), is the path for the CKFinder installation (default = "/ckfinder/").
			CKFinder.setupCKEditor( editor, '../' ) ;

			// It is also possible to pass an object with selected CKFinder properties as a second argument.
			// CKFinder.setupCKEditor( editor, { basePath : '../', skin : 'v1' } ) ;
		} else {
			document.getElementById( 'description' ).innerHTML = '<div class="tip-a tip-a-alert">This sample requires working Internet connection to load CKEditor from CDN.</div>'
		}
	</script>
	
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
    		<!--神奇方法 -->
			<script type="text/javascript">
				function ArtiSample(){
				var v = document.getElementById("editor1");			
					v.value="旺宏已經連續虧損16季..年年狼來了喊轉盈年年虧榮登轉機股王...<br>散戶期盼什麼時候才會從很久忘了怎麼紅變成又旺又紅??<br>旺宏很恰巧的很剛好的在去年Q3延長設備及廠房折舊年限.<br>今年折舊費用大減近38億..以目前的月營收緩增.....<br>6月營收近17億單月已經接近損平甚至轉盈<br><br>預計Q2虧損會再大幅減少，庫存回到健康的低水位,7/28法說會就會公布Q2虧損情況..<br>但旺宏早在2015年Q3就喊2016年Q3轉盈.卻為什麼放任自家股票在今年Q1財報出來後淨值低於5元打入全額交割??<br><br>據任何可知的新聞又跟往年一樣..對於今年可以全年損平或轉盈深具信心更強調就算打進全交也很快就能脫離全額交割....<br>要知道證交所脫離全交的規定是淨值要回到五元連續兩季財報盈餘為正值..<br>除了折舊年限變更..每季費用折舊少近十億之外..其實我個人都認為一年費用少四十億2015年虧損38億....<br>今年還能全年虧損,旺宏可以去死一死了.....<br>打進西門子成為西門子nor flash主要供應商,Q3開始出貨對營收也不無小補......<br>任天堂2017三月推新機代號NX,據傳旺宏去年就已經設了一條產線專門供應任天堂新機,<br>產能之大看來很有可能NX棄用光碟遊戲媒介改採卡匝..因為順盈投資剛好在今年初在旺宏打進全交時增持數万張持股..順盈投資何許人也??資料如下<br><br>順盈投資有限公司代表人：松岡茂樹 / MegaChips Corporation董事兼執行副總裁,MegaChips MegaChips(6875.JP)株式會社創立於1990年，總部設在大阪，是日本知名晶片設計公司且為半導體通路商，提供LSI產品的系統晶片設計，主要生產數位電視、遊戲機、數位相機、視聽設備與數位廣播電視系統等數位影像處理解決方案晶片，是日本任天堂最主要晶片供應商。<br><br>再者供給任天堂光碟機的松下並沒有任何消息傳來成為任天堂NX光碟機供應商,任天堂NX採用卡匝的可能性很高,第三季遊戲展NX外觀規格就會公布..如任天堂採用卡匝旺宏簡直吞下大補丸......<br>精靈寶可夢這個起手式已經創造話題.,主機明年3月推出......<br>如果跟手機遊戲跟掌機可以產生連動大概Q4就會顯著貢獻在營收跟產生話題性......<br>不敢說NX會不會複製WII的經驗…但要知道首發遊戲瑪莉歐跟神奇寶貝銷量都用百万套去計算的如果任天堂真的改用卡匝的話.......<br><br>旺宏簡直爽歪了。<br><br>現在的晶片設計都越做越小..沒必要被光碟機占用大量體積.....<br>卡匝的好處是讀取快不佔用空間,而且任天堂遊戲設計本來就不是靠大容量取勝.....<br>看來任天堂是打算捨棄第三方供應商靠自己開發遊戲了..營收估計快速跳增20億以上輕輕鬆鬆小菜一碟..如果折舊大減、成為西門子主要供應商、庫存降到低水平、任天堂採用卡匝、以上利多一一灌進來的話..各位在布局旺宏的朋友.....<br>對不起.我破梗了..先觀察28號的法說會數據開出來漂不漂亮吧......<br>";
				var a=document.getElementById("title");  
					a.value="【閒聊】旺宏-時來運轉??";	
				}
			</script>
		<!--神奇方法 -->
    
     <jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />
    
</body>
</html>