package com.easyRest.service;

import org.springframework.data.domain.Sort;

import com.easyRest.exception.StoryNotFoundException;
import com.easyRest.model.Story;

/**
 * Declares methods used to obtain and modify developer information.
 * 
 */
public interface IStoryService {

    public Story create(Story created);


    /**
     * Gets the count of stories
     * @return
     */
    public long count();

    /**
     * Updates the information of a developer.
     * @param updated   The information of the updated story.
     * @return  The updated story.
     * @throws StoryNotFoundException  if no story is found with given id.
     */
    public Story update(Story updated) throws StoryNotFoundException;

    public Story findById(Long id) throws StoryNotFoundException;
    
    public Iterable<Story> findAll(Sort sort);
    
}
