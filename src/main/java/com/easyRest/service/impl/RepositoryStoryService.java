package com.easyRest.service.impl;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.easyRest.exception.StoryNotFoundException;
import com.easyRest.model.Story;
import com.easyRest.repos.StoryRepository;
import com.easyRest.service.IStoryService;

/**
 * This implementation of the DeveloperService interface communicates with
 * the database by using a Spring Data JPA repository.
 * 
 */
@Service
public class RepositoryStoryService implements IStoryService {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(RepositoryStoryService.class);

    @Resource
    private StoryRepository storyRepository;

    @Transactional
    public long count() {
        return storyRepository.count();
    }
    
    @Override
    @Transactional
	public Story create(Story created) {
		LOGGER.debug("Creating a new story with information: " + created);
		return storyRepository.save(created);
	}
	
	@Override
	@Transactional
	public Story update(Story updated) {
		 LOGGER.debug("Updating story with information: " + updated);
		 return storyRepository.save(updated);
	}

	@Override
	@Transactional(readOnly = true)
	public Story findById(Long id) throws StoryNotFoundException{
		LOGGER.debug("Finding story by id: " + id);
		Story story = storyRepository.findOne(id);
		if (story == null)
			throw new StoryNotFoundException();
		return story;
	}
	
	@Override
	@Transactional(readOnly = true)
	public Iterable<Story> findAll(Sort sort) {
		return storyRepository.findAll(sort);
	}
}
