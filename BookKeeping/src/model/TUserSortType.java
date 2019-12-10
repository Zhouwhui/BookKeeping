package model;

/**
 * TUserSortType entity. @author MyEclipse Persistence Tools
 */

public class TUserSortType implements java.io.Serializable {
	private Integer sortTypeId;
	private String userid;

	// Constructors

	/** default constructor */
	public TUserSortType() {
	}

	/** full constructor */
	public TUserSortType(String userid, Integer sortTypeId) {
		this.userid = userid;
		this.sortTypeId = sortTypeId;
	}

	// Property accessors

	public String getUserid() {
		return this.userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public Integer getSortTypeId() {
		return this.sortTypeId;
	}

	public void setSortTypeId(Integer sortTypeId) {
		this.sortTypeId = sortTypeId;
	}

}