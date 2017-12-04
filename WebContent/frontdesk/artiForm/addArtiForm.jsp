<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.artiForm.model.*"%>
<%@ page import="com.mem.model.*"%>

<%
  ArtiFormVO artiFormVO = new ArtiFormVO();
  MemVO memVO = (MemVO) session.getAttribute("memVO");
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
            <input type="hidden" name="mem_No" size="45"
			 value="${memVO.mem_No}" />
			 請輸入主題文章標題 : <input type="text" name="arti_Title" size="45" 
			 value="<%= (artiFormVO.getArti_Title()==null)? "【問題】" : artiFormVO.getArti_Title()%>" />
            </h5>
            <div class="widget-toolbar">
                <div class="" style="width:100px;">
                    <div class="" style="">文章分類 :
                    <jsp:useBean id="artiClassSvc" scope="page" class="com.artiClass.model.ArtiClassService" />
                    <select size="1" name="arti_Cls_No">
		            <c:forEach var="artiClassVO" items="${artiClassSvc.all}" > 
		             <option value="${artiClassVO.arti_Cls_No}" ${(artiFormVO.arti_Cls_No==artiClassVO.arti_Cls_No)?'selected':'' } >${artiClassVO.arti_Cls_Name}<br>
		            </c:forEach>
		            </select>
                    </div>
                </div>
             </div>
             <div class="widget-toolbar">
                 <div class="" style="width:100px;">
                     <div class="" style="">
                     <input type="hidden" name="arti_No" size="45" 
			 value="<%= (artiFormVO.getArti_No()==null)? "AR00000066" : artiFormVO.getArti_No()%>" />
                     </div>
                 </div>
             </div>
             <div class="widget-toolbar">
                 <div class="" style="width:100px;">
                     <div class="" style="">
                     <input type="hidden" name="arti_Status" size="45"
			 value="<%= (artiFormVO.getArti_Status()==null)? "ㄧ般" : artiFormVO.getArti_Status()%>" />
                     </div>
                 </div>
             </div>
             <div class="widget-toolbar">
                 <div class="" style="width:100px;">
                     <div class="" style="">
                     <input type="hidden" name="arti_Like" size="45" 
			 value="<%= (artiFormVO.getArti_Like()==null)? 0 : artiFormVO.getArti_Like()%>" />
                     </div>
                 </div>
             </div>
         </div>
         
        
         <div class="widget-body">
             <div class="widget-toolbox">
                 <div class="btn-toolbar">
                     <div class="btn-group">
                         <div class="widget-toolbar">
                             <div class="widget-main padding-6">
                              <i class="icon-ok bigger-110"></i>
                              <h3>文章主題照片 : </h3><br>
                              <img id="theImage" src="<%=request.getContextPath()%>/image/XXX.jpg=${artiFormVO.arti_No}"
	                     style="height:150px;width:180px;"/>
		                      <input type="file" name="arti_Pic" size="45" id="theBinaryFile" onchange="onLoadBinaryFile()"
			 value="<%= (artiFormVO==null)? "PO文選的照片" : artiFormVO.getArti_Pic()%>" />
                              </div>
                          </div>
                          
                          <textarea id="editor1" name="describe" rows="10" cols="80"
		 value="<%= (artiFormVO.getDescribe()==null)? "@@? " : artiFormVO.getDescribe()%>"></textarea>
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
                <button class="btn btn-success" type="submit" name="action" value="insertArti"> 新增文章 </button>
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
    
     <jsp:include page="/lib/publicfile/include/file/footer.jsp" flush="true" />
    
</body>
</html>