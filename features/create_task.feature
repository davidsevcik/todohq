@javascript
Feature: Create task
  As a signed in user
  I want to create a new task
  In order to not forget on important stuff

  Scenario: Success
    Given I am signed in
    And go on the Task list page
    When I fill in new-task-title field with My first task
    And submit the form
    Then I see My first task in task list
