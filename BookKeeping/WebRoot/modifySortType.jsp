<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>添加项目</title>
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
  <link rel="stylesheet" href="layui/css/layui.css" />
</head>
<body>

    <div class="layui-form-item">
      <label class="layui-form-label">编号</label>
      <div class="layui-input-inline">
        <input type="text" readonly="readonly" style="background-color: #F5F5F5;" id="id" name="id" lay-verify="id" placeholder="" autocomplete="off" class="layui-input">
      </div>
    </div>
   
	<div class="layui-input-inline">
		<label class="layui-form-label">类型选项</label>
	    <div class="layui-input-block">
	      <select name="types" id="types" lay-verify="required">
	        <option value="0">请选择类型</option>
	        <option value="1">收入</option>
	        <option value="2">支出</option>
	      </select>
	    </div>
	</div>
			
    <div class="layui-form-item">
      <label class="layui-form-label">类型名称</label>
      <div class="layui-input-inline">
        <input type="text" id="sortname" name="sortname" lay-verify="sortname" placeholder="类型名称不能为空" autocomplete="off" class="layui-input">
      </div>
    </div>
    
    <div class="layui-form-item layui-hide">
      <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
      <input type="button" lay-submit lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit" value="确认编辑">
    </div>


 <script type="text/javascript" src="layui/layui.all.js" charset="utf-8"></script> 

<script type="text/javascript">
 layui.use(['table','jquery','form','layer'], function(){
  var table = layui.table;
  var $ = layui.jquery;
  var form=layui.form;
  var layer = layui.layer;
  
    //监听提交,添加事件
    form.on('submit(layuiadmin-app-form-submit)', function(data){
      var field = data.field; //获取提交的字段
      var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引  
			
			 var id = $("#id").val();
 			 var sortname = $("#sortname").val();
			 var types = $("#types").val();
			
			 var param = "?id=" + id + "&sortname=" +sortname + "&types=" +types;
			/* alert(param) */
			$.ajax({
				url:"sorttype/updateSortType" + param,
				type:"POST",
				data:null,
				dataType : "json",
				xhrFields :{
					withCredentials: true
				},
				contentType:'application/json;charset=UTF-8',
				success:function(e){
					//alert(e.msg)
					if(e.code == 0){
						layer.msg(e.msg,{icon:6}); 
					}else{
						layer.msg(e.msg,{icon:5});
					}
					
					setTimeout(function(){
						parent.layui.table.reload('LAY-app-content-list'); //重载表格
     					parent.layer.close(index); //再执行关闭 
						parent.layui.table.reload('sorttypeinfo'); //重载表格
					},1*1000)
				},
				error:function(e){
					layer.msg(e.msg,{icon:5});
				}
			})
      	return false;
    });
    
});
</script>
</body>
</html>