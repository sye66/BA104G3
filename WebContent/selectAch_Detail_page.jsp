<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ach_detail/ach_detail.do" >
        <b>輸入員工編號 (如M000001):</b>
        <input type="text" name="mem_No">
        <input type="submit" value="送出">
        <input type="hidden" name="action" value="getOne_For_Display">
    </FORM>
    
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/ach_detail/ach_detail.do" >
    	<input type="submit" name="getAchieve" value="取得成就">
        <input type="hidden" name="action" value="getAchieve">
    </FORM>
</body>
</html>