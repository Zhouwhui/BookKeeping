package model;

/**
 * TBookkeeping entity. @author MyEclipse Persistence Tools
 */

public class TBookkeeping implements java.io.Serializable {

	// Fields

	private Integer id;
	private String userid;
	private Double money;
	private String datetime;
	private Integer payid;
	private Integer sortid;
	private Integer type;
	private String remark;

	// Constructors

	/** default constructor */
	public TBookkeeping() {
	}

	/** minimal constructor */
	public TBookkeeping(String userid, Double money, String datetime,
			Integer payid, Integer sortid, Integer type) {
		this.userid = userid;
		this.money = money;
		this.datetime = datetime;
		this.payid = payid;
		this.sortid = sortid;
		this.type = type;
	}

	/** full constructor */
	public TBookkeeping(String userid, Double money, String datetime,
			Integer payid, Integer sortid, Integer type, String remark) {
		this.userid = userid;
		this.money = money;
		this.datetime = datetime;
		this.payid = payid;
		this.sortid = sortid;
		this.type = type;
		this.remark = remark;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUserid() {
		return this.userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public Double getMoney() {
		return this.money;
	}

	public void setMoney(Double money) {
		this.money = money;
	}

	public String getDatetime() {
		return this.datetime;
	}

	public void setDatetime(String datetime) {
		this.datetime = datetime;
	}

	public Integer getPayid() {
		return this.payid;
	}

	public void setPayid(Integer payid) {
		this.payid = payid;
	}

	public Integer getSortid() {
		return this.sortid;
	}

	public void setSortid(Integer sortid) {
		this.sortid = sortid;
	}

	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}