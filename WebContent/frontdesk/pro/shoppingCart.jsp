<%@page import="java.util.*"%>
<%@page import="com.pro.model.*"%>
<%@page import="com.proorder.model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <html>
<head>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css">

<%
    
   
    Map<String,Integer> hashMapPro = (Map<String,Integer>)session.getAttribute("hashMapPro");
  	if(!hashMapPro.isEmpty()){
  		for (Object key : hashMapPro.keySet()) {
     	   System.out.println("Key : " + key.toString() + " Value : "
     	    + hashMapPro.get(key));
     	  }
  	}
    
%>


</head>
<body>
     
</body>
</html>