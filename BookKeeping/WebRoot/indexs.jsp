<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
        <meta name="author" content="order by dede58.com"/>
		<title>个人记账主页</title>
		<link rel="stylesheet" href="layui/css/layui.css" media="all">
	</head>
		<frameset cols="20%,80%">
		<frame src="left.jsp">
		<frameset rows="15%,85%">
		<frame src="top.jsp" frameborder="0">
		<frame src="Bookkeep.jsp" name="ms" frameborder="0">
		</frameset>		
		</frameset>
	
</html>