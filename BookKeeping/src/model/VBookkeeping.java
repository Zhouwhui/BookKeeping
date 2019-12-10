package model;


/**
 * VBookkeeping entity. @author MyEclipse Persistence Tools
 */

public class VBookkeeping implements java.io.Serializable {

	private Integer id;
	private String userid;
	private String username;
	private Double totalmoney;
	private Double money;
	private String datetime;
	private Integer payid;
	private String payname;
	private Integer photoid;
	private String photoname;
	private Integer sortid;
	private String sortname;
	private Integer types;
	private Integer sortphotoid;
	private String sortphotoname;
	private Integer type;
	private String remark;

	// Constructors

	/** default constructor */
	public VBookkeeping() {
	}

	/** minimal constructor */
	public VBookkeeping(Integer id, String userid, Double money,
			String datetime, Integer payid, String payname, Integer photoid,
			Integer sortid, Integer type) {
		this.id = id;
		this.userid = userid;
		this.money = money;
		this.datetime = datetime;
		this.payid = payid;
		this.payname = payname;
		this.photoid = photoid;
		this.sortid = sortid;
		this.type = type;
	}

	/** full constructor */
	public VBookkeeping(Integer id, String userid, String username,
			Double totalmoney, Double money, String datetime, Integer payid,
			String payname, Integer photoid, String photoname, Integer sortid,
			String sortname, Integer types, Integer sortphotoid,
			String sortphotoname, Integer type, String remark) {
		this.id = id;
		this.userid = userid;
		this.username = username;
		this.totalmoney = totalmoney;
		this.money = money;
		this.datetime = datetime;
		this.payid = payid;
		this.payname = payname;
		this.photoid = photoid;
		this.photoname = photoname;
		this.sortid = sortid;
		this.sortname = sortname;
		this.types = types;
		this.sortphotoid = sortphotoid;
		this.sortphotoname = sortphotoname;
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

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Double getTotalmoney() {
		return this.totalmoney;
	}

	public void setTotalmoney(Double totalmoney) {
		this.totalmoney = totalmoney;
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

	public String getPayname() {
		return this.payname;
	}

	public void setPayname(String payname) {
		this.payname = payname;
	}

	public Integer getPhotoid() {
		return this.photoid;
	}

	public void setPhotoid(Integer photoid) {
		this.photoid = photoid;
	}

	public String getPhotoname() {
		return this.photoname;
	}

	public void setPhotoname(String photoname) {
		this.photoname = photoname;
	}

	public Integer getSortid() {
		return this.sortid;
	}

	public void setSortid(Integer sortid) {
		this.sortid = sortid;
	}

	public String getSortname() {
		return this.sortname;
	}

	public void setSortname(String sortname) {
		this.sortname = sortname;
	}

	public Integer getTypes() {
		return this.types;
	}

	public void setTypes(Integer types) {
		this.types = types;
	}

	public Integer getSortphotoid() {
		return this.sortphotoid;
	}

	public void setSortphotoid(Integer sortphotoid) {
		this.sortphotoid = sortphotoid;
	}

	public String getSortphotoname() {
		return this.sortphotoname;
	}

	public void setSortphotoname(String sortphotoname) {
		this.sortphotoname = sortphotoname;
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