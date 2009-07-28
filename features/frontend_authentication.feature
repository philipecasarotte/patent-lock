Feature: Authentication
  In order to get access to the user account and protect from unauthorized access
  As an user
  I want to be able to sign in and sign out

    Scenario: User is not signed up
      Given no user exists with a login of "someuser"
      When I go to the login page
      And I sign in as "someuser/password"
      Then I should see "login is not valid"

   Scenario: User enters wrong password
      Given I signed up with "someuser/password"
      When I go to the login page
      And I sign in as "someuser/wrongpassword"
      Then I should see "password is not valid"
   
   Scenario: User signs in with valid login and password
      Given the following order records
        | user_id | total  | state           |
        | 1       | 150.00 | pending_answers |
      And the following user records
        | id | login     | email             | password | password_confirmation |
        | 1  | philipe   | bob@example.com   | secret   | secret                |
      And the following question records
        | name                  | help       |
        | What is your name?    | Question 1 |
        | What is your mission? | Question 2 |
      When I go to the login page
      And I sign in as "philipe/secret"
      Then I should see "Logged in successfully"
      
   Scenario: User signs out
      Given I am signed up with "someuser/secret" as "user"
      When I go to the login page
      And I sign in as "someuser/secret"
      And I sign out admin
      Then I should see "You have been logged out"