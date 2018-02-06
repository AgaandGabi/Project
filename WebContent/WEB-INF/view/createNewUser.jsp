<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create New User</title>
<style><%@include file="/WEB-INF/css/style.css"%></style> 
</head>
<body>

<h2>New User - Enter Details</h2>

${message}

<form action="LoginServlet?action=createNewUser" method="post">

<p>Username</p>
<p><input type="text" name="username" required></p>

<p>Password</p>
<p><input type="password" name="password1" required> </p>

<p>Confirm</p>
<p><input type="password" name="password2" required> </p>

<p><input type="submit" value="Create new user"></p>

</form>
</body>
</html>