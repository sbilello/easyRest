package com.easyRest.controller;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.easyRest.exception.StoryNotFoundException;
import com.easyRest.model.Story;
import com.easyRest.service.IStoryService;

/**
 * It could be improved with other features like edit or delete
 * I managed the delete request by a REST call
 */
@Controller
public class StoryController extends AbstractController {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(StoryController.class);
    
    protected static final String ERROR_MESSAGE_KEY_EDITED_STORY_WAS_NOT_FOUND = "error.message.edited.not.found";
    
    protected static final String FEEDBACK_MESSAGE_KEY_STORY_CREATED = "feedback.message.story.created";
    protected static final String FEEDBACK_MESSAGE_KEY_STORY_EDITED = "feedback.message.story.edited";
    
    protected static final String MODEL_ATTRIBUTE_STORY = "story";
    protected static final String MODEL_ATTRIBUTE_STORY_STATUS = "status";
    
    // It should be provided by properties or database for i18n
    protected static final String[] MODEL_STORY_STATUS = {"New","Estimated","Completed"};
    
    protected static final String STORY_ADD_FORM_VIEW = "issue/story/create";
    protected static final String STORY_EDIT_FORM_VIEW = "issue/story/edit";
    
    protected static final String REQUEST_MAPPING_LIST = "/";
    
    @Resource
    private IStoryService storyService;
    
    /**
     * Processes create story requests.
     * @param model
     * @return  The name of the create story form view.
     */
    @RequestMapping(value = "story/create.htm", method = RequestMethod.GET) 
    public String showCreateDeveloperForm(Model model) {
        LOGGER.debug("Rendering create story form");
        Story story = new Story();
        model.addAttribute(MODEL_ATTRIBUTE_STORY, story);
        model.addAttribute(MODEL_ATTRIBUTE_STORY_STATUS, MODEL_STORY_STATUS);
        return STORY_ADD_FORM_VIEW;
    }

    /**
     * Processes the submissions of create story form.
     * @param created   The information of the created storys.
     * @param bindingResult
     * @param attributes
     * @return
     */
    @RequestMapping(value = "story/create.htm", method = RequestMethod.POST)
    public String submitCreateDeveloperForm(@Valid @ModelAttribute(MODEL_ATTRIBUTE_STORY) Story created, BindingResult bindingResult, RedirectAttributes attributes, Model model) {
        LOGGER.debug("Create story form was submitted with information: " + created);

        if (bindingResult.hasErrors()) {
        	model.addAttribute(MODEL_ATTRIBUTE_STORY_STATUS, MODEL_STORY_STATUS);
            return STORY_ADD_FORM_VIEW;
        }
                
        Story story = storyService.create(created);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_STORY_CREATED, story.getTitle());
        return createRedirectViewPath("/story/create.htm");
    }
   
    /**
     * Processes edit story requests.
     * @param id    The id of the edited story.
     * @param model
     * @param attributes
     * @return  The name of the edit story form view.
     * @throws StoryNotFoundException 
     */
    @RequestMapping(value = "/story/{id}/edit.htm", method = RequestMethod.GET)
    public String showEditDeveloperForm(@PathVariable("id") Long id, Model model, RedirectAttributes attributes) throws StoryNotFoundException {
        LOGGER.debug("Rendering edit story form for story with id: " + id);
        
        Story story = storyService.findById(id);
        if (story == null) {
            LOGGER.debug("No story found with id: " + id);
            model.addAttribute(MODEL_ATTRIBUTE_STORY_STATUS, MODEL_STORY_STATUS);
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_STORY_WAS_NOT_FOUND);
            return createRedirectViewPath("/story/create.htm");            
        }
        model.addAttribute(MODEL_ATTRIBUTE_STORY_STATUS, MODEL_STORY_STATUS);
        model.addAttribute(MODEL_ATTRIBUTE_STORY, story);
        
        return STORY_EDIT_FORM_VIEW;
    }

    /**
     * Processes the submissions of edit story form.
     * @param updated   The information of the edited story.
     * @param bindingResult
     * @param attributes
     * @return redirect to create view
     */
    @RequestMapping(value = "/story/edit.htm", method = RequestMethod.POST)
    public String submitEditDeveloperForm(@Valid @ModelAttribute(MODEL_ATTRIBUTE_STORY) Story updated, BindingResult bindingResult, RedirectAttributes attributes, Model model) {
        LOGGER.debug("Edit story form was submitted with information: " + updated);
        
        if (bindingResult.hasErrors()) {
            LOGGER.debug("Edit story form contains validation errors. Rendering form view.");
            model.addAttribute(MODEL_ATTRIBUTE_STORY_STATUS, MODEL_STORY_STATUS);
            return STORY_EDIT_FORM_VIEW;
        }
        
        try {
            Story story = storyService.update(updated);
            addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_STORY_EDITED, story.getTitle());
        } catch (StoryNotFoundException e) {
            LOGGER.debug("No story was found with id: " + updated.getIssueId());
            addErrorMessage(attributes, ERROR_MESSAGE_KEY_EDITED_STORY_WAS_NOT_FOUND);
        }
        
        return createRedirectViewPath("/story/create.htm");
    }
   
    
    @ExceptionHandler({ StoryNotFoundException.class})
    public ModelAndView handleException(Exception ex) {
    	ModelAndView mav = new ModelAndView("error");
        mav.addObject("name", ex.getClass().getSimpleName());
        mav.addObject("message", ex.getMessage());
        return mav;
    }
}
