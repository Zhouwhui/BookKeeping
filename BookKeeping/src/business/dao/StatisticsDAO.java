package business.dao;
import java.util.List;

import model.*;


public interface StatisticsDAO {
	/**
	 * 饼状图
	 * @param year 当前年份
	 * @param month 查询的月份
	 * @param userid 用户id
	 * @return
	 */
	public List<Piechart> getStatisics(String year,String month,String userid);

	/**
	 * 曲线图
	 * @param year 查询年份
	 * @param userid 用户id
	 * @return
	 */
	public List<VStatistics> getGraph(String year,String userid);

}
