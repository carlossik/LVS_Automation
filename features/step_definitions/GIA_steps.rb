$LOAD_PATH << '.'

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
include CapybaraCode
include Utilities
include VerifySportDisplayed
include GlobalRiskManager
include Vigorish
include Grm_Shortcuts
include WagerTracker


Given(/^i have the correct login details$/) do
  @browser = Watir::Browser.new :chrome
  @browser.driver.manage.window.maximize
  @browser.goto 'https://CCT-152-TEST.lvs.co.uk:9443/argus/instantaction/'
end

Then(/^I should be able to navigate to GIA and login successfully$/) do
  @browser.text_field(:id => 'username').when_present.set('testmanager10')
  @browser.text_field(:id => 'password').when_present.set ('c12345678')
  @browser.button(:id => 'login-submit').when_present.click
  sleep (1)
end

Then(/^Then i should see Global Instant Action displayed$/) do
  if
  @browser.text.include?('Global Instant Action')
    puts "We are on the correct page"
  else
    puts "We are not on the correct site"
    end
end

Then(/^i should be able to logout successfully$/) do
  @browser.element(:text => "Logout").when_present.click  #Todo need to change xpath in the future
  @browser.element(:id => 'logout').click
end

Then(/^browser should be closed$/) do
@browser.close
end
