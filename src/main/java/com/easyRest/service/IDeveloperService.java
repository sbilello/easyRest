package com.easyRest.service;

import com.easyRest.model.Developer;

/**
 * Declares methods used to obtain and modify developer information.
 * 
 */
public interface IDeveloperService {

    /**
     * Creates a new developer.
     * @param created   The information of the created developer.
     * @return  The created developer.
     */
    public Developer create(Developer created);


    /**
     * Gets the count of developers 
     * @return
     */
    public long count();

}
