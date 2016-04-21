Feature: logging into GRM and checking stuff

  Background: User has successfully logged into the account


Scenario: verifying details of the tabs

Given i have successfully logged into the grm
  Then I should be able to check tabs


  Scenario: Logging into GRM with incorrect details

    Given I have incorrect details
    When i try to log into account with incorrect details
    Then An "Error Message " should be displayed"

    Scenario Outline: GRM search functionality to search for events

      Given a user needs to verify a "<Search_Item>"
      When i search for the "<Search_Item>"
      Then the event "<Details>" should be "Displayed" on the screen


    Examples:
      |Search_Item|Details|
      |Arsenal|Arsenal|
      |Kane|Kane|
      |Manchester City|Manchester City|
      |Brazil|Brazil|
      |Italy|Italy|
      |FV|FV|











