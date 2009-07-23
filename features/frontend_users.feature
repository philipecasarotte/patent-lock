Feature: Frontend users
  In order to control who has access to the my profile section
  As an user
  I want to be able to register, see and edit my profile
  
  Scenario: Register Valid User
    Given I have no users
    And I am on the register page
    And I fill in "Login" with "bob"
    And I fill in "Name" with "Bob"
    And I fill in "Password" with "secret"
    And I fill in "Password Confirmation" with "secret"
    And I fill in "Email" with "bob@example.com"
    And I press "Register"
    Then I should see "Successfully created!"
    And I should see "bob"
    And I should have 1 users
  
  Scenario: Register Invalid User
    Given I have no users
    And I am on the register page
    And I fill in "Name" with "Bob"
    And I fill in "Password" with "secret"
    And I fill in "Password Confirmation" with "secret"
    And I fill in "Email" with "bob@example.com"
    And I press "Register"
    Then I should see "Login is too short"
    And I should not see "bob"
    And I should have 0 user

  Scenario: View My Profile
    Given the following user records
      | id | login | email             | password | password_confirmation |
      | 1  | bob   | bob@example.com   | secret   | secret                |
      | 2  | phil  | admin@example.com | secret   | secret                |
    And I am logged in as user
    And I am on the user page
    Then I should see "Edit Profile"
    And I should see "Registered on"
    And I should see "user1"    

  Scenario: Edit My Profile
    Given the following user records
      | id | login | email             | password | password_confirmation |
      | 1  | bob   | bob@example.com   | secret   | secret                |
      | 2  | phil  | admin@example.com | secret   | secret                |
    And I am logged in as user
    And I am on the user page
    When I follow "Edit Profile"
    And I fill in "Name" with "Bob Martin"
    And I press "Update"
    Then I should see "Successfully updated!"
    And I should see "Bob Martin"