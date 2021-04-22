package com.cc.events.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.cc.events.models.Comment;
import com.cc.events.models.Event;
import com.cc.events.repositories.EventRepository;

@Service
public class EventService {
	
    private final EventRepository eventRepo;
    public EventService(EventRepository eventRepo) {
        this.eventRepo = eventRepo;
    }
    
    public List<Event> allEvents() {
        return eventRepo.findAll();
    }
    
    public List<Event> eventsByState(String state) {
        return eventRepo.findEventByState(state);
    }

    public Event createEvent(Event e) {
        return eventRepo.save(e);
    }

    public Event findEvent(Long id) {
        Optional<Event> optionalEvent = eventRepo.findById(id);
        if(optionalEvent.isPresent()) {
            return optionalEvent.get();
        } else {
            return null;
        }
    }

	public Event updateEvent(Event e) {
            return eventRepo.save(e);
    }
	
	public void deleteEvent(Long id) {
		Optional<Event> optionalEvent = eventRepo.findById(id);
		if(optionalEvent.isPresent()) {
			eventRepo.deleteById(id);
            return;
        } else {
            return;
        }
	}

}
