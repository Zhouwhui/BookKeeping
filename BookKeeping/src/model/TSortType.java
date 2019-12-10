package model;

/**
 * TSortType entity. @author MyEclipse Persistence Tools
 */

public class TSortType implements java.io.Serializable {

	// Fields

	private Integer id;
	private Integer photoid;
	private String sortname;
	private Integer types;

	// Constructors

	/** default constructor */
	public TSortType() {
	}

	/** minimal constructor */
	public TSortType(Integer photoid, String sortname) {
		this.photoid = photoid;
		this.sortname = sortname;
	}

	/** full constructor */
	public TSortType(Integer photoid, String sortname, Integer types) {
		this.photoid = photoid;
		this.sortname = sortname;
		this.types = types;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPhotoid() {
		return this.photoid;
	}

	public void setPhotoid(Integer photoid) {
		this.photoid = photoid;
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

}