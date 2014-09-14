package com.easyRest.model;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.springframework.data.rest.core.annotation.RestResource;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@Entity
@RestResource
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class Developer {
	
	@Id
	@SequenceGenerator(name="DEVELOPER_SEQ", sequenceName="DEVELOPER_SEQ")
    @GeneratedValue(strategy=GenerationType.SEQUENCE,generator="DEVELOPER_SEQ")
	private Long id;
	
	@NotNull
	@Size(min=2, max=30)
	private String name;
	
	@OneToMany(mappedBy="developer",cascade=CascadeType.ALL, fetch=FetchType.LAZY)
	private List<Story> stories = new ArrayList<Story>();
	
	@OneToMany(mappedBy="developer",cascade=CascadeType.ALL, fetch=FetchType.LAZY)
	private List<Bug> bugs = new ArrayList<Bug>();

	public List<Bug> getBugs() {
		return bugs;
	}

	public Long getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public List<Story> getStories() {
		return stories;
	}

	public void setBugs(List<Bug> bugs) {
		this.bugs = bugs;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setStories(List<Story> stories) {
		this.stories = stories;
	}
}