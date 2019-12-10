package business.dao;

import java.util.List;

import model.TBookkeeping;
import model.VBookkeeping;
import model.VSortType;

/**
 * 记账操作接口
 */
public interface BookKeepDAO {
	/**
	 * 添加记账记录
	 * @param bookkeep 记账实体类型
	 * @return 添加结果，true：成功，false：失败
	 */
	public boolean addBookKeep(TBookkeeping bookkeep);
	/**
	 * 编辑记账信息
	 * @param bookkeep 记账实体类型
	 * @return 编辑结果，true：成功，false：失败
	 */
	public boolean editBookKeep(TBookkeeping bookkeep);
	/**
	 * 删除记账记录
	 * @param bookkeepid 记账id
	 * @return 删除结果，true：成功，false：失败
	 */
	public boolean delBookKeep(int bookkeepid);
	/**
	 * 根据记账id获取记账实体对象
	 * @param bookkeepid 记账id
	 * @return
	 */
	public TBookkeeping selectById(int bookkeepid);
	/**
	 * 获取当前用户所有记账记录
	 * @return 记账记录列表
	 */
	public List<TBookkeeping> select(String userid);
	/**
	 * 根据时间获取记账记录
	 * @return 记账记录列表
	 */
	public List<TBookkeeping> selectByDatetime(String datetime);
	/**
	 * 根据支付方式获取记账记录
	 * @return 记账记录列表
	 */
	public List<TBookkeeping> selectByPay(int paytype);
	/**
	 * 根据记账类型获取记账记录
	 * @return 记账记录列表
	 */
	public List<TBookkeeping> selectByType(int bookkeeptype);
	
	/**
	 * 获取当前用户所有记账记录
	 * @return 记账记录列表
	 */
	public List<VBookkeeping> selectUserALL(String userid,String where);
	
	/**
	 * 根据用户，记账类型获取分类类型
	 * @param userid 用户id
	 * @param type 记账类型
	 * @return
	 */
	public List<VSortType> getAllSortType(String userid,int type);
}
