<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <title>饼形数据统计图</title>
     <link rel="stylesheet" href="layui/css/layui.css">
    <script src="js/1-6-10.esl.js"></script>
</head>

<body>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <form class="layui-form">
		<div class="layui-inline" style="margin-left:20px;">
			<span>查询时间：</span>
			<select name="year" lay-verify="" id="year" lay-filter="year" style="width:300px;">
			<option value="">请选择查询月份</option>
			<option value="1">1月</option>
			<option value="2">2月</option>
			<option value="3">3月</option>
			<option value="4">4月</option>
			<option value="5">5月</option>
			<option value="6">6月</option>
			<option value="7">7月</option>
			<option value="8">8月</option>
			<option value="9">9月</option>
			<option value="10">10月</option>
			<option value="11">11月</option>
			<option value="12">12月</option>
			</select>
		</div>
		<div class="layui-inline">
    		<div id="main" style="height:400px; width:1000px;margin:0 auto;"></div>
		</div>
		<div class="layui-inline">
	    	<table id="table" class="layui-table" style="width:500px;margin:0 auto;" lay-skin="line">
		    	<tr>
			    	<th>类型</th>
			    	<th>金额</th>
	    		</tr>
	    	</table>
		</div>
    </form>
<script src="js/jquery-3.3.1.js"></script>
<script src="layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
function getxAxis(year,month){
	$.ajax({
		type : "post",
		url : "statistics/month",
		data : {
			year:year,
			month:month
		},
		dataType : "json",
		success : function(succ) {
			var title = month+"月账单";
			if(succ.code == 0){
				var tdArr = document.getElementById('table').firstElementChild;
				var totalmoney = 0;
		        for (var i = 0; i < succ.data.length; i++) {
		        	totalmoney+=succ.data[i].value;
		            var tr = document.createElement("tr");
		            var name = succ.data[i].name.split(" ");
		            tr.innerHTML = '<td>' + name[0] + '</td><td>￥'+succ.data[i].value+'</td>';
		            tdArr.appendChild(tr)
		        }
		        tr.innerHTML = "<td>合计</td><td>￥"+totalmoney+"</td>";
		            tdArr.appendChild(tr)
				var legendlist = new Array();
				for(var i=0;i<succ.data.length;i++){
					var name2 = succ.data[i].name;
					legendlist.push(name2);
				}
		        // 路径配置
		        require.config({
		            paths: {
		                'echarts': 'js/echarts',
		                'echarts/chart/pie': 'js/echarts'
		            }
		        });
				require(
		            [
		                'echarts',
		                'echarts/chart/pie' // 使用柱状图就加载bar模块，按需加载
		            ],
		            function(ec) {
	    				myChart = ec.init(document.getElementById('main'));
		                // 基于准备好的dom，初始化echarts图表
		                option = {
		                    title: {
		                        text: title,
		                        x: 'center'
		                    },
		                    tooltip: {
		                        trigger: 'item',
		                        formatter: "{a} <br/>{b} : {c} ({d}%)"
		                    },
		                    legend: {
		                        orient: 'vertical',
		                        x: 'left',
		                        data: legendlist
		                    },
		                    toolbox: {
		                        show: true,
		                        feature: {
		                            mark: {
		                                show: true
		                            },
		                            dataView: {
		                                show: true,
		                                readOnly: false
		                            },
		                            restore: {
		                                show: true
		                            },
		                            saveAsImage: {
		                                show: true
		                            }
		                        }
		                    },
		                    calculable: true,
		                    series: [{
		                        name: '访问来源',
		                        type: 'pie',
		                        radius: '55%',
		                        center: ['50%', '60%'],
		                        data: succ.data
		                    }]
		                };
		                myChart.setOption(option);
		            }
		        );
		    }else{
		    	layer.msg(succ.msg,{icon : 5});
		    }
		},
		error : function() {
			layer.msg('请求失败，稍后再试',{icon : 5});
		}
	})
}
layui.use(['form'], function(){
	var form = layui.form;
	//年分下拉框改变事件
	form.on('select(year)', function(data){
		var myDate= new Date(); 
	    var year=myDate.getFullYear();//当前年份 
		//调用折线图方法
	    getxAxis(year,data.value);
	})
    $(document).ready(function(){
    	var myDate= new Date(); 
	    var year=myDate.getFullYear();//当前年份 
	    var month=myDate.getMonth()+1;//当前月份 
        //调用饼图方法
        getxAxis(year,month)
	});
	
});
</script>

</body>                
                    
            