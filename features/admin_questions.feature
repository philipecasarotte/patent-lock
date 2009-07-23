Feature: Manage questions
  In order to get to know the ideas of patent applications
  As an admin user
  I want to be able to manage questions

  Background:
    Given I am logged in as admin
    
  Scenario: Questions list
    Given the following question records
      | name                  | help       |
      | What is your name?    | Question 1 |
      | What is your mission? | Question 2 |
    When I go to the admin list of questions
    Then I should see "What is your name?"
    And I should see "What is your mission?"

  Scenario: Create valid question
    Given I have no questions
    And I am on the admin list of questions
    When I follow "New Question"
    And I fill in "Name" with "What is the speed of a swallow carrying a coconut?"
    And I press "Create"
    Then I should see "Successfully created!"
    And I should see "What is the speed of a swallow carrying a coconut?"
    And I should have 1 question

  Scenario: Create invalid question
    Given I have no questions
    And I am on the admin list of questions
    When I follow "New Question"
    And I press "Create"
    Then I should see "Name can't be blank"
    And I should have 0 questions

  Scenario: Edit a Question
    Given the following question records
      | name                  | help       |
      | What is your name?    | Question 1 |
      | What is your mission? | Question 2 |
    And I am on the admin list of questions
    When I follow "Edit"
    And I fill in "Name" with "What is your favorite color?"
    And I press "Update"
    Then I should see "Successfully updated!"
    And I should see "What is your favorite color?"

  Scenario: Reorder Questions
    Given the following question records
      | name                  | help       |
      | What is your name?    | Question 1 |
      | What is your mission? | Question 2 |
    And I go to the admin list of questions
    When I follow "Reorder"
    Then I should see "What is your name?"
    And I should see "What is your mission?"
  
