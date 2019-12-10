package model;

/**
 * TPayType entity. @author MyEclipse Persistence Tools
 */

public class TPayType implements java.io.Serializable {

	// Fields

	private Integer payid;
	private Integer photoid;
	private String payname;

	// Constructors

	/** default constructor */
	public TPayType() {
	}

	/** full constructor */
	public TPayType(Integer photoid, String payname) {
		this.photoid = photoid;
		this.payname = payname;
	}

	// Property accessors

	public Integer getPayid() {
		return this.payid;
	}

	public void setPayid(Integer payid) {
		this.payid = payid;
	}

	public Integer getPhotoid() {
		return this.photoid;
	}

	public void setPhotoid(Integer photoid) {
		this.photoid = photoid;
	}

	public String getPayname() {
		return this.payname;
	}

	public void setPayname(String payname) {
		this.payname = payname;
	}

}