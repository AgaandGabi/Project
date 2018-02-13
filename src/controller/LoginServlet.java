package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/*
	 * A reference to the LoginDAO class, this class is used for any 
	 * interactions with the database.
	 */
	private LoginDAO loginDAO;

    public LoginServlet() {
        loginDAO = new LoginDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		if (action == null) 
			action = "login";
		
		System.out.println("LoginServlet, action: " + action);
		
		switch (action) {
		case "createNewUser":
			createNewUser(request, response);
			break;
		case "showCreateNewUserForm":
			showCreateNewUserForm(request, response);
			break;
		case "logout":
			logout(request, response);
			break;
		case "showLoginForm":
			showLoginForm(request, response);
			break;
		case "login":
			login(request, response);
			break;
		default:
			// If something goes wrong with the 'action' string, show the login form.
			showLoginForm(request, response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	
	/*
	 * Get the user's credentials from the login form, validate them against the
	 * database by passing them into the LoginDAO.  
	 */
	private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		System.out.printf("Validating %s and %s\n", username, password);
		
		// If the credentials are in the database, the user is "logged in".
		// Add their username to the HttpSession object and change the Session
		// id, this will remove the previous session's details.
		if (loginDAO.validateUser(username, password)) {
			request.getSession().setAttribute("username", username);
			request.changeSessionId();
			response.sendRedirect("ProductServlet?action=viewAll");
		} else { // incorrect login credentials
			// A HttpServletRequest request's attribute only lives onto the next page. 
			request.setAttribute("message", "Incorrect username and password combination, please try again.");
			// Send this request onto the login form
			request.getRequestDispatcher("WEB-INF/view/login.jsp").
			forward(request, response);
		}
	}
	
	/*
	 * Shows the form to allow the user input their username and password. 
	 */
	private void showLoginForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("message", "");
		request.getRequestDispatcher("WEB-INF/view/login.jsp").
		forward(request, response);
	}
	
	/*
	 * When the logout link is clicked, everything about the user is removed 
	 * from memory (from the HttpSession), calling invalidate() on the session
	 * will do this.
	 */
	private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().invalidate();
		response.sendRedirect("ProductServlet?action=viewAll");
	}
	
	
	/*
	 * Gets the username and password parameters from the request object, sent 
	 * from the createNewUser.jsp. First check that this username doesn't already
	 * exist in the database. Then create a User object from these credentials
	 * and send them to the LoginDAO's insertNewUser() method to be added to
	 * the database.
	 */
	private void createNewUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password1");
		
		User user = new User(username, password);
		loginDAO.insertNewUser(user);
		System.out.println(user + " created in the database");
		
		/* Once a new user has been created. Add their username to the
		 * HttpSession object, so that each page can verify that somebody
		 * is logged. */
		request.getSession().setAttribute("username", username);
		request.changeSessionId();
		
		response.sendRedirect("ProductServlet?action=viewAll");
	}
	
	/*
	 * Shows the form to create a new user in the database.
	 */
	private void showCreateNewUserForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("WEB-INF/view/createNewUser.jsp").
		forward(request, response);
	}
}
