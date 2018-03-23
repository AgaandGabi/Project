<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert Product</title>
<style><%@include file="/WEB-INF/css/style.css"%></style> 
</head>
<body>

<h2>Insert Product details</h2>
<div id="divform">
<form action="ProductServlet?action=insertNewProduct"  method="post"  class = "insertproductform" name="certform" >
	<p>Name</p>
	<input type="text" name="name" class="input" placeholder="product" required>
	<p>Weight</p>
	<input type="text" class="input" name="weight" value="100gr">
	<p>Quantity</p>
	<input type="text" name="quantity" class="input" placeholder="quantity" required>
	<p>Price</p>
	<input type="text" class="input" name="price" placeholder="price">
	<input type="button" value="Insert" class="submit" onclick="closeSelf();">

	
</form>
</div>
        <div  id="closelink" style="display:none">
            <a href="javascript:window.close()">Click Here to Close this Page</a>
        </div>

<c:if test="${cart != null && !cart.isEmpty()}">

	<c:forEach var="item" items="${cart}">
		<c:set var="count" value="${count + item.value}"></c:set>
	</c:forEach>

	<a href="ProductServlet?action=viewCart">View shopping list: ${count} item(s)</a>
</c:if>


<script type="text/javascript">
/* Toggle between adding and removing the "responsive" class to topnav when the user clicks on the icon */

function closeSelf(){
    document.forms['certform'].submit();
    hide(document.getElementById('divform'));
    unHide(document.getElementById('closelink'));

}



</script>

</body>
</html>