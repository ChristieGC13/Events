package com.cc.events.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="users")
public class User {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@NotNull
	@Size(min=5, message="First name must be at least 5 characters.")
	private String firstName;
	 
	@NotNull
	@Size(min=5, message="Last name must be at least 5 characters.")
	private String lastName;
	
	@NotNull
	@Email(message = "Must provide a valid email.")
	@Size(min=5)
	private String email;
	
	@NotNull
	@Size(min=5, message="Location must be at least 5 characters.")
	private String location;
	
	@NotEmpty(message="Please provide a State.")
	private String state;
	
	@NotNull
	@Size(min=5, message = "Password must be at least 5 characters.")
	private String password;
	
	@Transient
	private String passwordConfirmation;
	
	@Column(updatable=false)
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date createdAt;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date updatedAt;
	
	@OneToMany(mappedBy="host", fetch = FetchType.LAZY)
    private List<Event> events;
	
	@OneToMany(mappedBy="postedBy", fetch = FetchType.LAZY)
    private List<Comment> comments;
	
	@ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "events_users", 
        joinColumns = @JoinColumn(name = "event_id"), 
        inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private List<Event> eventsAttending;
	
//  ***********************************
//  	Constructor methods
//	***********************************

	 
	public User() {
	}
	
	public User(String firstName, String lastName, String email, String location, String state, String password) {
	this.firstName = firstName;
	this.lastName = lastName;
	this.email = email;
	this.location = location;
	this.state = state;
	this.password = password;
	}

	@PrePersist
	protected void onCreate(){
	     this.createdAt = new Date();
	}
	@PreUpdate
	protected void onUpdate(){
	    this.updatedAt = new Date();
	}

//  ***********************************
// 		Getters and Setters
//	***********************************
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPasswordConfirmation() {
		return passwordConfirmation;
	}

	public void setPasswordConfirmation(String passwordConfirmation) {
		this.passwordConfirmation = passwordConfirmation;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public List<Event> getEvents() {
		return events;
	}

	public void setEvents(List<Event> events) {
		this.events = events;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<Event> getEventsAttending() {
		return eventsAttending;
	}

	public void setEventsAttending(List<Event> eventsAttending) {
		this.eventsAttending = eventsAttending;
	}
	
	
	
}