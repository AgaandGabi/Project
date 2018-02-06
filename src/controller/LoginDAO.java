package controller;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import model.User;

public class LoginDAO {

	/**
	 * Takes a User object and inserts it into the UserTable into the 
	 * database. A transaction is needed when a change is being made in the
	 * database, it will rollback any changes if an error is encountered.
	 */
	protected void insertNewUser(User user) {
		Session session = HibernateUtil.getSessionFactory().openSession();
		Transaction tx = null;

		try {
			tx = session.beginTransaction();   // start the transaction
			session.save(user); // saves the username and password
			tx.commit();		// makes the change in the DB permanent
		} catch (HibernateException e) {
			if (tx != null) 
				tx.rollback(); // undo any changes
			e.printStackTrace();
		} finally {
			session.close();	
		}
	}

	/**
	 * Takes in Strings for the username and password and uses both to
	 * check if they exist in the User table in the database
	 */
	protected boolean validateUser(String username, String password) {
		Session session = HibernateUtil.getSessionFactory().openSession();

		@SuppressWarnings("unchecked")  // remove the 'yellow' warning
		Query<User> query = session.createQuery("FROM UserTable WHERE "
				+ "username = :username AND password = :password");
		/* Assign values to the username and password parameters in the 
		 * Hibernate Query */
		query.setParameter("username", username);
		query.setParameter("password", password);
		
		// A list will be returned containing either one User or the list
		// will be empty.
		List<User> result = (List<User>)query.list();
		session.close();

		// If the list returned from the database is empty, return true,
		// i.e. that username/ password combination doesn't exist.
		return result.isEmpty() ? false : true;
	}


	/**
	 * Using Hibernate, check the database to see if it exists.
	 */
	protected boolean checkUsersExists(String username) {
		Session session = HibernateUtil.getSessionFactory().openSession();

		@SuppressWarnings("unchecked") // removes the 'yellow' warning
		Query<User> query = session.createQuery(
							"FROM UserTable WHERE username = :username");
		// Use setParameter to assign a value to the :username parameter.
		query.setParameter("username", username);
		// A list containing a row will be returned if the username exists.
		List<User> result = (List<User>)query.list();
		session.close();

		// Returns false if the username doen't exists, true if it does.
		return result.isEmpty() ? false : true;
	}
}
