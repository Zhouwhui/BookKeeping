package business.dao;

import java.util.List;

import model.TBookkeeping;
import model.VBookkeeping;
import model.VSortType;

/**
 * ���˲����ӿ�
 */
public interface BookKeepDAO {
	/**
	 * ��Ӽ��˼�¼
	 * @param bookkeep ����ʵ������
	 * @return ��ӽ����true���ɹ���false��ʧ��
	 */
	public boolean addBookKeep(TBookkeeping bookkeep);
	/**
	 * �༭������Ϣ
	 * @param bookkeep ����ʵ������
	 * @return �༭�����true���ɹ���false��ʧ��
	 */
	public boolean editBookKeep(TBookkeeping bookkeep);
	/**
	 * ɾ�����˼�¼
	 * @param bookkeepid ����id
	 * @return ɾ�������true���ɹ���false��ʧ��
	 */
	public boolean delBookKeep(int bookkeepid);
	/**
	 * ���ݼ���id��ȡ����ʵ�����
	 * @param bookkeepid ����id
	 * @return
	 */
	public TBookkeeping selectById(int bookkeepid);
	/**
	 * ��ȡ��ǰ�û����м��˼�¼
	 * @return ���˼�¼�б�
	 */
	public List<TBookkeeping> select(String userid);
	/**
	 * ����ʱ���ȡ���˼�¼
	 * @return ���˼�¼�б�
	 */
	public List<TBookkeeping> selectByDatetime(String datetime);
	/**
	 * ����֧����ʽ��ȡ���˼�¼
	 * @return ���˼�¼�б�
	 */
	public List<TBookkeeping> selectByPay(int paytype);
	/**
	 * ���ݼ������ͻ�ȡ���˼�¼
	 * @return ���˼�¼�б�
	 */
	public List<TBookkeeping> selectByType(int bookkeeptype);
	
	/**
	 * ��ȡ��ǰ�û����м��˼�¼
	 * @return ���˼�¼�б�
	 */
	public List<VBookkeeping> selectUserALL(String userid,String where);
	
	/**
	 * �����û����������ͻ�ȡ��������
	 * @param userid �û�id
	 * @param type ��������
	 * @return
	 */
	public List<VSortType> getAllSortType(String userid,int type);
}
