package business.dao;
import java.util.List;

import model.*;


public interface StatisticsDAO {
	/**
	 * ��״ͼ
	 * @param year ��ǰ���
	 * @param month ��ѯ���·�
	 * @param userid �û�id
	 * @return
	 */
	public List<Piechart> getStatisics(String year,String month,String userid);

	/**
	 * ����ͼ
	 * @param year ��ѯ���
	 * @param userid �û�id
	 * @return
	 */
	public List<VStatistics> getGraph(String year,String userid);

}
