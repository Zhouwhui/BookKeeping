package model;


/**
 * VStatistics entity. @author MyEclipse Persistence Tools
 */

public class VStatistics implements java.io.Serializable {

	private Integer sortid;
	private Double money;
	private String datetime;
	private Double totalmoney;
	private String payname;
	private Integer payid;
	private String sortname;
	private Integer type;
	private String userid;

	// Constructors

	/** default constructor */
	public VStatistics() {
	}

	/** minimal constructor */
	public VStatistics(Integer sortid, Double money, String datetime,
			Double totalmoney, Integer type, String userid) {
		this.sortid = sortid;
		this.money = money;
		this.datetime = datetime;
		this.totalmoney = totalmoney;
		this.type = type;
		this.userid = userid;
	}

	/** full constructor */
	public VStatistics(Integer sortid, Double money, String datetime,
			Double totalmoney, String payname, Integer payid, String sortname,
			Integer type, String userid) {
		this.sortid = sortid;
		this.money = money;
		this.datetime = datetime;
		this.totalmoney = totalmoney;
		this.payname = payname;
		this.payid = payid;
		this.sortname = sortname;
		this.type = type;
		this.userid = userid;
	}

	// Property accessors

	public Integer getSortid() {
		return this.sortid;
	}

	public void setSortid(Integer sortid) {
		this.sortid = sortid;
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

	public Double getTotalmoney() {
		return this.totalmoney;
	}

	public void setTotalmoney(Double totalmoney) {
		this.totalmoney = totalmoney;
	}

	public String getPayname() {
		return this.payname;
	}

	public void setPayname(String payname) {
		this.payname = payname;
	}

	public Integer getPayid() {
		return this.payid;
	}

	public void setPayid(Integer payid) {
		this.payid = payid;
	}

	public String getSortname() {
		return this.sortname;
	}

	public void setSortname(String sortname) {
		this.sortname = sortname;
	}

	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getUserid() {
		return this.userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}


}