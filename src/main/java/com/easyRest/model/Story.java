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
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.Past;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

import com.easyRest.serializer.JsonDateSerializer;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

@Entity
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Story implements Issue {
	
	@Id
	@SequenceGenerator(name="STORY_SEQ", sequenceName="STORY_SEQ")
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="STORY_SEQ")
	private Long issueId;
	
	@Column(name="DESCRIPTION")
	@Size(min=2, max=1000)
	private String description;
	
	@Column(name="TITLE")
	@Size(min=2, max=150)
	private String title;
	
	@Column(name="CREATION_DATE")
	@DateTimeFormat(pattern = "MM/dd/yyyy")
	@Past
	private Date creationDate;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "FK_DEVELOPER", insertable = false, updatable = false)
	private Developer developer;
	
	@Column(name = "FK_DEVELOPER")
	private Integer developerId;
	
	@Column(name="WEEK")
	private Integer week;
	
	@Min(value=1) @Max(value=10)
	private Integer value;
	
	// New, Estimated, Completed
	private String status;
	
	@JsonSerialize(using=JsonDateSerializer.class)
	public Date getCreationDate() {
		return creationDate;
	}
	
	public String getDescription() {
		return description;
	}
	public Developer getDeveloper() {
		return developer;
	}
	public Integer getDeveloperId() {
		return developerId;
	}
	public Long getIssueId() {
		return issueId;
	}
	public String getStatus() {
		return status;
	}
	@Override
	public String getTitle() {
		return title;
	}
	public Integer getValue() {
		return value;
	}
	public Integer getWeek() {
		return week;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public void setDeveloper(Developer developer) {
		this.developer = developer;
	}
	public void setDeveloperId(Integer developerId) {
		this.developerId = developerId;
	}
	public void setIssueId(Long id) {
		this.issueId = id;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public void setTitle(String title) {
		this.title=title;
	}
	public void setValue(Integer value) {
		this.value = value;
	}
	public void setWeek(Integer week) {
		this.week = week;
	}
}
