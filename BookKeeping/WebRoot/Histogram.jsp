<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<style>
body {
    background-color: white;
    overflow: hidden;
      overflow-y: scroll;
    
}
body::-webkit-scrollbar {
        display: none;
    }
    
</style>
</head>
     <link rel="stylesheet" href="layui/css/layui.css">
<body>
	<div class="layui-container">
		<form class="layui-form">
		<div class="layui-inline">
			查询时间：<select name="year" id="year" lay-filter="year" style="width:300px;">
			</select>
		</div>
		<div id="main" style="width:750px;height:450px;margin:0 auto"></div>
		</form>
	</div>
</body>
<script src="js/echarts.common.min.js"></script>
<script src="js/jquery-3.3.1.js"></script>
<script src="layui/layui.js" charset="utf-8"></script>
<script>
layui.use(['element','layer', 'carousel', 'table','jquery','form'], function(){
	var element = layui.element;
	var carousel = layui.carousel;
	var table = layui.table;
	var $ = layui.jquery;
	var layer = layui.layer;
	var form = layui.form;
	//获取折线图对象
	var myChart = echarts.init(document.getElementById('main'));
	//年分下拉框改变事件
	form.on('select(year)', function(data){
		//初始化折线图
	    initChart();
		//调用折线图方法
	    getxAxis(data.value);
	    //$("#main").load(form.render('select'));
	})
	
	//初始化折线图
	function initChart(){
		option = {
		    title: {
		        text: '支出/收入对比图'
		    },
		    tooltip : {
		        trigger: 'axis',
		        axisPointer: {
		            type: 'cross',
		            label: {
		                backgroundColor: '#6a7985'
		            }
		        }
		    },
		    legend: {/* 分组类型 */
		        data:['支出','收入']
		    },
		    toolbox: {
		        feature: {
		            saveAsImage: {}
		        }
		    },
		    grid: {
		        left: '3%',
		        right: '4%',
		        bottom: '3%',
		        containLabel: true
		    },
		    xAxis : [
		        {
	            	position: 'bottom',
		            type : 'category',
		            boundaryGap : false,
		            id:[],
		            data : ["1月","2月","3月","4月","5月","6月","7月","8月","9月","10月","11月","12月"]
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value'
		        }
		    ],
		    series : [
		        {
		            name:'支出',
		            type:'line',
		            stack: '总量',
		            areaStyle: {normal: {}},
		            data:[0,0,0,0,0,0,0,0,0,0,0,0]
		        },
		        {
		            name:'收入',
		            type:'line',
		            stack: '总量',
		            areaStyle: {normal: {}},
		            data:[0,0,0,0,0,0,0,0,0,0,0,0]
		        }
		    ]
		};
		myChart.setOption(option);
	}
	
	//获取折线图数据并改变折线图
	function getxAxis(year){
		$.ajax({
			type : "post",
			url : "statistics/year",
			data : {
				year:year
			},
			dataType : "json",
			success : function(succ) {
				if (succ.code == 1) {
					layer.msg(succ.msg,{icon : 5});
				} else {
					var optionjson = option;
					var out = optionjson.series[0].data;
					var input = optionjson.series[1].data;
					for(var i=1;i<=12;i++){
						for(var j=0;j<succ.data.length;j++){
							if(i == succ.data[j].datetime){
								if(succ.data[j].type == 0){
									out[i-1] = succ.data[j].money;
								}else{
									input[i-1] = succ.data[j].money;
								}
							}
						}
					}
					optionjson.series[0].data = out;
					optionjson.series[1].data = input;
					myChart.setOption(optionjson);
				}
			},
			error : function() {
				layer.msg('请求失败，稍后再试',{icon : 5});
			}
		});
	}
	//页面加载时
	$(document).ready(function(){
		var myDate= new Date(); 
	    var startYear=myDate.getFullYear()-50;//起始年份 
	    var endYear=myDate.getFullYear();//结束年份 
	    var obj=document.getElementById('year') 
	    for (var i=endYear;i>=startYear;i--) 
	    { 
	      obj.options.add(new Option(i,i)); 
	    } 
	    obj.options[obj.options.length-51].selected=1;
	    form.render('select')
	    //初始化折线图
	    initChart();
	    //调用折线图方法
	    getxAxis(endYear);
	})
});
	
</script>
</html>