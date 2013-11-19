
Feature: Manage global page permissions
  As an administrator
  I want to manage view and edit permission defaults on pages
  In order to set good defaults and avoid repeating myself on each page

Background: 
  Given a "page" "Home" with "Content"="Page 1"  
  And a "group" "AUTHOR" has permissions "Access to all CMS sections" and "View any page" and "Edit any page"
  And I am logged in with "ADMIN" permissions
  And I have the user "AUTHOR"
  And I go to "/admin/settings"
  And I wait for 10 seconds
  And I click the "Access" CMS tab

@todo
Scenario: I can open global view permissions to everyone
  Given I select "Anyone" from "Who can view pages on this site?" radio group
  And I press the "Save" button
  When I am not logged in the CMS
  And I am on the homepage
  Then I should not see a log-in form 
  And I should see "Page 1"

@todo
Scenario: I can limit global view permissions to logged-in users
  Given I select "Logged-in users" from "Who can view pages on this site?" radio group
  And I press the "Save" button
  When I am not logged in the CMS
  And I am on the homepage
  Then I should see a log-in form
  When I am logged in with "AUTHOR" permissions
  Then I should not see a log-in form 
  And I should see "Page 1"

@todo
Scenario: I can limit global view permissions to certain groups
  Given I select "Only these people (choose from list)" from "Who can view pages on this site?" radio group
  And I select "Administrators" from "Viewer Groups"
  And I press the "Save" button
  When I am not logged in the CMS
  And I am on the homepage
  Then I should see a log-in form
  When I am log in with "AUTHOR@example.org" and "secret" 
  And I am not logged in the CMS
  Then I should see a log-in form
  When I am logged in with "ADMIN" permissions
  And I am on the homepage
  Then I should see "Page 1"


Scenario: I can limit global edit permissions to logged-in users
  Given I select "Anyone who can log-in to the CMS" from "Who can edit pages on this site?" radio group
  And I press the "Save" button
  Then pages should be editable by "AUTHOR"
  #And pages should be editable by "AUTHOR"

@todo
Scenario: I can limit global edit permissions to certain groups
  Given I select "Only these people (choose from list)" in 'Who can edit pages on this site?'
  And I select "Administrators" in the "Editor Groups" dropdown
  And press the 'Save' button
  Then pages should not be editable by "Content Authors"
  But pages should be editable by "Administrators"

   