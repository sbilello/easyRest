package com.easyRest.model;

import java.util.Date;

public interface Issue {
	public Developer getDeveloper();
	public Long getIssueId();
	public String getStatus();
	public String getTitle();
	public String getDescription();
	public Date getCreationDate();
	public void setDeveloper(Developer developer);
	public void setIssueId(Long id);
	public void setStatus(String status);
	public void setTitle(String title);
	public void setDescription(String description);
	public void setCreationDate(Date date);
}
