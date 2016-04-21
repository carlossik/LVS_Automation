$LOAD_PATH << '.'

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
require './GRM_Keyboard_Shortcuts'
require 'byebug'
require'./grmreports'
require'capybara'
include CapybaraCode
include Utilities
include VerifySportDisplayed
include GlobalRiskManager
include Vigorish
include Grm_Shortcuts

Given(/^i have the correct login details and logged in$/) do

end

Then(/^i should see Utilities app displayed$/) do

end

Then(/^i should be able to check all tools under utilities$/) do

end

Then(/^i should be able to close the browser$/) do

end


