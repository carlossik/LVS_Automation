$LOAD_PATH << '.'

require 'rubygems'
require 'watir-webdriver'
require 'page-object'
#require 'ffi'
require 'colorize'
require 'open-uri'
require 'nokogiri'
require 'capybara'
require 'capybara/dsl'
require 'csv'
#require 'phantomjs'
require'watir-webdriver/elements/image'
require 'watir-webdriver-performance'
require 'GRM_Keyboard_Shortcuts'
include Grm_Shortcuts



def right_click_grids
  @browser.execute_script("$('#modal').find('tr.gameline .marketheader.family-moneyline').eq(random).trigger('click');")
   sleep(5)
end

def exposure_chart

end

def exposure_report

end

def decision_report

end

def line_history

end

def view_wagers
#@browser.span(:class => 'event-title', :text => "CarlosCustomEvent-(Arsenal vs Singapore select 11)").right_click
@browser.span(:class => 'risk' , :text => '85659').right_click
if
 @browser.img(:src => "img/icons/chart.png").present?
  puts 'located the trading reports menu'
else
  puts 'cannot find the trading reports...ending test'
  sleep(5)
  @browser.quit
  end

@browser.element(:text => 'Trading Reports').click
@browser.element(:text => 'View Wagers (Event)').click
end

def performance_test
  @browser.execute_script("var performance = window.performance || window.webkitPerformance || window.mozPerformance window.msPerformance || {};
var timings = performance.timing || {};
return timings;")

end