@javascript
Feature: Sign in
  As a registered user
  I want to sign in
  In order to get access to my todo list


  Scenario: Success
    Given I am registered with email joe@doe.com and password 123456
    And go on the Sign in page
    When I fill in Email field with joe@doe.com
    And fill in Password field with 123456
    And submit the form
    Then I am on the Task list page


  Scenario: Fail - wrong Password
    Given I am registered with email joe@doe.com and password 123456
    And go on the Sign in page
    When I fill in Email field with joe@doe.com
    And fill in Password field with 789
    And submit the form
    Then I stay on the Sign in page
    And see a validation error
