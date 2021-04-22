package com.cc.events.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.cc.events.models.Event;

@Repository
public interface EventRepository extends CrudRepository<Event, Long> {
    
	
	List<Event> findAll();
	
	List<Event> findEventByState(String state);
	
	void deleteById(Long id);
	
	Event save(Event x);
	
	Optional<Event> findById(Long id);
	
}
