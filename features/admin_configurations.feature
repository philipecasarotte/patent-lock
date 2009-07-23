Feature: Site Configuration
  In order to change the configuration of the site
  As an admin user
  I want to be able to edit the site configuration

  Background:
    Given I am logged in as admin

  Scenario: Edit the Configuration
    Given the following configuration records
      | id | service_price | away_message | questionnaire_on_hold |
      | 1  | 140.00        | Comign soon. | 0                     |
    And I am on the admin edit configuration
    And I should see "140.00" 
    And I fill in "configuration_service_price" with "150.00"
    And I press "Save"
    Then I should see "Successfully updated!"
    And I should see "150.00" 
