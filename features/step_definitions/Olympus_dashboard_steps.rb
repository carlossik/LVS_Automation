require './Global_risk_manager'
require'selenium-webdriver'
require 'logger'
require './login_admin'
require './utilities'
require './verify_sport_displayed'
require './WagerTracker'
require './Vigorish'
require 'capybaracode'
require 'watir-webdriver'
#require './test2'
require './GRM_Keyboard_Shortcuts'
require 'byebug'
require'./grmreports'
require 'capybara'
require 'capybara/cucumber'
include CapybaraCode
include Utilities
include VerifySportDisplayed
include GlobalRiskManager
include Vigorish
include Grm_Shortcuts

#@browser = Watir::Browser.new :chrome


Given(/^i am logged into Olympus successfully$/) do
navigate_to_wager_tracker
end

Given(/^I click on the <Utilities icon>$/) do
   check_utilities
end

Given(/^I navigate to the <settings> section$/) do
  verify_menus
end

And (/^I should be able to click Market Type Display Groups$/) do
  puts 'utilities'
end

And (/^I should be able to see Market Type Display Groups$/) do
  puts 'utilities'
end

And (/^I should be able to click Bet Restriction Groups$/) do
  puts 'utilities'
end

Given(/^I should be able to see Bet Restriction Groups$/) do
  puts 'utilities'
end

Given(/^I should be able to click Market Type Groups$/) do
  puts 'utilities'
end

And (/^I should be able to see Market Type Groups$/) do
  puts 'utilities'
end

And (/^I should be able to click Player Profile Groups$/) do
  puts 'utilities'
end

And(/^I should be able to see Player Profile Groups$/) do
  puts 'utilities'
end

And (/^I should be able to click Player Profile Flags$/) do
  puts 'utilities'
end

Then (/^I should be able to see Player Profile Flags$/) do
  puts 'utilities'
end

And(/^I should be able to click Price Conversions$/) do
  puts 'utilities'
end

Then (/^I should be able to see Price Conversions$/) do
  puts 'utilities'
end

Then (/^I should be able to click Vigorish Groups$/) do
  puts 'utilities'
end

Then (/^I should be able to see Vigorish Groups$/) do
  puts 'utilities'
end

And (/^I should be able to click Wager Limit Levels$/) do
  puts 'utilities'
end

And (/^I should be able to see Wager Limit Levels$/) do
  puts 'utilities'
end
