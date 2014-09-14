package com.easyRest.controller;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.easyRest.service.IPlanService;

@Controller
public class PlanController extends AbstractController {
    
    private static final Logger LOGGER = LoggerFactory.getLogger(PlanController.class);
    
    protected static final String PLAN_VIEW = "plan/view";
    
    @Resource
    private IPlanService planService;
 
    @RequestMapping(value = "story/plan.htm", method = RequestMethod.GET)
    public String plan() {
    	LOGGER.info("PLANNING....");
        planService.plan();
        return PLAN_VIEW;
    }

 }