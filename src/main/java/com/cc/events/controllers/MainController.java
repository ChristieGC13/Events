package com.cc.events.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cc.events.models.Comment;
import com.cc.events.models.Event;
import com.cc.events.models.User;
import com.cc.events.services.CommentService;
import com.cc.events.services.EventService;
import com.cc.events.services.UserService;
import com.cc.events.validators.UserValidator;

@Controller
public class MainController {
	
	private final UserService userServ;
	private final UserValidator userValidator;
	private final EventService eventServ;
	private final CommentService commentServ;
	public MainController(UserService userServ, UserValidator userValidator, EventService eventServ, CommentService commentServ) {
		this.userServ = userServ;
		this.userValidator = userValidator;
		this.eventServ = eventServ;
		this.commentServ = commentServ;
	}
	
//***************************************
//	Register User
//***************************************

	@GetMapping("/registration")
	public String registerPage(Model model) {
		model.addAttribute("user", new User());
		return "register.jsp";
	}
	
	@PostMapping("/registration")
	public String register(@Valid @ModelAttribute("user") User user, BindingResult result, HttpSession session, RedirectAttributes redirect) {
		userValidator.validate(user, result);
		if (result.hasErrors()) {
			return "register.jsp";
		} else {
			User u = userServ.registerUser(user);
			//put user in session
			session.setAttribute("userId", u.getId());
			redirect.addFlashAttribute("success","You're officially registered!");
			return "redirect:/events";
		}
	}
	
//***************************************
//	Login User
//***************************************
	
	@GetMapping("/login")
	public String loginPage() {
		return "login.jsp";
	}
	
	@PostMapping("/login")
	public String login(@RequestParam(value="email") String email, @RequestParam(value="password") String password, HttpSession session, RedirectAttributes redirect ) {
        if (userServ.authenticateUser(email, password)) {
        		User u = userServ.findByEmail(email);
        		session.setAttribute("userId", u.getId());
        		return "redirect:/events";
        } else {
        		redirect.addFlashAttribute("error","Invalid Login");
        		return "redirect:/login";
        }
	}
	
//***************************************
//	Events Dashboard/Create Event
//***************************************
	
	@GetMapping("/events")
	public String dashboard(@ModelAttribute("newEvent") Event newEvent, BindingResult result, HttpSession session, Model model, RedirectAttributes redirect) {	
		Long userId = (Long) session.getAttribute("userId");
		String userSt = (String) session.getAttribute("userState");
		if(userId == null) {
			redirect.addFlashAttribute("force","Please login first. ");
			return "redirect:/login";
		}
		model.addAttribute("user", userServ.findUserById(userId));
		model.addAttribute("allEvents", eventServ.allEvents());
		model.addAttribute("eventsByState", eventServ.eventsByState(userSt));
		return "events.jsp";
	}
	
	@PostMapping("/addEvent")
	public String addEvent(@Valid @ModelAttribute("newEvent") Event newEvent, BindingResult result) {
		if (result.hasErrors()) {
			return "events.jsp";
		} else {
			eventServ.createEvent(newEvent);
			return "redirect:/events";
		}
	}
	
//***************************************
//	Join/Cancel Event
//***************************************

	@PostMapping("/events/addUser/{event_id}")
	 public String addUser(@PathVariable("event_id") Long event_id, HttpSession session) {
		Event event = eventServ.findEvent(event_id);
		User user = userServ.findUserById((Long) session.getAttribute("userId"));
		List <User> uInEvents = event.getGuests();
		uInEvents.add(user);
		eventServ.createEvent(event);
		return "redirect:/events";
	}
	
	@PostMapping("/events/removeUser/{event_id}") 
		public String removeUser(@PathVariable("event_id") Long event_id, HttpSession session) {
		Event event = eventServ.findEvent(event_id);
		User user = userServ.findUserById((Long) session.getAttribute("userId"));
		List <User> uInEvents = event.getGuests();
		uInEvents.remove(user);
		eventServ.createEvent(event);
		return "redirect:/events";
	}
//***************************************
//	Edit/Update Event
//***************************************

	@GetMapping("/events/{id}/edit")
	public String editEvent(@ModelAttribute("event") Event event, BindingResult result, Model model, @PathVariable("id") Long id, HttpSession session){
		Event events = eventServ.findEvent(id);
		model.addAttribute("event", events);
		return "editEvent.jsp";
	}
	
	@PutMapping("/events/{id}/edit")
	public String edit(@Valid @ModelAttribute("event") Event event,
			BindingResult result, Model model, @PathVariable("id") Long id) {
		if (result.hasErrors()) {
			Event events = eventServ.findEvent(id);
			model.addAttribute("event", events);
			return "editEvent.jsp";
		} else {
			eventServ.updateEvent(event);
			return "redirect:/events";
		}
	}

//***************************************
//	Show event
//***************************************
	
	@GetMapping("/events/{id}")
	public String showEvent(@ModelAttribute("comment") Comment comment, BindingResult result, Model model, @PathVariable("id") Long id, HttpSession session){
		Event event = eventServ.findEvent(id);
        List <User> guests = event.getGuests();
        int currentGuests = guests.size() + 1;
		model.addAttribute("event", event);
		model.addAttribute("comment", comment);
		model.addAttribute("guests", guests);
		model.addAttribute("currentGuests", currentGuests);
		return "showEvent.jsp";
	}
	
	@PostMapping("/addComment/{id}")
	public String addComment(@PathVariable("id") Long id, @RequestParam("content") String content, HttpSession session) {
		Comment comment = new Comment();
		User user = userServ.findUserById((Long) session.getAttribute("userId"));
		comment.setContent(content);
		comment.setPostedBy(user);
		Comment newComment = commentServ.createComment(comment);
        Event event = eventServ.findEvent(id);
        List <Comment> cInEvents = event.getComments();
        cInEvents.add(newComment);
        comment.setEventCommented(event);
            eventServ.createEvent(event);
        return "redirect:/events/" + event.getId();
	}
	
//***************************************
//	DeleteEvent
//***************************************
	

	@PostMapping("/events/{id}")
	public String destroy(@PathVariable("id") Long id){
		eventServ.deleteEvent(id);
		return "redirect:/events";
	}
	
//***************************************
//	Logout
//***************************************
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
}
