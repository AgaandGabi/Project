package controller;

import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

import model.Product;
import model.User;



public class HibernateUtil {
	/* A private constructor prevents a class from being instantiated.
	 * This class exists to provide a static method to retrieve the one
	 * instance of the SessionFactory.  */
	private HibernateUtil() {}
	
	/* You need one SessionFactory per web app. It will be used to 
	 * create Session objects which will be used for every 
	 * CRUD (create, read, update, delete) operation. */
	private static SessionFactory sessionFactory;
	
	/* A static global variable should be instantiated in a static 
	 * init block. */
	static {
		/* This Configuration object is only created once during 
		 * application initialization. It represents the config/
		 * properties file required by Hibernate. 
		 * It hooks up to the hibernate.cfg.xml file to read the 
		 * properties. The configure() method uses the mapping and 
		 * properties in that resource/ config file. */
		Configuration config = new Configuration().configure();
		
		/* Lets the Configuration know about the Book class, so that
		 * the annotations can be used to map between Java and SQL 
		 * Server 
		 * If you omit one of these lines, you will get the following exception:
		 * org.hibernate.MappingException: Unknown entity: model.User
		 **/
		config.addAnnotatedClass(Product.class);
		config.addAnnotatedClass(User.class);
		
		/* config.getProperties() gets all the mappings/ properties 
		 * from the hibernate config file. */
		StandardServiceRegistryBuilder builder = 
				new StandardServiceRegistryBuilder().
				applySettings(config.getProperties());
		
		/* A SessionFactory is used to create each Session instance, 
		 * the Configuration object is used to create the SessionFactory */
		sessionFactory = config.buildSessionFactory(builder.build());
	}
	
	/* A static method to return the one instance of the sessionFactory */
	protected static SessionFactory getSessionFactory() {
		return sessionFactory;
	}
}
