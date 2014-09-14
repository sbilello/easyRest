package com.easyRest.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;

import org.springframework.data.rest.core.annotation.RestResource;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@RestResource
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Bug implements Issue{
	
	@Id
	@SequenceGenerator(name="BUG_SEQ", sequenceName="BUG_SEQ")
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="BUG_SEQ")
	private Long issueId;
	
	private String description;
	private String title;
	private Date creationDate;
	
	// Critical, Major, Minor
	private String priority;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "FK_DEVELOPER", insertable = false, updatable = false)
	private Developer developer;
	
	@Column(name = "FK_DEVELOPER")
	private Integer developerId;
	
	// New, Verified, Resolved
	private String status;
	
	@Override
	public Date getCreationDate() {
		return creationDate;
	}

	@Override
	public String getDescription() {
		return description;
	}
	
	@Override
	public Developer getDeveloper() {
		return developer;
	}
	public Integer getDeveloperId() {
		return developerId;
	}
	
	@Override
	public Long getIssueId() {
		return issueId;
	}
	
	public String getPriority() {
		return priority;
	}
	
	@Override
	public String getStatus() {
		return status;
	}
	
	@Override
	public String getTitle() {
		return title;
	}
	
	@Override
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	
	@Override
	public void setDescription(String description) {
		this.description = description;
	}
	
	@Override
	public void setDeveloper(Developer developer) {
		this.developer = developer;
	}
	
	public void setDeveloperId(Integer developerId) {
		this.developerId = developerId;
	}
	
	@Override
	public void setIssueId(Long id) {
		this.issueId = id;
	}
	
	public void setPriority(String priority) {
		this.priority = priority;
	}
	
	@Override
	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public void setTitle(String title) {
		this.title=title;
	}
	
}