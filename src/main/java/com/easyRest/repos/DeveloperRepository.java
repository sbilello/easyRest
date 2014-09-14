package com.easyRest.repos;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.easyRest.model.Developer;

@RepositoryRestResource(path="developer")
public interface DeveloperRepository extends PagingAndSortingRepository<Developer, Long> {
	static final String QUERY = "select d from Developer d"
		       + " where LOWER (d.name) like CONCAT('%',CONCAT(LOWER(:name),'%')) ";
	@Query(QUERY)
	public List<Developer> findByNameContains(@Param("name") String name);
}
