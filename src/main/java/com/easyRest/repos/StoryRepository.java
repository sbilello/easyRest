package com.easyRest.repos;

import java.util.List;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.data.rest.core.annotation.RestResource;

import com.easyRest.model.Story;

@RepositoryRestResource(path="story")
public interface StoryRepository extends PagingAndSortingRepository<Story, Long> {
	 
	 List<Story> findByTitle(@Param("title") String title);
	
	 @RestResource(exported = false)
	 public void delete(Long arg0);
	 
	 @RestResource(exported = false)
	 public void delete(Story arg0);
	 
}
