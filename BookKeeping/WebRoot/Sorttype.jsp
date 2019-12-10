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
		<title>用户查看</title>
		<link rel="stylesheet" href="layui/css/layui.css" media="all">
	</head>
	<style>
  
  </style>
	<body>
	
	  	<div class="layui-card">
		  <div class="layui-card-body">	
			<form class="layui-form" action="">	
				<div class="layui-input-inline">
					<label class="layui-form-label">类型选项</label>
				    <div class="layui-input-block">
				      <select name="sorttype" id="types" lay-verify="required">
				        <option value="0">请选择类型</option>
				        <option value="1">收入</option>
				        <option value="2">支出</option>
				      </select>
				    </div>
				</div>		
				<div class="layui-input-inline">
					<input type="text" name="sortname" id="sortname" placeholder="请输入内容" class="layui-input" autocomplete="off">
				</div>
				<div class="layui-inline">
					<button id="btnselbackrole" type="button"class="layui-btn layuiadmin-btn-useradmin">添加</button>
				</div>
			</form>
		  <div>
			<!-- 表格开始 -->
			<table class="layui-hide" name="sorttypeinfo" id="sorttypeinfo" lay-filter="sorttypeinfo"></table>
			<!-- 表格结束 -->
		
			<script type="text/html" id="barDemo">
				<a class="layui-btn layui-btn-xs" id="edit" lay-event="edit">编辑</a>
				<a class="layui-btn layui-btn-danger  layui-btn-xs" lay-event="delete">删除</a>
			</script>
				
		  	</div>
		  </div>
		</div>
	
	
	<script src="layui/layui.js" charset="utf-8"></script>
	<script src="js/jquery-3.3.1.js" charset="utf-8"></script>
	 <script>
	layui.use([ 'table', 'form', 'layer', 'laydate', 'laytpl', 'element' ], function() {
		var table = layui.table, form = layui.form, 
			layer = layui.layer, $ = layui.jquery,
			laydate = layui.laydate, laytpl = layui.laytpl,
			element = layui.element;
		
		//页面加载时加载表格	
		querylist();
		
		function querylist(){
			/*加载表格*/
			table.render({
				elem : '#sorttypeinfo',
				id:'sorttypeinfo',
				url : 'sorttype/getAllSortType',
				loading : true,
				title : '数据表',
				height: "full-160",
				skin : 'line',
				even : true,
				cols : [ 
				     [ {field:'id', title:'编号', width:230}
				      ,{field:'sortname', title:'类型名称'}
				      ,{field:'types', title:'类型名称',
				      templet:function(data){
				      if(data.types==0){
				      	data.types="支出";
				      	return data.types
				      }else if(data.types==1){
				      	data.types="收入";
				      	return data.types
				      }
					}
				      }
				      ,{title : '操作',toolbar : '#barDemo',align : 'right'} 
				     ] 
				 ],
				 page: {
						layout: ['prev', 'page', 'next', 'skip', 'count', 'limit'],
						groups: 5,
						limit: 10,
						limits: [10, 20, 30, 40, 50],
						theme: '#1E9FFF',						
				 },
			});
		}
		
		/*
		 *添加操作
		*/
		$("#btnselbackrole").click(function(){
 			var sortname = $("#sortname").val();
			var types = $("#types").val();
			if(sortname=="" && sortname==null){
					layer.alert('类型名称不能为空!', {icon: 2});
					return;
				}
			var obj = {
						"sortname":sortname,
						"types":types,
						};
			$.ajax({
			type : 'get',
			url : 'sorttype/addsorttype',
			data:{
				types:types,
				sortname:sortname,
			},
			datatype : 'json',
			success : function(data) {
			/* alert("ok"); */
				if(e.code == 0){
					layer.msg(e.msg,{icon:6}); 
				}else{
					layer.msg(e.msg,{icon:5});
				}
				
				setTimeout(function(){
						parent.layui.table.reload('LAY-app-content-list'); //重载表格
     					parent.layer.close(index); //再执行关闭 
						parent.layui.table.reload('sorttypeinfo'); //重载表格
						querylist();
				},1*1000)
			},
			error:function(){
				layer.msg(e.msg,{icon:5});
   	        }
		});
		return false;
});
		
		//监听工具条
		table.on('tool(sorttypeinfo)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
		  var data = obj.data; //获得当前行数据
		  var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）
		  var tr = obj.tr; //获得当前行 tr 的DOM对象
		 
			if(layEvent === 'delete'){ //删除
			     layer.confirm('真的删除行吗？', function(index){
				     
				      //向服务端发送删除指令
				      	$.post("sorttype/deleteSortType",{id:obj.data.id},function(flag){
			    			if(flag){
			    				layer.msg("刪除成功",{icon:6}); //表格刷新
						        table.reload('sorttypeinfo'); //重载表格
			    			}else{
			    				layer.msg("刪除失敗",{icon:5});
			    			}
				    	})
				  });
			  } else if(layEvent === 'edit'){ //编辑
			    //do something
			       //脚本编辑弹出层
		           var name = encodeURIComponent(data.toolName);
		           //alert(name);
		           layer.open({
		              type: 2,
		              title: '修改分类信息',
		              shadeClose: true,
		              shade: 0.5,
		              closeBtn:'1',//右上角xx关闭
		              area: ['500px','350px'],
		              content:'modifySortType.jsp',
		              btn: ['确定', '取消'],
		              yes: function(index, layero){
		              
			            //点击确认触发 iframe 内容中的按钮提交
			            var submit = layero.find('iframe').contents().find("#layuiadmin-app-form-submit");
			            submit.click();
			        },
		              success : function(layero, index){
			            var body = layui.layer.getChildFrame('body', index);
			            if(layEvent === 'edit'){
			                // 取到弹出层里的元素，并把编辑的内容放进去
			                body.find("#id").val(obj.data.id);  //将选中的数据的id传到编辑页面的隐藏域，便于根据ID修改数据
			                body.find("#sortname").val(obj.data.sortname);  
			            }
			            setTimeout(function(){
										parent.layui.table.reload('LAY-app-content-list'); //重载表格
				     					parent.layer.close(index); //再执行关闭 
										parent.layui.table.reload('sorttypeinfo'); //重载表格
						},1*1000)
			        }
	         	});
		    	//同步更新缓存对应的值
		    obj.update({
		      
		    });
		  }
		});
		
});
	
	</script>
	</body>
</html>