layui.use([ 'table', 'form', 'layer', 'laydate','element' ],function() {
	var table = layui.table;
	form = layui.form, layer = layui.layer,
	laydate = layui.laydate, laytpl = layui.laytpl,
	element = layui.element,layedit=layui.layedit;
	
	/*layedit.build('content', {
		height: 180 //设置编辑器高度
		, tool: ['']
	});*/
	

	/*
	 * 点击查询，更具角色筛选角色权限
	 */
	$("#btnselbackrole").click(function(){ 
		var payid = $("#payid").val();
		var sortid = $("#sortid").val();
		var datetime = $("#datetime").val();
		var remark = $("#opreation").val().trim();
		table.reload('backrolesys', {
				method : 'post',
				where : {
					payid:payid,
					sortid:sortid,
					datetime:datetime,
					remark: remark
						},
				page : {
					curr : 1
					}
			});
	});
	
	/*
	 * 表格工具栏事件
	 */ 
	table.on('tool(tool)', function(obj) {
		var data = obj.data;
		switch (obj.event) {
			//删除按钮操作
			case 'del':
				layer.confirm('确定要删除么？', {
				  btn: ['确定','取消'],
				  icon:3
				}, function(){
					$.ajax({
		        		type: 'get',
		        		url: "bookkeep/delbookeep",
		        		dataType: 'json',
		        		data:{
		        			bookkeepid:data.id
		        		},
		        		success:function(data){
		        			if(data.code == 0){
		        				layer.confirm(data.msg, {
		        					icon: 1,
									btn: ['确定']
								}, function(){
									table.reload("backrolesys", { //此处是上文提到的 初始化标识id
						                where: {
						                	
						                },page: {
						                curr:1
						                }
						            });	
									layer.closeAll();
								}); 
		        			}
		        			else{
		        				layer.confirm(data.msg, {
		        					  icon: 7,
									  btn: ['确定']
								});
		        			}
		        		},
		        		error:function(){
		        			layer.confirm('出现错误，删除失败，请重试！', {
		        				icon: 6,
								  btn: ['确定']
							});
		        		}
		        	});   
				}, function(){ 
					layer.closeAll();
				});
			break;
			case 'edit':
				geteditsorttypr(data.type);
				$("#editmoney").val(data.money);
				$("#editdate").val(data.datetime);
				//支付方式
				$("input[name=editpay][value="+data.payid+"]").prop("checked",true);
				form.render();
				//分类类型
				$("input[name=editsort][value="+data.sortid+"]").prop("checked",true);
				form.render();
				$("#editremark").val(data.remark);
				$("#type").val(data.type);
				layer.open({
					title:"账单编辑",
					type: 1,
					area: ['700px'],
					skin: 'demo-class',
					btn:['添加'],
					maxmin: true,//显示最大化最小化按钮
					content: $('#div_editmajor'),
					btn1: function(index, layero){
						var money = $("#editmoney").val().trim();
	  					var datetime = $("#editdate").val();
	  					var payid = $("input[name='editpay']:checked").val();
	  					var sortid = $("input[name='editsort']:checked").val();
	  					var remark = $("#editremark").val().trim();
	  					var type = $("#type").val().trim();
						$.ajax({
		        		type: 'get',
		        		url: "bookkeep/editbookeep",
		        		dataType: 'json',
		        		data:{
		        			bookkeepid:data.id,
		        			money:money,
		        			datetime:datetime,
		        			payid:payid,
		        			sortid:sortid,
		        			remark:remark,
		        			type:type
		        		},
		        		success:function(data){
		        			if(data.code == 0){
		        				layer.confirm(data.msg, {
		        					icon: 1,
									btn: ['确定']
								}, function(){
									table.reload("backrolesys", { //此处是上文提到的 初始化标识id
						                where: {
						                	
						                },page: {
						                curr:1
						                }
						            });	
									layer.closeAll();
								});    				 
		        			}
		        			else{
		        				layer.confirm(data.msg, {
		        					  icon: 7,
									  btn: ['确定']
								});
		        			}
		        		},
		        		error:function(){
		        			layer.confirm('出现错误 ，请重试！', {
		        				  icon: 6,
								  btn: ['确定']
							});
		        		}
		        	});  
					},
					cancel: function(){ 
					}
				});
				
			break;
		};
	});
	/* form.on('submit(formDemo)', function(data){
		layer.alert(JSON.stringify(data.field), {
  		title: '最终的提交信息'
		})
		return false;
	 });*/
 
		/*
	 * 支出获取支出类型
	 */
	$("#btn_addmajor").click(function(){
		getsorttypr2(0);
		layer.open({
			title:"支出",
			type: 0,
			area: ['700px'],
			skin: 'demo-class',
			btn:['添加'],
			maxmin: true,//显示最大化最小化按钮
			content: $('#div_addmajor2'),
			btn1: function(index, layero){
				var money = $("#money2").val().trim();
				var datetime = $("#date2").val();
				var payid = $("input[name='pay2']:checked").val();
				var sortid = $("input[name='sort2']:checked").val();
				var remark = $("#remark2").val().trim();
				if(money==undefined|| money==""){
					layer.msg('请输入金额！');
				}else if(datetime==undefined|| datetime==""){
					layer.msg('请选择时间！');
				}else if(payid==undefined|| payid==""){
					layer.msg('请选择支付方式！');
				}else if(sortid==undefined|| sortid==""){
					layer.msg('请选择收入类型！');
				}
				$.ajax({
	        		type: 'get',
	        		url: "bookkeep/addbookeep",
	        		dataType: 'json',
	        		data:{
	        			money:money,
	        			datetime:datetime,
	        			payid:payid,
	        			sortid:sortid,
	        			type:0,
	        			remark:remark
	        		},
	        		success:function(data){
	        			if(data.code == 0){
	        				layer.confirm(data.msg, {
	        				icon: 1,
							  btn: ['确定']
							}, function(){
								table.reload("backrolesys", { //此处是上文提到的 初始化标识id
					                where: {
					                	
					                },page: {
					                curr:1
					                }
					            });	
								layer.closeAll();
							});          				 
	        			}
	        			else{
	        				layer.confirm(data.msg, {
	        					  icon: 6,
								  btn: ['确定']
							});
	        			}
	        		},
	        		error:function(){
	        			layer.confirm('出现错误，请重试！', {
	        				  icon: 6,
							  btn: ['确定']
						});
	        		}
	        	});  
			},
			cancel: function(){ 
				$('#money2').val("");
				$('#remark2').val("");
				$("#date2").val("");
			}
		});
	}) 
	
	/*
	 * 收入获取收入类型
	 */
	$("#btn_income").click(function(){
		getsorttypr(1);
		layer.open({
			title:"收入",
			type: 1,
			area: ['700px'],
			skin: 'demo-class',
			btn:['添加'],
			maxmin: true,//显示最大化最小化按钮
			content: $('#div_addmajor'),
			btn1: function(index, layero){
				var money = $("#money").val().trim();
				var datetime = $("#date").val().trim();
				var payid = $("input[name='pay']:checked").val();
				var sortid = $("input[name='sort']:checked").val();
				var remark = $("#remark").val().trim();
				if(money==undefined|| money==""){
					layer.msg('请输入金额！');
				}else if(datetime==undefined|| datetime==""){
					layer.msg('请选择时间！');
				}else if(payid==undefined|| payid==""){
					layer.msg('请选择支付方式！');
				}else if(sortid==undefined|| sortid==""){
					layer.msg('请选择收入类型！');
				}
				$.ajax({
	        		type: 'get',
	        		url: "bookkeep/addbookeep",
	        		dataType: 'json',
	        		data:{
	        			money:money,
	        			datetime:datetime,
	        			payid:payid,
	        			sortid:sortid,
	        			type:1,
	        			remark:remark
	        		},
	        		success:function(data){
	        			if(data.code == 0){
	        				layer.confirm(data.msg, {
	        				icon: 1,
							  btn: ['确定']
							}, function(){
								table.reload("backrolesys", { //此处是上文提到的 初始化标识id
					                where: {
					                	
					                },page: {
					                curr:1
					                }
					            });	
								layer.closeAll();
							});          				 
	        			}
	        			else{
	        				layer.confirm(data.msg, {
	        					  icon: 6,
								  btn: ['确定']
							});
	        			}
	        		},
	        		error:function(){
	        			layer.confirm('出现错误，请重试！', {
	        				  icon: 6,
							  btn: ['确定']
						});
	        		}
	        	});  
			},
			cancel: function(){ 
				$('#money').val("");
				$('#remark').val("");
				$("#date").val("");
			}
		});
	})
	$(document).ready(function(){
		$.ajax({
		    url:'bookkeep/getallsort',
		    dataType:'json',
		    type:'post',
		    success:function(succ){
		    	var data = succ.data;
		        for(var i=0;i<data.length;i++){
		        	var append = "<option value='"+data[i].sortTypeId+"'><img src='"+data[i].photoname+"' style='width:30px;'>"+data[i].sortname+"</option>"
					$("#sortid").append(append);
		        }
		        form.render();//菜单渲染 把内容加载进去
		    },error:function(err){
		    	layer.msg(err.msg);
		    }
		})
	})
	/*
	 * 收入获取分类类型
	 */
	function getsorttypr(type){
		$.ajax({
    		type: 'get',
    		url: "bookkeep/getsort",
    		data:{
    			type:type
    		},
    		dataType: 'json',
    		success:function(succ){
    			if(succ.code == 0){
    				$("#type1").empty();
    				var data = succ.data;
    				for(var i=0;i<data.length;i++){
    					var append = "<input type='radio' name='sort' value='"+data[i].sortTypeId+"' title='"+data[i].sortname+"'>"+"<img src='"+data[i].photoname+"' style='width:30px;'>"
    					$("#type1").append(append);
    				}
    				form.render();
    			}
    			else{
    				layer.confirm(succ.msg, {
      				  icon: 6,
					  btn: ['确定']
    				});
    			}
    		},
    		error:function(){
    			layer.confirm('出现错误，请重试！', {
				  icon: 6,
				  btn: ['确定']
				});
    		}
    	});
	}
	/*
	 * 支出获取分类类型
	 */
	function getsorttypr2(type){
		$.ajax({
    		type: 'get',
    		url: "bookkeep/getsort",
    		data:{
    			type:type
    		},
    		dataType: 'json',
    		success:function(succ){
    			if(succ.code == 0){
    				$("#type2").empty();
    				var data = succ.data;
    				for(var i=0;i<data.length;i++){
    					var append = "<input type='radio' name='sort2' value='"+data[i].sortTypeId+"' title='"+data[i].sortname+"'>"+"<img src='"+data[i].photoname+"' style='width:30px;'>"
    					$("#type2").append(append);
    				}
    				form.render();
    			}
    			else{
    				layer.confirm(succ.msg, {
      				  icon: 6,
					  btn: ['确定']
    				});
    			}
    		},
    		error:function(){
    			layer.confirm('出现错误，请重试！', {
				  icon: 6,
				  btn: ['确定']
				});
    		}
    	});
	}
	/*
	 * 编辑获取分类类型
	 */
	function geteditsorttypr(type){
		$.ajax({
    		type: 'get',
    		url: "bookkeep/getsort",
    		data:{
    			type:type
    		},
    		dataType: 'json',
    		success:function(succ){
    			if(succ.code == 0){
    				$("#type3").empty();
    				var data = succ.data;
    				for(var i=0;i<data.length;i++){
    					var append = "<input type='radio' name='editsort' value='"+data[i].sortTypeId+"' title='"+data[i].sortname+"'>"+"<img src='"+data[i].photoname+"' style='width:30px;'>"
    					$("#type3").append(append);
    				}
    				form.render();
    			}
    			else{
    				layer.confirm(succ.msg, {
      				  icon: 6,
					  btn: ['确定']
    				});
    			}
    		},
    		error:function(){
    			layer.confirm('出现错误，请重试！', {
				  icon: 6,
				  btn: ['确定']
				});
    		}
    	});
	}
});
