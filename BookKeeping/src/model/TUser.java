package model;

/**
 * TUser entity. @author MyEclipse Persistence Tools
 */

public class TUser implements java.io.Serializable {

	// Fields

	private String userid;
	private String username;
	private String pwd;
	private Double totalmoney;

	// Constructors

	/** default constructor */
	public TUser() {
	}

	/** full constructor */
	public TUser(String userid, String username, String pwd, Double totalmoney) {
		this.userid = userid;
		this.username = username;
		this.pwd = pwd;
		this.totalmoney = totalmoney;
	}

	// Property accessors

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

	public String getPwd() {
		return this.pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public Double getTotalmoney() {
		return this.totalmoney;
	}

	public void setTotalmoney(Double totalmoney) {
		this.totalmoney = totalmoney;
	}

}