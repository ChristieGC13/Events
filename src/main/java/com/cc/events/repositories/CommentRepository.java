package com.cc.events.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.cc.events.models.Comment;

@Repository
public interface CommentRepository extends CrudRepository<Comment, Long> {
    
	
	
	List<Comment> findAll();
	
	void deleteById(Long id);
	
	Comment save(Comment x);
	
	Optional<Comment> findById(Long id);
	
}
