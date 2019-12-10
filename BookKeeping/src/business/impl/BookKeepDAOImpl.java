package business.impl;

import java.util.List;

import model.TBookkeeping;
import model.VSortType;
import model.VBookkeeping;
import business.basic.iHibBaseDAO;
import business.basic.iHibBaseDAOImpl;
import business.dao.BookKeepDAO;
/**
 * 记账操作接口实现类
 */
public class BookKeepDAOImpl implements BookKeepDAO {
	
	private iHibBaseDAO bdao;
	public BookKeepDAOImpl() {
		this.bdao = new iHibBaseDAOImpl();
	}
	@Override
	public boolean addBookKeep(TBookkeeping bookkeep) {
		String proName = "up_addBookkeep(?,?,?,?,?,?,?)";
		Object[] param = {bookkeep.getUserid(),bookkeep.getMoney(),bookkeep.getDatetime(),bookkeep.getPayid(),bookkeep.getSortid(),bookkeep.getType(),bookkeep.getRemark()};
		int row = (Integer)bdao.executeProduce(proName, param);
		if(row>0){
			return true;
		}else{
			return false;
		}
	}

	@Override
	public boolean editBookKeep(TBookkeeping bookkeep) {
		String proName = "up_editBookkeep(?,?,?,?,?,?,?)";
		Object[] param = {bookkeep.getId(),bookkeep.getType(),bookkeep.getMoney(),bookkeep.getDatetime(),bookkeep.getPayid(),bookkeep.getSortid(),bookkeep.getRemark()};
		int row = (Integer)bdao.executeProduce(proName, param);
		if(row>0){
			return true;
		}else{
			return false;
		}
	}

	@Override
	public boolean delBookKeep(int bookkeepid) {
		String proName = "up_deleteBookkeep(?)";
		Object[] param = {bookkeepid};
		int row = (Integer)bdao.executeProduce(proName, param);
		if(row>0){
			return true;
		}else{
			return false;
		}
	}

	@Override
	public TBookkeeping selectById(int bookkeepid) {
		/*String hql = "from TBookkeeping where id=?";
		Object[] param = {bookkeepid};*/
		TBookkeeping bookkeep = (TBookkeeping)bdao.findById(TBookkeeping.class, bookkeepid);
		if(bookkeep!=null && !bookkeep.getUserid().equals("")){
			return bookkeep;
		}else{
			return null;
		}
	}
	
	@Override
	public List<TBookkeeping> select(String userid) {
		String hql = "from TBookkeeping where userid=?";
		Object[] param = {userid};
		List<TBookkeeping> list = bdao.select(hql,param);
		if(list!=null && list.size()>0){
			return list;
		}else{
			return null;
		}
	}

	@Override
	public List<TBookkeeping> selectByDatetime(String datetime) {
		String hql = "from TBookkeeping where datetime=?";
		Object[] param = {datetime};
		List<TBookkeeping> list = bdao.select(hql,param);
		if(list!=null && list.size()>0){
			return list;
		}else{
			return null;
		}
	}

	@Override
	public List<TBookkeeping> selectByPay(int paytype) {
		String hql = "from TBookkeeping where payid=?";
		Object[] param = {paytype};
		List<TBookkeeping> list = bdao.select(hql,param);
		if(list!=null && list.size()>0){
			return list;
		}else{
			return null;
		}
	}

	@Override
	public List<TBookkeeping> selectByType(int bookkeeptype) {
		String hql = "from TBookkeeping where type=?";
		Object[] param = {bookkeeptype};
		List<TBookkeeping> list = bdao.select(hql,param);
		if(list!=null && list.size()>0){
			return list;
		}else{
			return null;
		}
	}
	
	public List<VBookkeeping> selectUserALL(String userid,String where) {
		String hql = "from VBookkeeping where userid=?"+where;
		Object[] param = {userid};
		List<VBookkeeping> list = bdao.select(hql, param);
		if(list!=null && list.size()>0){
			return list;
		}else{
			return null;
		}
	}
	@Override
	public List<VSortType> getAllSortType(String userid, int type) {
		String hql = "from VSortType where userid=? and types=?";
		Object[] param = {userid,type};
		List<VSortType> list = bdao.select(hql, param);
		if (list!=null && list.size()>0) {
			return list;
		}else {
			return null;
		}
	}

}
