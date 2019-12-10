package business.dao;
import java.util.List;

import model.TSortType;
import model.TUserSortType;
import model.VSortType;

/**
 * ��������ҵ��ӿ�
 * @author sunst
 * @version 2019-9-4
 */
public interface SortTypeDAO {
	/**
	 * ���һ������������Ϣ
	 * @param TSortType�������Ͷ���
	 * @return ��ӳɹ������±�ţ���<=0���ʾ���ʧ��
	 */
	public int addSortType(TSortType sorttype);
	
	/**
	 * ɾ��һ������������Ϣ
	 * @param id ���ͱ��
	 * @return ��Ӱ�������
	 */
	public boolean deleteSortType(int id);
	
	/**
	 * �޸�һ������������Ϣ
	 * @param TSortType�������Ͷ���
	 * @return ��Ӱ�������
	 */
	public boolean updateSortType(TSortType sorttype);
	
	/**
	 * ͨ���������Ʋ�ѯ�Ƿ��ָ�����¼
	 * @param sortname  ��������
	 * @return ����ֵ>0,��רҵ���ڣ�����ֵ<0��רҵ������
	 */
	public int selectSortTypeByName(String sortname);
	
	/**
	 * ��ҳ��ѯ������Ϣ
	 * @param currentPage
	 * @param pageSize
	 * @return �û������÷���true�� ���򷵻�false
	 */
	public List<VSortType> getAllSortType(String userid);
	
	/**
	 * ��ѯ������Ϣ�ļ�¼����
	 * @return
	 */
	public int getSortTypeAmount();
	
	/**
	 * ͨ�����ͱ�Ų�ѯ������Ϣ
	 * @param id ���ͱ��
	 * @return 
	 */
	public TSortType getTSortTypeById(int id);
	
	/**
	 * ͨ���������Ʋ�ѯ������Ϣ
	 * @param name ����
	 * @return 
	 */
	public TSortType getTSortTypeByname(String sortname);
	
	/**
	 * ���һ�������ϵ��Ϣ
	 * @param TUserSortType�������Ͷ���
	 * @return ��ӳɹ������±�ţ���<=0���ʾ���ʧ��
	 */
	public int addUserSortType(TUserSortType sorttype);
}
