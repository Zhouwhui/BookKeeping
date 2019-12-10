// default package



/**
 * UserSortTypeId entity. @author MyEclipse Persistence Tools
 */

public class UserSortTypeId  implements java.io.Serializable {


    // Fields    

     private String userid;
     private Integer sortTypeId;


    // Constructors

    /** default constructor */
    public UserSortTypeId() {
    }

    
    /** full constructor */
    public UserSortTypeId(String userid, Integer sortTypeId) {
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
   



   public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof UserSortTypeId) ) return false;
		 UserSortTypeId castOther = ( UserSortTypeId ) other; 
         
		 return ( (this.getUserid()==castOther.getUserid()) || ( this.getUserid()!=null && castOther.getUserid()!=null && this.getUserid().equals(castOther.getUserid()) ) )
 && ( (this.getSortTypeId()==castOther.getSortTypeId()) || ( this.getSortTypeId()!=null && castOther.getSortTypeId()!=null && this.getSortTypeId().equals(castOther.getSortTypeId()) ) );
   }
   
   public int hashCode() {
         int result = 17;
         
         result = 37 * result + ( getUserid() == null ? 0 : this.getUserid().hashCode() );
         result = 37 * result + ( getSortTypeId() == null ? 0 : this.getSortTypeId().hashCode() );
         return result;
   }   





}