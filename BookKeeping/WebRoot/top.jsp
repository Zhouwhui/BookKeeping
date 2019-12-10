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
	
<body>
	<ul class="layui-nav" lay-filter="" style="padding-top:10px; height:92px; background-color:#778899;">
	  <li class="layui-nav-item"><a href="Bookkeep.jsp" target="ms">记账管理</a></li>
	  <li class="layui-nav-item"><a href="Sorttype.jsp" target="ms">分类类型管理</a></li>
	  <li class="layui-nav-item"><a href="Histogram.jsp" target="ms">折线统计图</a></li>
	  <li class="layui-nav-item"><a href="Piechart.jsp" target="ms">饼状图</a></li>
	  <li class="layui-nav-item" style="float:right;"><span id="logout">退出登录</span></li>
	</ul>	
		
<script src="layui/layui.js" charset="utf-8"></script>
<script>
//注意：导航 依赖 element 模块，否则无法进行功能性操作
layui.use(['element','jquery','layer'], function(){
	var element = layui.element;
	var $ = layui.jquery;
	var layer = layui.layer;
	$("#logout").click(function(){
	  	layer.confirm('确定要退出么？', {
			btn: ['确定','取消'],
			icon:3
		}, function(){
		  	$.ajax({
		  		type: 'get',
		  		url:"user/logout",
		  		datatype:"json",
		  		success:function(succ){
		  			if(succ == "成功"){
		  				window.top.location.href = "login.jsp";
		  			}else{
		  				layer.msg("请重试！");
		  			}
		  		},error:function(err){
		  			layer.msg("请重试！");
		  		}
		  	})
		});
	})
})
</script>
</body>
	
</html>