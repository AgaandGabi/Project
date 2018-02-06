package model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

/*
 * The table cannot be called 'user' as it is a reserved word in SQL
 */
@Entity (name="UserTable")  // The Table will be saves as 'UserTable' and not 
// the class name 'User'
public class User {
	
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY) // primary key, auto number
	private int id;
	@Column
	private String username;
	@Column
	private String password;
		
	public User() {}
	
	/* Used in the createUser() method in the LoginServlet, the id is omitted
	 * as it will be created when a User is inserted in to the database. */
	public User(String username, String password) {
		super();
		this.username = username;
		this.password = password;
	}

	public User(int id, String username, String password) {
		this.id = id;
		this.username = username;
		this.password = password;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "LoginInfo [id=" + id + ", username=" + 
				username + ", password=" + password + "]";
	}
}
