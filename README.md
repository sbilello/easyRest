# CRUD Application Test #

[![Build Status](https://travis-ci.org/sbilello/easyRest.svg?branch=master)](https://travis-ci.org/sbilello/easyRest)

## Getting Started ##

The application uses the latest open-source libraries and projects:

    - JAVA 1.7
    - Apache Derby
    - Spring
    - Spring Data Rest
    - Hibernate
    - JSP
    - HTML5
    - Datatables (https://datatables.net/)
    - Jquery Datatables Groupin (http://jquery-datatables-row-grouping.googlecode.com/svn/trunk/index.html)
    - Custom Taglib
    - JQuery UI Bootstrap https://github.com/jquery-ui-bootstrap/jquery-ui-bootstrap
    - JQuery
    - Javascript Template https://github.com/blueimp/JavaScript-Templates
    - Bootstrap 3.1
    - Javascript

I applied the MVC Design Pattern.
Spring Data Rest allows to me to write less backend code to handle sorting, pagination and to provide a RESTful service and HATEOS.
I wanted to separate Bug and Story entities, but to display in a list ordered by creation date, it could be more easier using the same entity and adding a private attribute that specifies the  type: "Bug" or  "Story".
The algorithm for project plan, it's easy, but I should filter on status for Story. It's possible to do that by adding a new query that allows filtering on status.
I added a backend support for i18n.
I handled some common exceptions and validations.
I should improve error messages on AJAX call and clean the jsp from hard-coded values.
The jsp code should be less redundant, and I should add the decorator design pattern. "Sitemesh" could be an example. 
You can create the war project by typing:

`mvn package` 

It's also possible deploy on tomcat if you configure your tomcat-users.xml and maven settings.xml.

`mvn tomcat:deploy`

Welcome url:

`http://localhost:8080/easyRest`

The application uses H2 Database.  To populate the Developer table, you can use curl:

`curl http://localhost:8080/easyRest/rest/developer -d "{\"name\":\"John Smith\"}" -H "Content-Type: application/json"`

Also, `load_names.rb` file is provided, that will load the database with the contents of `names.txt`

If you deploy on tomcat add -Duser.language=NO in your tomcat launch configuration

