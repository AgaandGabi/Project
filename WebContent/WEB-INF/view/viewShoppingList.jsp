<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Shopping Cart</title>
<style><%@include file="/WEB-INF/css/style.css"%></style> 
</head>
<body>
<h2>View Shopping Cart</h2>

<table>
	<tr><th>Id</th>
		<th>Title</th>
		<th>Author</th>
		<th>Description</th>
		<th>Price</th>
		<th>Quantity</th>
		<th>Change Quantity</th>
		<th>Total</th>
	</tr>
	<!-- We are looping through the shopping cart, it is a map and a 
	map contains key value pairs, the key is the book and the value
	is the quantity ordered for each book. As this loop iterated through
	the cart, each element can be accessed via the "item" variable,
	'item.key' will access the book and 'item.value' will access the
	quantity.  -->
	<c:forEach var="item" items="${cart}">
		<tr>
			<td>${item.key.id}</td>
			<td>${item.key.title}</td>
			<td>${item.key.author}</td>
			<td>${item.key.description}</td>
			<td>&euro;<fmt:formatNumber type="number"
			 maxFractionDigits="2" value="${item.key.price}" /></td>
			<td>${item.value}</td>
			<td>
			<a href="BookServlet?action=addQuantityToCart&bookId=${item.key.id}">Add</a> 
			<a href="BookServlet?action=removeQuantityFromCart&bookId=${item.key.id}">Remove</a></td>
			<td>${item.key.price * item.value}</td>
			<!-- Sets up a total variable and each time through the loop
			the price multiplied by the quantity is added to the total. -->
			<c:set var="total" value="${total + item.key.price * item.value}" /> 
		</tr>
	</c:forEach>
</table>
<p>
<!-- Display the total from the variable declared in the for loop -->
Total cost : &euro;${total}
</p>
<p><a href="BookServlet?action=viewAll">View Books</a></p>
<p><a href="BookServlet?action=clearCart">Clear Shopping Cart</a></p>

</body>
</html>