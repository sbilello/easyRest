package com.easyRest.controller;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.easyRest.model.Developer;
import com.easyRest.service.IDeveloperService;

/**
 * Developer Controller for creating 
 * It could be improved with other features like edit or delete
 * I managed the delete request by a REST call
 */
@Controller
public class DeveloperController extends AbstractController {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(DeveloperController.class);
    
    protected static final String FEEDBACK_MESSAGE_KEY_DEVELOPER_CREATED = "feedback.message.developer.created";

    protected static final String MODEL_ATTRIBUTE_DEVELOPER = "developer";
    
    protected static final String DEVELOPER_ADD_FORM_VIEW = "developer/create";
    
    @Resource
    private IDeveloperService developerService;

    /**
     * Processes create developer requests.
     * @param model
     * @return  The name of the create developer form view.
     */
    @RequestMapping(value = "developer/create.htm", method = RequestMethod.GET) 
    public String showCreateDeveloperForm(Model model) {
        LOGGER.debug("Rendering create developer form");
        model.addAttribute(MODEL_ATTRIBUTE_DEVELOPER, new Developer());
        return DEVELOPER_ADD_FORM_VIEW;
    }

    /**
     * Processes the submissions of create developer form.
     * @param created   The information of the created developers.
     * @param bindingResult
     * @param attributes
     * @return
     */
    @RequestMapping(value = "developer/create.htm", method = RequestMethod.POST)
    public String submitCreateDeveloperForm(@Valid @ModelAttribute(MODEL_ATTRIBUTE_DEVELOPER) Developer created, BindingResult bindingResult, RedirectAttributes attributes) {
        LOGGER.debug("Create developer form was submitted with information: " + created);

        if (bindingResult.hasErrors()) {
            return DEVELOPER_ADD_FORM_VIEW;
        }
                
        Developer developer = developerService.create(created);
        addFeedbackMessage(attributes, FEEDBACK_MESSAGE_KEY_DEVELOPER_CREATED, developer.getName());
        return createRedirectViewPath("/developer/create.htm");
    }
}