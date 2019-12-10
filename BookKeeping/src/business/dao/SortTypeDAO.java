package business.dao;
import java.util.List;

import model.TSortType;
import model.TUserSortType;
import model.VSortType;

/**
 * 分类类型业务接口
 * @author sunst
 * @version 2019-9-4
 */
public interface SortTypeDAO {
	/**
	 * 添加一条分类类型信息
	 * @param TSortType分类类型对象
	 * @return 添加成功的文章编号，如<=0则表示添加失败
	 */
	public int addSortType(TSortType sorttype);
	
	/**
	 * 删除一条分类类型信息
	 * @param id 类型编号
	 * @return 受影响的行数
	 */
	public boolean deleteSortType(int id);
	
	/**
	 * 修改一条分类类型信息
	 * @param TSortType分类类型对象
	 * @return 受影响的行数
	 */
	public boolean updateSortType(TSortType sorttype);
	
	/**
	 * 通过类型名称查询是否又该条记录
	 * @param sortname  类型名称
	 * @return 返回值>0,该专业存在，返回值<0该专业不存在
	 */
	public int selectSortTypeByName(String sortname);
	
	/**
	 * 分页查询类型信息
	 * @param currentPage
	 * @param pageSize
	 * @return 用户名可用返回true， 否则返回false
	 */
	public List<VSortType> getAllSortType(String userid);
	
	/**
	 * 查询类型信息的记录数量
	 * @return
	 */
	public int getSortTypeAmount();
	
	/**
	 * 通过类型编号查询类型信息
	 * @param id 类型编号
	 * @return 
	 */
	public TSortType getTSortTypeById(int id);
	
	/**
	 * 通过类型名称查询类型信息
	 * @param name 名称
	 * @return 
	 */
	public TSortType getTSortTypeByname(String sortname);
	
	/**
	 * 添加一条分类关系信息
	 * @param TUserSortType分类类型对象
	 * @return 添加成功的文章编号，如<=0则表示添加失败
	 */
	public int addUserSortType(TUserSortType sorttype);
}
