require './Global_risk_manager'
require'selenium-webdriver'
require 'logger'
require './login_admin'
require './utilities'
require './verify_sport_displayed'
require './WagerTracker'
require './Vigorish'
require 'acpybaracode'
require 'watir-webdriver'
#require './test2'
require './GRM_Keyboard_Shortcuts'
require 'byebug'
require'./grmreports'
#require 'search_module'
require 'rubygems'
require 'watir-webdriver'
require 'page-object'
require 'ffi'
require 'colorize'
require 'open-uri'
require 'nokogiri'
require 'capybara'
require 'phantomjs'
require 'watir-webdriver/alert'
require'selenium-webdriver'
#include Search
include CapybaraCode
include Utilities
include VerifySportDisplayed
include GlobalRiskManager
include Vigorish
include Grm_Shortcuts

@browser = Watir::Browser.new :chrome



Given(/^i have successfully logged into the grm$/) do
  visit_grm
  login_grm
  change_dates_to_today
  end

Then(/^I should be able to check tabs$/) do
  open_selected_market_only
  open_main_line_markets_only
  open_all_markets_in_event
  suspend_all_markets_in_event
  close_all_markets_in_event
  close_browser
end

Given(/^I have incorrect details$/) do
visit_grm
end

When(/^i try to log into account with incorrect details$/) do
incorrect_login
end

Then(/^An "(.*?)" should be displayed"$/) do |error_message|
verify_incorrect_login
  close_browser
  #error_message.should equal?('Invalid username or password.')== true?
end

Given(/^a user needs to verify a "([^"]*)"$/) do |search_Item|
  puts search_Item
end

When(/^i search for the "([^"]*)"$/) do |search_Item|
  @browser.text_field(:id , 'search').set"#{search_item}"
  @browser.send_keys :enter
end

Then(/^the event "([^"]*)" should be "([^"]*)" on the screen$/) do |search_item|
  search = @browser.text_field(:id ,'search').value.include?("#{search_item}")
  search ?  (puts "search for  : #{search_item} worked!!" ):(puts "search is not working for : #{search_item}!!".colorize :red)
end


