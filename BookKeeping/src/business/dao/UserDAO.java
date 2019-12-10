package business.dao;

import model.TUser;
/**
 * �û������ӿ�
 */
public interface UserDAO {

	/**
	 * �û���¼
	 * @param userid �û�id
	 * @param pwd ����
	 * @return �û�����
	 */
	public TUser login(String userid,String pwd);
	/**
	 * �û�ע��
	 * @param user �û�ʵ��
	 * @return ע������true���ɹ���false��ʧ��
	 */
	public boolean register(TUser user);
}
