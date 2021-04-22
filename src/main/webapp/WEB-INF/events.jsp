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
<title>Events</title>
</head>
<body>	
	<div class = "container">
		<a class= "btn btn-secondary float-right mt-3" href="/logout">Logout</a>
		<h1 class="mt-3">Welcome, <c:out value="${user.firstName}" /></h1>
		<p class="text-success"><c:out value="${success}" /></p>
		<div class="row mt-3">
		<h5>Here are some of the events in your state:</h5>
			<table class="table">
			  <thead class="thead-dark">
			    <tr>
			      <th scope="col">Name</th>
			      <th scope="col">Date</th>
			      <th scope="col">Location</th>
			      <th scope="col">Host</th>
			      <th scope="col">Action/Status</th>
			    </tr>
			  </thead>
			  <tbody>
				  <c:forEach items="${allEvents}" var="event">
				  <c:if test="${user.state == event.state }">
				    <tr>
				      <td><a href="/events/${event.id}"> <c:out value="${event.name}"/> </a></td>
				      <td><c:out value="${event.date}"/></td>
				      <td><c:out value="${event.location}"/></td>
				      <td><c:out value="${event.host.firstName}"/></td>
				      <td class="d-flex justify-content-around">
				      	 <c:choose>
                         	<c:when test="${event.host.id == user.id }">
                                <a class="btn btn-info" href="/events/${event.id}/edit">Edit</a> 
                                <form action="/events/${event.id}" method="post">
					    			<input class="btn btn-danger" type="submit" value="Delete">
								</form>
                            </c:when>
						    <c:otherwise>
                            	<c:set var="attending" value="${false}" />
                            	<c:forEach items="${event.guests}" var="guest">
                                	<c:if test="${guest == user}">
                                    	<c:set var="attending" value="${true}" />
                               		</c:if>
                            	</c:forEach>
                            	<c:choose>
	                            	<c:when test="${attending == false}">
	                                	<form action="/events/addUser/${event.id}" method="post">
							    			<input class="btn btn-success"  type="submit" value="Join">
										</form>
	                            	</c:when>
	                            	<c:otherwise>
       									<form action="/events/removeUser/${event.id}" method="post">
							    			<input class="btn btn-warning"  type="submit" value="Cancel">
										</form>
                                	</c:otherwise>
                           		</c:choose>
                           	</c:otherwise>
                         </c:choose>
				      </td>
				    </tr>
				   </c:if>
				  </c:forEach>
			  </tbody>
			</table>
		</div>
		<div class="row mt-5">
			<h5>Here are some of the events in other states:</h5>
			<table class="table">
			  <thead class="thead-dark">
			    <tr>
			      <th scope="col">Name</th>
			      <th scope="col">Date</th>
			      <th scope="col">Location</th>
			      <th scope="col">State</th>
			      <th scope="col">Host</th>
			      <th scope="col">Action</th>
			    </tr>
			  </thead>
			  <tbody>
				  <c:forEach items="${allEvents}" var="event">
			  		<c:if test="${user.state != event.state }">
				    <tr>
				      <td> <a href="/events/${event.id}">${event.name}</a></td>
				      <td><c:out value="${event.date}"/></td>
				      <td><c:out value="${event.location}"/></td>
				      <td><c:out value="${event.state}"/></td>
				      <td><c:out value="${event.host.firstName}"/></td>
				      <td class="d-flex justify-content-around">
				      	 <c:choose>
                         	<c:when test="${event.host.id == user.id }">
                                <a class="btn btn-info" href="/events/${event.id}/edit">Edit</a> 
                                <form action="/events/${event.id}" method="post">
					    			<input class="btn btn-danger" type="submit" value="Delete">
								</form>
                            </c:when>
						    <c:otherwise>
                            	<c:set var="attending" value="${false}" />
                            	<c:forEach items="${event.guests}" var="guest">
                                	<c:if test="${guest == user}">
                                    	<c:set var="attending" value="${true}" />
                               		</c:if>
                            	</c:forEach>
                            	<c:choose>
	                            	<c:when test="${attending == false}">
	                                	<form action="/events/addUser/${event.id}" method="post">
							    			<input class="btn btn-success"  type="submit" value="Join">
										</form>
	                            	</c:when>
	                            	<c:otherwise>
       									<form action="/events/removeUser/${event.id}" method="post">
							    			<input class="btn btn-warning"  type="submit" value="Cancel">
										</form>
                                	</c:otherwise>
                           		</c:choose>
                           	</c:otherwise>
                         </c:choose>
				      </td>
				    </tr>
				    </c:if>
				  </c:forEach>
			  </tbody>
			</table>
		</div>
		<div class="row mt-5">
			<div class="col">
			<h2>Create an Event</h2>
	    		<form:form class="form-group mt-3" method="post" action="/addEvent" modelAttribute="newEvent">
	    			<form:hidden  value="${userId}" path="host"/>
		    		<p>
		            	<form:label path="name">Name:</form:label>
		            	<form:input path="name" type="text"/>
		            	<form:errors path="name" class="text-danger"/>
		        	</p>
		        	<p>
		            	<form:label path="date">Date:</form:label>
		            	<form:input path="date" type="date" />
		            	<form:errors path="date" class="text-danger"/>
		        	</p>
		        	<p>
		            	<form:label path="location">Location:</form:label>
		            	<form:input path="location" type="text"/>
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
			    	<input type="submit" value="Add Event" class="btn btn-sm btn-primary mt-3" />
			    </form:form>
			</div>
		</div>
	</div>
</body>
</html>