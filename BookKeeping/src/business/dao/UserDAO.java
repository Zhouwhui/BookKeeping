package business.dao;

import model.TUser;
/**
 * 用户操作接口
 */
public interface UserDAO {

	/**
	 * 用户登录
	 * @param userid 用户id
	 * @param pwd 密码
	 * @return 用户对象
	 */
	public TUser login(String userid,String pwd);
	/**
	 * 用户注册
	 * @param user 用户实体
	 * @return 注册结果，true：成功，false：失败
	 */
	public boolean register(TUser user);
}
