<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>后台权限管理界面</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="./layui/css/layui.css" media="all">

</head>
<body>
	<div class="backRoleSysModel-con">
			<div class="layui-row layui-col-space10">
			<form class="layui-form" action="">
			  <div class="layui-col-md11" style="padding:20px 20px;">
			    
			        <div class="layui-input-inline">
						<select name="payid" id="payid" lay-filter="payid" style="width:300px;">
						<option value="">请选择支付方式</option>
						<option value="1">现金支付</option>
						<option value="2">微信支付</option>
						<option value="3">支付宝支付</option>
						<option value="4">银行卡支付</option>
						</select>
					</div>
			        <div class="layui-input-inline">
						<select name="sortid" id="sortid" lay-filter="sortid" style="width:300px;">
						<option value="">请选择支付类型</option>
						</select>
					</div>
			      <div class="layui-input-inline">
			        <input type="text" name="datetime" id="datetime" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
			      </div>
			        <div class="layui-input-inline">
						<input type="text" name="sysmothed" id="opreation"
							placeholder="请输入备注" class="layui-input" autocomplete="off">
					</div>
					<div class="layui-inline">
						<button id="btnselbackrole" type="button"class="layui-btn layuiadmin-btn-useradmin layui-btn-radius">查询</button>
					</div>
			    
			  </div>
			  <div class="layui-col-md2" style="padding:20px 20px;">
				<div class="layui-inline">
					<div class="layui-inline">
						<button class="layui-btn layuiadmin-btn-useradmin layui-btn-radius" type="button"id="btn_income">收入</button>
					</div>
					<div class="layui-inline">
						<button class="layui-btn layuiadmin-btn-useradmin layui-btn-radius" type="button"id="btn_addmajor">支出</button>
					</div>
				</div>
			 </div>
			  </form>
			</div>
			
		

		<table class="layui-hide" id="backrolesystemmodel" lay-filter="tool"></table>
		<script type="text/html" id="barDemo"> 
				  <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>
				  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>
        	 </script>
		<script type="text/html" id="selectbar">
				<input type="checkbox" name="{{d.deepth}}" value="{{d.id}}" title="授予" lay-filter="lockDemo" {{ d.isedit == "1" ? 'checked' : '' }}>
			</script>

		<script type="text/html" id="menuTypebar">
				<span>{{ d.deepth <= "1" ? '展开菜单' : '子菜单' }}</span>
			</script>

	</div>

	<!--收入div  -->
	<div id="div_addmajor" style="display: none;text-align: center; margin-top: 1%;">
		<form class="layui-form" action="">
			<div class="layui-form-item">
				<label class="layui-form-label">金额:</label>
				<div class="layui-input-inline">
					<input type="number" style="width:250px;border-radius: 5px;"
						name="sysmothed" id="money" placeholder="输入金额"
						class="layui-input" autocomplete="off">
				</div>
				<div class="layui-inline">
			      <label class="layui-form-label">日期</label>
			      <div class="layui-input-inline">
			        <input type="text" name="date" id="date" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">备注</label>
				<div class="layui-input-block" style="width:300px;">
					<textarea name="desc" id="remark" placeholder="备注提示" class="layui-textarea"></textarea>
				</div>
				  <table class="layui-table" id="table_addrole" lay-skin="line">
					<thead>
						<tr>
							<td>支付方式</td> 
							<td>消费类型</td> 
						</tr>
					</thead>
					<tbody id="table_body">
						<tr>
							<td>
								 <div class="layui-form-item">
								    <div id="paytype" class="">
								      <input type="radio" name="pay" value="1" title="现金" checked><br>
								      <input type="radio" name="pay" value="2" title="微信"><br>
								      <input type="radio" name="pay" value="3" title="支付宝"><br>
								      <input type="radio" name="pay" value="4" title="银行卡">
								    </div>
								  </div>
							</td>
							<td>
								<div class="layui-input-block" style="margin-left:0px; ">
									<div class="layui-input-block" id="type1" style="margin-left:0px; width:400px;">
									</div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
	</div>
	
	<!--支出div  -->
	<div id="div_addmajor2" style="display: none;text-align: center; margin-top: 1%;">
		<form class="layui-form" action="">
			<div class="layui-form-item">
				<label class="layui-form-label">金额:</label>
				<div class="layui-input-inline">
					<input type="number" style="width:250px;border-radius: 5px;"
						name="sysmothed" id="money2" placeholder="输入金额"
						class="layui-input" autocomplete="off">
				</div>
				<div class="layui-inline">
			      <label class="layui-form-label">日期</label>
			      <div class="layui-input-inline">
			        <input type="text" name="date" id="date2" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">备注</label>
				<div class="layui-input-block" style="width:300px;">
					<textarea name="desc" id="remark2" placeholder="备注提示" class="layui-textarea"></textarea>
				</div>
				  <table class="layui-table" id="table_addrole" lay-skin="line">
					<thead>
						<tr>
							<td>支付方式</td> 
							<td>消费类型</td> 
						</tr>
					</thead>
					<tbody id="table_body">
						<tr>
							<td>
								 <div class="layui-form-item">
								    <div id="paytype" class="">
								      <input type="radio" name="pay2" value="1" title="现金" checked><br>
								      <input type="radio" name="pay2" value="2" title="微信"><br>
								      <input type="radio" name="pay2" value="3" title="支付宝"><br>
								      <input type="radio" name="pay2" value="4" title="银行卡">
								    </div>
								  </div>
							</td>
							<td>
								<div class="layui-input-block" style="margin-left:0px; ">
									<div class="layui-input-block" id="type2" style="margin-left:0px; width:400px;">
									</div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
	</div>
	
	<!-- 编辑记账内容 -->
	<div id="div_editmajor" style="display: none;text-align: center; margin-top: 1%;">
		<form class="layui-form" action="">
			<div class="layui-form-item">
				<label class="layui-form-label">金额:</label>
				<div class="layui-input-inline">
					<input type="number" style="width:250px;border-radius: 5px;"
						name="sysmothed" id="editmoney" placeholder="输入金额"
						class="layui-input" autocomplete="off">
				</div>
				<div class="layui-inline">
				<input type="hidden" id="type" />
				</div>
				<div class="layui-inline">
			      <label class="layui-form-label">日期</label>
			      <div class="layui-input-inline">
			        <input type="text" name="date" id="editdate" lay-verify="date" placeholder="yyyy-MM-dd" autocomplete="off" class="layui-input">
			      </div>
			    </div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">备注</label>
				<div class="layui-input-block" style="width:300px;">
					<textarea name="desc" id="editremark" placeholder="备注提示" class="layui-textarea"></textarea>
				</div>
				  <table class="layui-table" id="table_addrole" lay-skin="line">
					<thead>
						<tr>
							<td>支付方式</td> 
							<td>消费类型</td> 
						</tr>
					</thead>
					<tbody id="table_body">
						<tr>
							<td>
								 <div class="layui-form-item">
								    <div id="paytype" class="">
								      <input type="radio" name="editpay" value="1" title="现金" checked><br>
								      <input type="radio" name="editpay" value="2" title="微信"><br>
								      <input type="radio" name="editpay" value="3" title="支付宝"><br>
								      <input type="radio" name="editpay" value="4" title="银行卡">
								    </div>
								  </div>
							</td>
							<td>
								<div class="layui-input-block" style="margin-left:0px; ">
									<div class="layui-input-block" id="type3" style="margin-left:0px; width:400px;">
									</div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
	</div>
	<script src="./layui/layui.js" charset="utf-8"></script>
	<script src="./js/jquery-1.10.2.min.js"></script>
	<script src="./js/Bookkeep.js"></script>
	<script>
