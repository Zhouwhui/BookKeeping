package model;

/**
 * VSortType entity. @author MyEclipse Persistence Tools
 */

public class VSortType implements java.io.Serializable {
	private Integer id;
	private String userid;
	private String username;
	private Double totalmoney;
	private Integer sortTypeId;
	private String sortname;
	private Integer types;
	private Integer photoid;
	private String photoname;

	// Constructors

	/** default constructor */
	public VSortType() {
	}

	/** minimal constructor */
	public VSortType(Integer id, String userid, String username,
			Double totalmoney, Integer sortTypeId) {
		this.id = id;
		this.userid = userid;
		this.username = username;
		this.totalmoney = totalmoney;
		this.sortTypeId = sortTypeId;
	}

	/** full constructor */
	public VSortType(Integer id, String userid, String username,
			Double totalmoney, Integer sortTypeId, String sortname,
			Integer types, Integer photoid, String photoname) {
		this.id = id;
		this.userid = userid;
		this.username = username;
		this.totalmoney = totalmoney;
		this.sortTypeId = sortTypeId;
		this.sortname = sortname;
		this.types = types;
		this.photoid = photoid;
		this.photoname = photoname;
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

	public Integer getSortTypeId() {
		return this.sortTypeId;
	}

	public void setSortTypeId(Integer sortTypeId) {
		this.sortTypeId = sortTypeId;
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
}