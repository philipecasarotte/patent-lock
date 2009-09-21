Feature: Questionnaire
  In order to get started on the process of patent registration
  As a user
  I want to answer questions about the patent and pay for the initial registration process
  
  Background:
    Given the following order records
      | user_id | total  | state           |
      | 1       | 150.00 | pending_answers |
    And the following configuration records
      | questionnaire_on_hold | service_price | away_message |
      | 0                     | 150.00        | We are off   |
    And the following user records
      | id | login     | email             | password | password_confirmation |
      | 1  | quentin   | bob@example.com   | secret   | secret                |
    And the following question records
      | name                  | help       | position |
      | What is your name?    | Question 1 |        1 |
      | What is your mission? | Question 2 |        2 |
    Given the following page records
      | name         | body          |
      | Member Login | Login body pa |
    And I go to the login page
    And I sign in as "quentin/secret"

  Scenario: Answer first question
    Given I have answered no questions
    When I fill in "answer[body]" with "Sir Arthur King of the Bretons"
    And I press "Save & Continue"
    Then I should see "What is your mission?"
  
  # Scenario: Answer all questions
  #   Given the following page records
  #     | name                | body                               |
  #     | Review your answers | Please review your answers below:  |
  #     | Terms of Service    | These are the terms of our service |
  #   And I have answered no questions
  #   When I fill in "answer[body]" with "Sir Galahad"
  #   And I press "Save & Continue"
  #   And I fill in "answer[body]" with "To seek the Holy Grail"
  #   And I press "Save & Continue"
  #   Then I should see "Yes I agree with the Terms above"
  # 
  # Scenario: Pay via Google Checkout
  #   Given the following page records
  #     | name                | body                               |
  #     | Review your answers | Please review your answers below:  |
  #     | Terms of Service    | These are the terms of our service |
  #   And the following configuration records
  #     | questionnaire_on_hold | service_price | away_message |
  #     | 0                     | 150.00        | We are off   |
  #   And I have answered no questions
  #   When I fill in "answer[body]" with "Sir Galahad"
  #   And I press "Save & Continue"
  #   And I fill in "answer[body]" with "To seek the Holy Grail"
  #   And I press "Save & Continue"
  #   And I check "Yes I agree with the Terms above"
  #   And I press "Save & Continue"
  #   Then I should see "Payment"
  #   And I should see "Please make the payment of"