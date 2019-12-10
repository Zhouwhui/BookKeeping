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
	
     
     <link rel="stylesheet" href="css/style.css">
     
  </head>
  <style>
	  body { 
	  
	  background-rept:no-repeat;background-size:100%;}
  
  </style>
  
  <body background="./img/3.jpg" class="">
		  <div class="page-container">
            <h1>注册</h1>
            <form action="" method="post">
            	<input type="text" name="userid" class="userid" placeholder="账号" id="userid">
                <input type="text" name="username" class="username" placeholder="用户名" id="username">
                <input type="password" name="pwd" class="pwd" placeholder="密码" id="pwd">
                <input type="password" name="pwdconfirm" class="pwdconfirm" placeholder="确认密码" id="pwdconfirm">
                <button type="button" id="add_user">注册</button>
                <div class="error"><span>+</span></div>
            </form>
            <div class="connect"></div>
            <div align="center">记账助手<a href="login.jsp" target="_blank" title="">登录</a></div>
        </div>
	</body>
	<script src="js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="layui/layui.js"></script>
	<script type="text/javascript" src="js/md5.js"></script>
	<script type="text/javascript" src="js/systempublickey.js"></script>
	<script>
layui.use([ 'layer' ],function() {
	var layer = layui.layer
	$("#add_user").click(function(){
		var userid = $("#userid").val();
		var username = $("#username").val();
		var pwd = $("#pwd").val();
		var pwdconfirm = $("#pwdconfirm").val();
		var enpwd = hex_md5(fix(pwd));
		var repass = hex_md5(fix(pwdconfirm));
		$("#pwd").val(enpwd);
		$("#pwdconfirm").val(repass);
		//alert(enpwd);
		if(repass != enpwd){
			alert("密码不一致!");
		}
		if(userid.trim()==""){
			alert("账号不能为空！");
		}else if(username.trim() == ""){
			alert("用户名不能为空")
		}else if(pwd.trim() == ""){
			alert("密码不能为空")
		}else{
			$.ajax({
				type : 'get',
				url : 'user/register',
				data:{
					userid:userid,
					username:username,
					pwd:enpwd
				},
				datatype : 'json',
				success : function(data) {
				//alert("注册成功");
					if(data="添加成功"){
						window.location.href="login.jsp";
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
