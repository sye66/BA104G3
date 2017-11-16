<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
		<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/personal/personal.do" >
        <b>輸入成就編號 (如E000001):</b>
		<input type="text" name="mem_No">
        <input type="submit" value="送出">
        <input type="hidden" name="action" value="onlyGetPic">
        </FORM>
</body>
</html>