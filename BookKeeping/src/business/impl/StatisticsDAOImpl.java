package business.impl;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import model.Piechart;
import model.TBookkeeping;
import model.VStatistics;
import business.basic.iHibBaseDAO;
import business.basic.iHibBaseDAOImpl;
import business.dao.StatisticsDAO;

public class StatisticsDAOImpl implements StatisticsDAO {
	private iHibBaseDAO bdao;
	public StatisticsDAOImpl() {
		this.bdao = new iHibBaseDAOImpl();
	}

	@Override
	public List<Piechart> getStatisics(String year,String month,String userid) {
		String sql = "select sum(money) as value,sortname as name from V_Statistics"
				+" where userid="+userid+" and DATEPART(YEAR,datetime)="+year+" and DATEPART(month,datetime) like'%"+month+"%'"
				+" group by sortname,DATEPART(month,datetime)";
		List<HashMap<String, Object>> list = bdao.selectBysql(sql);
		List<Piechart> newlist = new ArrayList<Piechart>();
		if(list!=null && list.size()>0){
			double totalmoney = 0;
			for(int j = 0; j < list.size(); j++){
				Object value = list.get(j).get("value");
				totalmoney += (Double)value;
			}
			DecimalFormat df = new DecimalFormat("######0.00");
			for (int j = 0; j < list.size(); j++) {
				Object value = list.get(j).get("value");
				Object name = list.get(j).get("name");
				Piechart temporary = new Piechart();
				temporary.setName(name.toString()+" "+df.format((Double)value/totalmoney*100)+"%");
				temporary.setValue((Double)value);
				newlist.add(temporary);
			}
			return newlist;
		}else{
			return null;
		}
	}

	@Override
	public List<VStatistics> getGraph(String year,String userid) {
		String sql = "select DATEPART(month,datetime) as datetime,sum(money) as money,type from V_Statistics"
				+" where userid="+userid+" and datetime like'%"+year+"%' group by DATEPART(month,datetime),type order by datetime";
		List<HashMap<String, Object>> list = bdao.selectBysql(sql);
		List<VStatistics> newlist = new ArrayList<VStatistics>();
		if(list!=null && list.size()>0){
			for (int i = 0; i < 12; i++) {
				for (int j = 0; j < list.size(); j++) {
					Object datetime = list.get(j).get("datetime");
					if (i == (Integer)datetime) {
						Object money = list.get(j).get("money");
						Object type = list.get(j).get("type");
						VStatistics temporary = new VStatistics();
						temporary.setDatetime((datetime).toString());
						temporary.setMoney((Double)(money));
						temporary.setType((Integer)type);
						newlist.add(temporary);
					}
				}
			}
			return newlist;
		}else{
			return null;
		}
	}

}
