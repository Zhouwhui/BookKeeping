package business.impl;

import java.sql.ResultSet;
import java.util.List;
import model.TSortType;
import model.TUserSortType;
import model.VSortType;
import business.basic.iHibBaseDAO;
import business.basic.iHibBaseDAOImpl;
import business.dao.SortTypeDAO;
/**
 * 分类类型业务实现类
 * @author sunst
 * @version 2019-9-4
 */
public class SortTypeDAOImpl implements SortTypeDAO {
	private iHibBaseDAO bdao;
	public SortTypeDAOImpl() {
		this.bdao = new iHibBaseDAOImpl();
	}
	
	@Override
	public int addSortType(TSortType sorttype) {
		return (Integer) bdao.insert(sorttype);
	}

	@Override
	public boolean deleteSortType(int id) {
		String proName = "up_deleteSort(?)";
		  Object[] param = {id};
		  int row = (Integer)bdao.executeProduce(proName, param);
		  if(row>0){
		   return true;
		  }else{
		   return false;
		  }
	}

	@Override
	public boolean updateSortType(TSortType sorttype) {
		return bdao.update(sorttype);
	}
	
	@Override
	public int selectSortTypeByName(String sortname){
		String hql = "select count(*) from TSortType where sortname = ?";
		Object[] param = {sortname};
		return bdao.selectValue(hql,param);
	}
	
	@Override
	public List<VSortType> getAllSortType(String userid){
		String hql = "from VSortType where userid=?";
		Object[] param = {userid};
		List<VSortType> list = bdao.select(hql, param);
		if (list!=null && list.size()>0) {
			return list;
		}else {
			return null;
		}
	}
	
	@Override
	public int getSortTypeAmount() {
		String hql = "select count(*) from VSortType";
		return bdao.selectValue(hql);
	}
	
	@Override
	public TSortType getTSortTypeById(int id) {
		return (TSortType) bdao.findById(TSortType.class, id);
	}

	@Override
	public TSortType getTSortTypeByname(String sortname) {
		String hql = "from TSortType where sortname=?";
		Object[] param = {sortname};
		List<TSortType> list = bdao.select(hql, param);
		if (list!=null && list.size()>0) {
			return (TSortType)list.get(0);
		}else {
			return null;
		}
		
	}

	@Override
	public int addUserSortType(TUserSortType sorttype) {
		return (Integer) bdao.insert(sorttype);
	}
}
