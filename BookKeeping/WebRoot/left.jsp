<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
       <meta name="author" content="order by dede58.com"/>
	<title>个人记账主页</title>
	<link rel="stylesheet" href="layui/css/layui.css" media="all">
</head>
<style>
     .div0{background-color:#f2f2f2;height:100%;}
  .font1{height:40px;background-color:#393D49;padding-top:18px;}
  .font3{font-size:10px;color:#c2c2c2;  }
 
   #divcss5{ margin:10px auto} 
   #divcss5 img{ border-radius:50%}
   
   /*日历部分*/
   
   </style>
<body style="background-color:#778899">
	<div class="layui-col-md12 layui-col-lg12">
		<div class="layui-card" style="background-color:#778899;text-align:center;">
		  <div class="layui-card-body" style="height:580px;">
		  	<div class="" id="divcss5"><img src="img/sg.jpg"/></div>
		  	<h1>欢迎!</h1>
		  	<h1 style="margin-top:20px;"><b>${loginuser.username }</b></h1>
		  	<div style="margin-top:50px;font-size:20px;">
			  	总金额：
			  	<input type="password" readOnly="readonly" style="width:100px;border-style:none none none none;background-color:transparent;" value="${loginuser.totalmoney }" id="pwd"/>
				<img id="btnEye" alt="" src="img/eye.png" width="30px;" height="26px;" />
		  	</div>
		  	<div style="margin-top:40px;">
		  		<h2><span id="date"></span></h2>
		  		<h2 style="margin-top:20px;"><span id="time"></span></h2>
		  	</div>
		  <!-- 日历开始 -->	
		  	<span id="testView"></span>
	        <div id="test5"></div>
		  <!-- 日历结尾 -->	
		  </div>
		</div>
	</div>
</body>
<script src="js/jquery-3.3.1.js"></script>
<script src="layui/layui.all.js"></script>
<script type="text/javascript">
	//鼠标按下时触发的事件
	$("#btnEye").click(function(){
		//改变输入框内容
		if($("#pwd").attr("type") == "text"){
			$("#pwd").attr("type","password");
		}else{
			$("#pwd").attr("type","text"); 
		}
	})
	//页面加载调用
	$(document).ready(function(){
		//每1秒刷新时间
    	setInterval("NowTime()",1000);
	})
    function NowTime(){
        //获取年月日
        var time=new Date();
        var year=time.getFullYear();
        var month=time.getMonth()+1;
        var day=time.getDate();
        
        //获取时分秒
        var h=time.getHours();
        var m=time.getMinutes();
        var s=time.getSeconds();
        
        //检查是否小于10
        h=check(h);
        m=check(m);
        s=check(s);
        $("#date").text(year+"年"+month+"月"+day+"日  ");
        $("#time").text(h+":"+m+":"+s);
        //document.getElementById("nowtime").innerHTML="当前时间："+year+"年"+month+"月"+day+"日  "+h+":"+m+":"+s;
    }
    //时间数字小于10，则在之前加个“0”补位。
    function check(i){
        //方法一，用三元运算符
        var num;
        i<10?num="0"+i:num=i;
        return num;
        
        //方法二，if语句判断
        //if(i<10){
        //    i="0"+i;
        //}
        //return i;
    }
</script>
</html>
