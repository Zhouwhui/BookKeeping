package model;

/**
 * TPhoto entity. @author MyEclipse Persistence Tools
 */

public class TPhoto implements java.io.Serializable {

	// Fields

	private Integer photoid;
	private String photoname;

	// Constructors

	/** default constructor */
	public TPhoto() {
	}

	/** full constructor */
	public TPhoto(String photoname) {
		this.photoname = photoname;
	}

	// Property accessors

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