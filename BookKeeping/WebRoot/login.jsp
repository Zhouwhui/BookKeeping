<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'addbook.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
     
     <link rel="stylesheet" href="layui/css/layui.css">
     <link rel="stylesheet" href="css/style.css">
     
  </head>
  <style>
	  body { 
	  
	  background-rept:no-repeat;background-size:100%;}
  
  </style>
  
  <body background="./img/1.jpg" class="">
		  <div class="page-container">
            <h1>登录</h1>
            <form action="" method="post">
                <input type="text" name="username" id="userid" class="username" placeholder="用户名">
                <input type="password" name="password" id="pwd" class="password" placeholder="密码">
                <button type="button" id="btnLogin">登录</button>
                <div class="error"><span>+</span></div>
            </form>
            <div class="connect"></div>
            <div align="center">记账助手<a href="register.jsp" target="_blank" title="">注册</a></div>
        </div>
		
	
	</body>
	<script src="js/jquery-3.3.1.js"></script>
	<script src="layui/layui.all.js"></script>
	<script type="text/javascript" src="js/md5.js"></script>
	<script type="text/javascript" src="js/systempublickey.js"></script>
	<script>
		layui.use(['form','layer','jquery'], function(){
			var form = layui.form
			var layer = layui.layer
			var $ = layui.jquery
		
			$("#btnLogin").click(function(){
				var userid = $("#userid").val();
				var pwd = $("#pwd").val();
				var enpwd = hex_md5(fix(pwd));
				$("#pwd").val(enpwd);
				if(userid.trim() == ""){
					alert("用户名不能为空")
				}else if(pwd.trim() == ""){
					alert("密码不能为空")
				}else{
					$.ajax({
						type : 'get',
						url : 'user/login',
						data:{
							userid:userid,
							pwd:enpwd
						},
						datatype : 'json',
						success : function(data) {
							if(data=="登录成功"){
								window.location.href="indexs.jsp";
							}else{
								layer.msg(data);
							}
						},
						error:function(){
							layer.msg("错误，请重试！");
			   	        }
					});
				}
			})
		})
	</script>
</html>
