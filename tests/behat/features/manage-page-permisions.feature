
Feature: Manage global page permissions
As an administrator
I want to manage view and edit permission defaults on pages
In order to set good defaults and avoid repeating myself on each page

Background: 
	Given a "page" "Home" with "Content"="Page 1"  
	And a "group" "AUTHOR group" has permissions "Access to all CMS sections"
	And I am logged in with "ADMIN" permissions
	And I have the user "AUTHOR"
	And I go to "/admin/settings"
	And I click the "Access" CMS tab


Scenario: I can open global view permissions to everyone
	Given I select "Anyone" from "Who can view pages on this site?" radio group
	And I press the "Save" button
	When I am not logged in the CMS
	And I am on the homepage
	Then I should not see a log-in form 
	And I should see "Page 1"


Scenario: I can limit global view permissions to logged-in users
	Given I select "Logged-in users" from "Who can view pages on this site?" radio group
	And I press the "Save" button
	When I am not logged in the CMS
	And I am on the homepage
	Then I should see a log-in form
	When I am logged in with "AUTHOR" permissions
	Then I should not see a log-in form 
	And I should see "Page 1"


Scenario: I can limit global view permissions to certain groups
	Given I select "Only these people (choose from list)" from "Who can view pages on this site?" radio group
	And I select "ADMIN group" from "Viewer Groups"
	And I press the "Save" button
	When I am not logged in the CMS
	And I am on the homepage
	Then I should see a log-in form
	When I am logged in with "AUTHOR" permissions 	
	And I am not logged in the CMS
	Then I should see a log-in form
	When I am logged in with "ADMIN" permissions
	And I am on the homepage
	Then I should see "Page 1"


Scenario: I can limit global edit permissions to logged-in users
	Given I select "Anyone who can log-in to the CMS" from "Who can edit pages on this site?" radio group
	And I press the "Save" button
	Then pages should be editable by "ADMIN"
	And pages should be editable by "AUTHOR"
 
 Scenario: I can limit global edit permissions to certain groups
  Given I select "Only these people (choose from list)" from "Who can edit pages on this site?" radio group
  And I select "ADMIN group" from "Editor Groups"
  And I press the "Save" button
  Then pages should not be editable by "AUTHOR"
  But pages should be editable by "ADMIN"

