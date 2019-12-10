package business.impl;

import model.TUser;
import business.basic.iHibBaseDAO;
import business.basic.iHibBaseDAOImpl;
import business.dao.UserDAO;
/**
 * 用户操作接口实现类
 */
public class UserDAOImpl implements UserDAO {

	private iHibBaseDAO bdao;
	public UserDAOImpl() {
		this.bdao = new iHibBaseDAOImpl();
	}
	@Override
	public TUser login(String userid, String pwd) {
		TUser user = (TUser)bdao.findById(TUser.class, userid);
		if(user==null||!user.getUserid().equals(userid)){
			return null;
		}else if(!user.getPwd().equals(pwd)){
			return null;
		}else{
			return user;
		}
	}
	@Override
	public boolean register(TUser user) {
		String proname = "up_addUser(?,?,?)";
		Object[] param = {user.getUserid(),user.getUsername(),user.getPwd()};
		int row = (Integer)bdao.executeProduce(proname, param);
		if(row>0){
			return true;
		}else{
			return false;
		}
	}
}
