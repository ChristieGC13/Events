<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/style.css">
<script type="text/javascript" src="js/app.js"></script>
<link rel="stylesheet" href="/webjars/bootstrap/4.5.0/css/bootstrap.min.css" />
<script src="/webjars/jquery/3.5.1/jquery.min.js"></script>
<script src="/webjars/bootstrap/4.5.0/js/bootstrap.min.js"></script>

<meta charset="UTF-8">
<title>Events-Registration Page</title>
</head>
<body>	
	<div class = "container">
		<div class="row mt-3">
			<div class="col">
			<h1>Register!</h1>
    		<form:form class="form-group" method="POST" action="/registration" modelAttribute="user">
    		<p>
            	<form:label path="firstName">First Name:</form:label>
            	<form:input type="text" path="firstName"/>
            	<form:errors path="firstName" class="text-danger"/>
        	</p>
        	<p>
            	<form:label path="lastName">Last Name:</form:label>
            	<form:input type="text" path="lastName"/>
            	<form:errors path="lastName" class="text-danger"/>
        	</p>
        	<p>
            	<form:label path="email">Email:</form:label>
            	<form:input type="email" path="email"/>
            	<form:errors path="email" class="text-danger"/>
        	</p>
        	<p>
            	<form:label path="location">Location:</form:label>
            	<form:input type="text" path="location"/>
            	<form:errors path="location" class="text-danger"/>
            </p>
            <p>
	            <form:label path="state">State:</form:label>
	            <form:select path="state">
					<form:option value="">--Select--</form:option>
					<form:option value="AK">Alaska</form:option>
					<form:option value="AL">Alabama</form:option>
					<form:option value="AR">Arkansas</form:option>
					<form:option value="AZ">Arizona</form:option>
					<form:option value="CA">California</form:option>
					<form:option value="CO">Colorado</form:option>
					<form:option value="CT">Connecticut</form:option>
					<form:option value="DC">District of Columbia</form:option>
					<form:option value="DE">Delaware</form:option>
					<form:option value="FL">Florida</form:option>
					<form:option value="GA">Georgia</form:option>
					<form:option value="HI">Hawaii</form:option>
					<form:option value="IA">Iowa</form:option>
					<form:option value="ID">Idaho</form:option>
					<form:option value="IL">Illinois</form:option>
					<form:option value="IN">Indiana</form:option>
					<form:option value="KS">Kansas</form:option>
					<form:option value="KY">Kentucky</form:option>
					<form:option value="LA">Louisiana</form:option>
					<form:option value="MA">Massachusetts</form:option>
					<form:option value="MD">Maryland</form:option>
					<form:option value="ME">Maine</form:option>
					<form:option value="MI">Michigan</form:option>
					<form:option value="MN">Minnesota</form:option>
					<form:option value="MO">Missouri</form:option>
					<form:option value="MS">Mississippi</form:option>
					<form:option value="MT">Montana</form:option>
					<form:option value="NC">North Carolina</form:option>
					<form:option value="ND">North Dakota</form:option>
					<form:option value="NE">Nebraska</form:option>
					<form:option value="NH">New Hampshire</form:option>
					<form:option value="NJ">New Jersey</form:option>
					<form:option value="NM">New Mexico</form:option>
					<form:option value="NV">Nevada</form:option>
					<form:option value="NY">New York</form:option>
					<form:option value="OH">Ohio</form:option>
					<form:option value="OK">Oklahoma</form:option>
					<form:option value="OR">Oregon</form:option>
					<form:option value="PA">Pennsylvania</form:option>
					<form:option value="PR">Puerto Rico</form:option>
					<form:option value="RI">Rhode Island</form:option>
					<form:option value="SC">South Carolina</form:option>
					<form:option value="SD">South Dakota</form:option>
					<form:option value="TN">Tennessee</form:option>
					<form:option value="TX">Texas</form:option>
					<form:option value="UT">Utah</form:option>
					<form:option value="VA">Virginia</form:option>
					<form:option value="VT">Vermont</form:option>
					<form:option value="WA">Washington</form:option>
					<form:option value="WI">Wisconsin</form:option>
					<form:option value="WV">West Virginia</form:option>
					<form:option value="WY">Wyoming</form:option>
				</form:select>
				<form:errors path="state" class="text-danger"/>
        	</p>
        	<p>
            	<form:label path="password">Password:</form:label>
            	<form:password path="password"/>
            	<form:errors path="password" class="text-danger"/>
        	</p>
        	<p>
            	<form:label path="passwordConfirmation">Password Confirmation:</form:label>
            	<form:password path="passwordConfirmation"/>
            	<form:errors path="passwordConfirmation" class="text-danger"/>
        	</p>
        		<input class="btn btn-primary mb-3" type="submit" value="Register!"/>
    		</form:form>
    		<a href="/login">Login Here</a>
			</div>
		</div>
	</div>
</body>
</html>