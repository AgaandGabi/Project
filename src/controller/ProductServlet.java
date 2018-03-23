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

/*	protected void doGet(HttpServletRequest request, HttpServletResponse response, String name, BigDecimal price, int quantity, int weight) throws ServletException, IOException {
*/	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");

		if (action == null) 
			action = "indexpage";
		
		System.out.println("The action is " + action);
		
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
		case "showUpdateProduct":
			showUpdateProduct(request, response);
			break;
    	case "displayProduct":
			displayProduct(request, response);
			break;
		case "updateProduct":
			System.out.println("In updateProduct switch");
			updateProduct(request, response);
/*			updateProduct(request, response, name, price, quantity, weight);
*/			break;
		case "showSearchForm":
			System.out.println("In showSearchForm");
			showSearchForm(request, response);
			break;
		case "searchForRecipe":
			searchForRecipe(request, response);
			break;
		case "mealPlanner":
			mealPlanner(request, response);
			break;
		case "eatingHealthy":
			eatingHealthy(request, response);
			break;
		case "contact":
			contact(request, response);
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
		case "viewall":
			getAllProducts(request, response);
			break;
		default:
			System.out.println("index");
			index(request, response);
			break;
	
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	private void changeQuantityInCart(int newQuantity, 
			HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int productId = Integer.parseInt(request.getParameter("productId"));
		Product product = productDao.getProductById(productId);
		Map<Product, Integer> cart = (Map<Product, Integer>)
						request.getSession().getAttribute("cart");
		cart.put(product, cart.get(product) + newQuantity);
		if (cart.get(product) == 0) {
			cart.remove(product);
		}
		System.out.println("Quantity changed in the cart for " + product );
		response.sendRedirect("ProductServlet?action=viewCart");
	}

	private void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int productId = Integer.parseInt(request.getParameter("productId"));
		Product product = productDao.getProductById(productId);
		System.out.printf("\nproduct for id %d is %s\n", productId, product);	
		HttpSession session = request.getSession(); 
		if (session.getAttribute("cart") == null) {
			session.setAttribute("cart", new HashMap<Product, Integer>());
		}
		HashMap<Product, Integer> cart = 
				(HashMap<Product, Integer>)session.getAttribute("cart");
		int quantity = 1;
		
		if (cart.containsKey(product)) {
			quantity = cart.get(product) + 1;
		}
		cart.put(product, quantity);
		System.out.println("product added to cart ");
		if (session.getAttribute("username") == null)
			response.sendRedirect("LoginServlet?action=showLoginForm");
		else // otherwise the user is logged in, so view all the products
			response.sendRedirect("ProductServlet?action=viewAll");
	}
	private void clearCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().removeAttribute("cart");
		response.sendRedirect("ProductServlet?action=viewAll");
	}
	
	private void searchForRecipe(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchText = request.getParameter("searchText"); 
		String searchType = request.getParameter("searchType"); 
		List<Product> listOfProducts = productDao.searchRecipes(searchType, searchText);
		request.setAttribute("listOfProducts", listOfProducts);
		request.getRequestDispatcher("\\WEB-INF\\view\\displayProduct.jsp")
						.forward(request, response);
	}
	
	private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Currently the update is returning the original data and saving it back to the DB, no changes are committed.
		// The data that is changed in the form field for the record needs to be passed back to the update method.

		System.out.println("in updateProduct method");
        int productId = Integer.parseInt(request.getParameter("productId"));
		System.out.println("productId: " + productId);
		Product product = productDao.getProductById(productId);
		request.setAttribute("product", product);

		String name = request.getParameter("name");
		System.out.println("name: " + name);

		BigDecimal price = new BigDecimal(request.getParameter("price"));
		System.out.println("price: " + price);
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		System.out.println("quantity: " + quantity);
		int weight = Integer.parseInt(request.getParameter("weight"));
		System.out.println("weight: " + weight);

		
	    Product productToUpdate = new Product(name,  price,  quantity, weight);
		productDao.updateProduct(productToUpdate);
        response.sendRedirect("ProductServlet?action=viewall");
	}
	
	private void showUpdateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int productId = Integer.parseInt(request.getParameter("productId"));
				Product product = productDao.getProductById(productId);
				request.setAttribute("product", product);
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"\\WEB-INF\\view\\updateProduct.jsp");
		dispatcher.forward(request, response);
	}
	
	private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Get the productId for deletion
		int productId = Integer.parseInt(request.getParameter("productId"));
		// Send that productId to the DAO to delete the product
		productDao.deleteProduct(productId);
		// request done! product deleted, now show all products
		response.sendRedirect("ProductServlet?action=viewall");
	}
	
	private void insertProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		BigDecimal price = new BigDecimal(request.getParameter("price"));
		int quantity = Integer.parseInt(request.getParameter("quantity"));
		int weight = Integer.parseInt((request.getParameter("weight").substring(0,3)));
		Product product = new Product(name, price, quantity, weight);
		System.out.println("New product : " + product);
		productDao.insertProduct(product);
		//response.sendRedirect("ProductServlet?action=viewall");
	}

	private void getAllProducts(HttpServletRequest request, 
			HttpServletResponse response) 
					throws ServletException, IOException {
		List<Product> listOfProducts = productDao.getAllProducts();
		request.setAttribute("listOfProducts", listOfProducts);
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"\\WEB-INF\\view\\displayProduct.jsp");
		System.out.println("In getAllProducts method" + listOfProducts);
		dispatcher.forward(request, response);
	}
	
	private void displayProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"\\WEB-INF\\view\\displayProduct.jsp");	
		System.out.println("In displayProduct method");
		dispatcher.forward(request, response);
	}
		
		private void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			RequestDispatcher dispatcher = request.getRequestDispatcher(
					"\\WEB-INF\\view\\index.jsp");	
			System.out.println("show index");
			dispatcher.forward(request, response);
	}
	
	private void viewCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"\\WEB-INF\\view\\viewShoppingList.jsp");
		dispatcher.forward(request, response);
	}
	
	private void showSearchForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"\\WEB-INF\\view\\searchRecipes.jsp");
		System.out.println("In showSearchForm method");
		dispatcher.forward(request, response);
	}
	
	private void mealPlanner(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"\\WEB-INF\\view\\mealPlanner.jsp");
		dispatcher.forward(request, response);
	}
	
	private void eatingHealthy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"\\WEB-INF\\view\\eatingHealthy.jsp");
		dispatcher.forward(request, response);
	}
	private void contact(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"\\WEB-INF\\view\\contact.jsp");
		dispatcher.forward(request, response);
	}
	
	private void showInsertForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher(
				"\\WEB-INF\\view\\insertProduct.jsp");
		dispatcher.forward(request, response);
	}
	
}