layui.use(['form', 'layedit', 'laydate','table'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,table = layui.table
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
  
  //日期
  laydate.render({
    elem: '#date'
  });
  laydate.render({
    elem: '#date1'
  });
  laydate.render({
    elem: '#datetime'
  });
  laydate.render({
    elem: '#date2'
  });
  table.render({
		elem: '#backrolesystemmodel',
		id:'backrolesys',
		url: 'bookkeep/bookkeepselect',
		loading: true,
		title: '角色数据表',
		skin: 'line',
		height:'full-180',
		page: true,
		curr:1,
		limit: 7,
		limits: [10, 20, 30],
		even: true,
		cols: [
			[
			{
				title: '记账类型',
				field: 'type',
				templet:function(data){
					if(data.type==0)
						return "支出"
				    else 
				    	return "收入"
				}
			},
			{
				title: '支付类型',
				field: 'photoname',
				templet:function(data){
				     return "<img src='"+data.photoname+"' style='width:30px;height:20px;'/><span>"+data.payname+"</span>"
				}
			}, 
			{
				field: 'money',
				align: 'center',
				title: '金额'						
			} ,{
				title: '分类',
				field: 'sortname',
				templet:function(data){
				     return "<img src='"+data.sortphotoname+"' style='width:30px;height:20px;'/><span>"+data.sortname+"</span>"
				}
			},
			{
				field: 'datetime',
				align: 'center',
				title: '时间'						
			} ,
			{
				field: 'remark',
				align: 'center',
				title: '备注'						
			} ,{
				field: 'isedit',
				align: 'center',
				title: '操作',
				toolbar : '#barDemo'
			}]
		]
	});
});
  </script>
</body>
</html>
