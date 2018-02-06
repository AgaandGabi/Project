package controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Product;

/**
 * Servlet implementation class ProductServlet
 */
@WebServlet(
		description = "This Servlet serves all product shop requests", 
		urlPatterns = { 
				"/ProductServlet", 
				"/Shoppinglist"
		})
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	// A reference to the productListDAO class, which will perform any 
	// manipulation to the list of products.
	private ProductDAO productDao;

    public ProductServlet() {
    	/* Instantiate the productDao reference, this productListDAO object
    	 * will be created once for this web app, when the constructor
    	 * execute which is called by Tomcat Server */
    	productDao = new ProductDAO();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		/* When the Servlet first loads, 'action' will be null and we
		 * want to view all of the products */
		if (action == null) 
			action = "viewAll";
		
		System.out.println("action is " + action);
		
		switch (action) {
		case "showInsertForm":
			showInsertForm(request, response);
			break;
		case "insertNewProduct": // when submit is pressed on the insertproduct.jsp
			insertProduct(request, response);
			break;
		case "delete":
			deleteProduct(request, response);
			break;
		case "showUpdateForm":
			showUpdateForm(request, response);
			break;
		case "updateProduct":
			updateProduct(request, response);
			break;
		case "showSearchForm":
			showSearchForm(request, response);
			break;
		case "searchForRecipe":
			searchForRecipe(request, response);
			break;
		case "addToCart":
			addToCart(request, response);
			break;
		case "viewCart":
			viewCart(request, response);
			break;
		case "clearCart":
			clearCart(request, response);
			break;
		case "addQuantityToCart":
			changeQuantityInCart(+1, request, response);
			break;
		case "removeQuantityFromCart":
			changeQuantityInCart(-1, request, response);
			break;
		default: // viewAll:
			getAllRecipes(request, response);
			break;
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	private void clearCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().removeAttribute("cart");
		response.sendRedirect("ProductServlet?action=viewAll");
	}
	
	
	private void changeQuantityInCart(int newQuantity, 
			HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int productId = Integer.parseInt(request.getParameter("productId"));
		Product product = productDao.getProductById(productId);
		Map<Product, Integer> cart = (Map<Product, Integer>)
						request.getSession().getAttribute("cart");
		// When you add a product to the Map, if the product is there already
		// it will not be added again but the quantity will change.
		// newQuantity will be +1 for increasing the quantity and -1
		// for decreasing the quantity
		cart.put(product, cart.get(product) + newQuantity);
		/*
		 * If the new quantity becomes zero, remove that product from
		 * the cart.
		 * cart.get(product) will always get the quantity for that product.
		 */
		if (cart.get(product) == 0) {
			cart.remove(product);
		}
		System.out.println("Quantity changed in the cart for " + product );
		response.sendRedirect("productServlet?action=viewCart");
	}
	
	private void viewCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"\\WEB-INF\\view\\viewCart.jsp");
		dispatcher.forward(request, response);
	}
	
	/**
	 * A user must be logged in before you can add anything to the cart. 
	 * If the 'buy' link is clicked, then the user will be redirected to
	 * the login in page, if they 
	 */
	private void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/* The productId parameter is sent across from the 'Buy' link
		 * on the viewproducts.jsp */
		int productId = Integer.parseInt(request.getParameter("productId"));
		
		/* The cart is going to be a Map object which holds key/value
		 * pairs, i.e. product and quantity values. We need to create
		 * the cart and add in the product and the quantity. We need to
		 * get the product based on the id passed in. */
		Product product = productDao.getProductById(productId);
		System.out.printf("\nproduct for id %d is %s\n", productId, product);	
		
		/* The cart/ Map will be stored in a HttpSession object, which
		 * is used to save info about a user across more than one page
		 * request. Get the HttpSession object and then check if the 
		 * cart exists already. This code will get the HttpSession 
		 * object if it exists, if not, then a HttpSession will be
		 * created. The cart will be added into the HttpSession. 
		 */
		HttpSession session = request.getSession(); 
		
		// If the cart doesn't exist already, then create it.
		if (session.getAttribute("cart") == null) {
			session.setAttribute("cart", new HashMap<Product, Integer>());
		}
		
		/* Retrieve the cart from the HttpSession object to use it */ 
		HashMap<Product, Integer> cart = 
				(HashMap<Product, Integer>)session.getAttribute("cart");
		
		/* Before adding a product to the cart, check if the cart 
		 * already contains that product, if it does, then add 1 to the
		 * quantity already in the cart for that product. */
		int quantity = 1;
		
		if (cart.containsKey(product)) {
			/* cart.get(product) will return the quantity for that product,
			 * i.e. how many times has 'buy' been clicked on for that
			 * product.
			 * cart.get(product) used the key to retrieve the value
			 * from the Map. */
			quantity = cart.get(product) + 1;
		}

		/* This line will add the product and quantity to the Map, if
		 * the map contained the product already, the quantity will
		 * increase by one (due to the code in the if statement), if
		 * the Map doesn't contain that product, it will be added for the
		 * first time with a quantity of 1. */
		cart.put(product, quantity);
		System.out.println("product added to cart ");
		
		/* If the user is not logged in, i.e. if "username" isn't in 
		 * the session, redirect the user to the login page */
		if (session.getAttribute("username") == null)
			response.sendRedirect("LoginServlet?action=showLoginForm");
		else // otherwise the user is logged in, so view all the products
			response.sendRedirect("productServlet?action=viewAll");
	}
	
	private void searchForRecipe(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchText = request.getParameter("searchText"); // text field
		String searchType = request.getParameter("searchType"); // title/author
		
		List<Product> listOfProducts = productDao.searchRecipes(searchType, searchText);
		request.setAttribute("listOfproducts", listOfProducts);
		
		request.getRequestDispatcher("\\WEB-INF\\view\\viewproducts.jsp")
						.forward(request, response);
	}
	
	private void showSearchForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"\\WEB-INF\\view\\search.jsp");
		dispatcher.forward(request, response);
	}
	
	private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get all the parameters from the update JSP
		int productId = Integer.parseInt(request.getParameter("productId"));
		String name = request.getParameter("name");
		String weight = request.getParameter("weight");
		String description = request.getParameter("description");
		BigDecimal price = new BigDecimal(request.getParameter("price"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		
		// create an updated product out of them
		Product productToUpdate = new Product(name, description, price, weight, quantity);
		// Pass that product to the DAO so that the product with the same
		// id can be updated in the list.
		productDao.updateProduct(productToUpdate);
		
		// request is complete, redirect the response to a 'viewAll'
		response.sendRedirect("productServlet?action=viewAll");
	}
	
	private void showUpdateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/* Get the productId, which was sent as a parameter from the 
		 * update link in the viewproducts.jsp */
		int productId = Integer.parseInt(request.getParameter("productId"));
		/* the update form needs a product object, so that it can display
		 * all that products details. */
		Product product = productDao.getProductById(productId);
		/* Pass that product onto the JSP using request.setAttribute() */
		request.setAttribute("product", product);
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"\\WEB-INF\\view\\updateproduct.jsp");
		dispatcher.forward(request, response);
	}
	
	private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get the productId for deletion
		int productId = Integer.parseInt(request.getParameter("productId"));
		// Send that productId to the DAO to delete the product
		productDao.deleteProduct(productId);
		// request done! product deleted, now show all products
		response.sendRedirect("productServlet?action=viewAll");
	}
	
	private void insertProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get all the parameters passed in from the Insert form, i.e.
		// title, author, description and price.
		int productId = Integer.parseInt(request.getParameter("productId"));
		String name = request.getParameter("name");
		String weight = request.getParameter("weight");
		String description = request.getParameter("description");
		BigDecimal price = new BigDecimal(request.getParameter("price"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		
		// Create a product object from those parameters
		Product product = new Product(name, description, price, weight, quantity);
		System.out.println("New product : " + product);
		
		// Pass that product object into the DAO to get it added to
		// the underlying storage (today it's a list tomorrow it
		// will be a database).
		productDao.insertProduct(product);
		
		/* When the product has been added into the list, this request
		 * 'to insert a new product' is complete, we want a new request
		 * now, which is to view all of the products. To start a new 
		 * request from this method and go back into this Servlet
		 * and into the doGet() method, you use response.sendRedirect() */
		response.sendRedirect("productServlet?action=viewAll");
	}


	/*
	 * This method will be called from the switch statement in the 
	 * doGet() and it forwards on the request (to show the insert new
	 * product form) onto the insertproduct.jsp.  A RequestDispatcher is 
	 * used to forward on the request to the JSP page. 
	 */
	private void showInsertForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"\\WEB-INF\\view\\insertproduct.jsp");
		dispatcher.forward(request, response);
	}
	
	private void getAllRecipes(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		
		List<Product> listOfproducts = productDao.getAllProducts();
		/* Pass the listOfproducts to the JSP as an attribute */
		request.setAttribute("listOfproducts", listOfproducts);
		/* Open the JSP page */
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"\\WEB-INF\\view\\viewproducts.jsp");
		dispatcher.forward(request, response);
	}
}
