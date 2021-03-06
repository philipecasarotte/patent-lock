Feature: Manage users
  In order to control who has access to the admin section
  As an admin user
  I want to be able to manage users and assign them roles

  Background:
    Given the following page records
      | name         | body          |
      | Member Login | Login body pa |
    And I am logged in as admin

  Scenario: Admin Users List
    Given the following user records
      | login | email             | password | password_confirmation |
      | bob   | bob@example.com   | secret   | secret                |
      | admin | admin@example.com | secret   | secret                |
    And the following role records
      | name  |
      | admin |
    And the user "bob" has no role
    And the user "admin" has a role "admin"
    When I go to the admin list of admin users
    Then I should see "admin"
    And I should see "admin@example.com"
    And I should not see "bob@example.com"

  Scenario: Regular Users List
    Given the following user records
      | login | email             | password | password_confirmation |
      | bob   | bob@example.com   | secret   | secret                |
      | admin | admin@example.com | secret   | secret                |
    And the following role records
      | name  |
      | admin |
    And the user "bob" has no role
    And the user "admin" has a role "admin"
    When I go to the admin list of users
    Then I should see "bob"
    And I should see "bob@example.com"
    And I should see "admin"
    And I should see "admin@example.com"

  Scenario: Create Valid User
    Given I have no users except for admin
    And the following role records
      | name  |
      | admin |
    And I am on the admin list of users
    When I follow "New User"
    And I fill in "Login" with "bob"
    And I fill in "Name" with "Bob"
    And I fill in "Password" with "secret"
    And I fill in "Password Confirmation" with "secret"
    And I fill in "Email" with "bob@example.com"
    And I check the role "Admin"
    And I press "Create"
    Then I should see "Successfully created!"
    And I should see "bob"
    And I should have 2 users

  Scenario: Create Invalid User
    Given I have no users except for admin
    And the following role records
      | name  |
      | admin |
    And I am on the admin list of users
    When I follow "New User"
    And I fill in "Name" with "Bob"
    And I fill in "Password" with "secret"
    And I fill in "Password Confirmation" with "secret"
    And I fill in "Email" with "bob@example.com"
    And I check the role "Admin"
    And I press "Create"
    Then I should see "Login is too short"
    And I should not see "bob"
    And I should have 1 user

  Scenario: Edit a User
    Given the following user records
      | login | email             | password | password_confirmation |
      | bob   | bob@example.com   | secret   | secret                |
      | admin | admin@example.com | secret   | secret                |
    And I am on the admin list of users
    When I follow "Edit"
    And I fill in "Name" with "Bob Martin"
    And I press "Update"
    Then I should see "Successfully updated!"
    And I should see "Bob Martin"
  
  Scenario: View User's Order
    Given the following user records
      | id | login | email             | password | password_confirmation |
      | 1  | bob   | bob@example.com   | secret   | secret                |
      | 2  | admin | admin@example.com | secret   | secret                |
    And the following order records
      | user_id | total  | state           |
      | 1       | 150.00 | pending_answers |
    And I am on the admin list of users
    When I follow "View Order"
    Then I should see "150.00"
    And I should see "Pending answers"