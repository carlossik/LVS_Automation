module WagerTracker

#Automating  the wager tracker tool
$LOAD_PATH << '.'
#require './zones'
#require './page1'
#require 'net/http'
require 'rubygems'
require 'watir-webdriver'
require 'page-object'
#require 'ffi'
require 'colorize'
require 'open-uri'
require 'nokogiri'
#require 'capybara'
#require 'capybara/dsl'
require 'csv'
#require 'phantomjs'
require'watir-webdriver/elements/image'
require 'watir-webdriver-performance'
# require  'csv-import'




def verify_correct_site
  if
  @browser.text.include?('Global Instant Action')
    puts "We are on the correct page"
  else
    puts "We are not on the correct site"
end

def navigate_to_wager_limits
@browser.img(src: '_img/app_icons/wager-limits.svg').click
end

def navigate_to_wager_tracker
  @browser = Watir::Browser.new :chrome
  @browser.driver.manage.window.maximize
  @browser.goto 'https://CCT-152-TEST.lvs.co.uk:9443/argus/instantaction/'
end

def login
  @browser.text_field(:id => 'username').when_present.set('testmanager10')
  @browser.text_field(:id => 'password').when_present.set ('c123456')
  @browser.button(:id => 'login-submit').when_present.click
  sleep (1)
end

def validate_buttons
  @browser.button(:id => 'sidebar-toggle' ).present? == true ;puts "Save button is present"
  @browser.button(:id => 'cancel-filters' ).present? == true ;puts "Cancell button is present"
  @browser.button(:id => 'remove-filters' ).present? == true ;puts "Remove Filters button is present"
  @browser.button(:class => 'btn btn-default new-window-button' ).present? == true ;puts "Plus button is present"
  @browser.button(:class => 'btn btn-default dropdown-toggle' ).present? == true ;puts "new window dropdown button is present"
end

def close_browser
  @browser.close
end

def logout
 @browser.element(:text => "Logout").when_present.click  #Todo need to change xpath in the future
 @browser.element(:id => 'logout').click
end

def check_settings
puts 'Spoke is present' if  @browser.li(:id => 'spoke').present?
puts'Origin is present' if @browser.li(:id => 'origin').present?
puts 'Channel is present' if @browser.li(:id => 'channel').present?
puts 'Event is present' if @browser.li(:id => 'event').present?
puts 'Eventpath is present' if @browser.li(:id => 'eventPath').present?
puts 'Bet type is present' if @browser.li(:id => 'betType').present?
puts 'book type is present' if @browser.li(:id => 'bookType').present?
puts 'Player profile group is present' if @browser.li(:id => 'playerProfileGroup').present?
end

def verify_defaults
spoke_present =  @browser.element(:id => 'spoke', :class => 'filter')
if
  spoke_present.present? == true

  @browser.element(:xpath => '/html/body/div[1]/div/div[1]/ul/li[1]/span').click
  end
  if
   @browser.checkbox(:value => '').set? == true
    puts ' "Show all spokes" has been checked by default'
  end
origin = @browser.element(:id => 'origin' ,:class => 'filter')

  if origin.present? == true
    origin.click
   if @browser.checkbox(:value => '').set? == true
     puts 'Origin is checked by default'
   end
  end
end

def check_currency
     @browser.span(text: 'Currency').click
    system_base_currency = @browser.radio(:value  => '0')
    wager_currency = @browser.radio(:value => '1')
    puts 'the default base currency is checked' if  system_base_currency.set? == true
    puts 'the wager currency is not checked' if wager_currency.set? == false
end

def check_market_type_group
  @browser.li(:id => 'marketTypeGroup').click
 puts @browser.checkbox(:xpath => '//*[@id="marketTypeGroup"]/ul/div[1]/label/input').text
      #@browser.execute_script("$('.show-all:contains('Show All Market Type Groups')'")
     #checked = @browser.checkbox(:text => 'Show All Market Type Groups', :value => 'checked').set?
      #checked == true  ? ( puts " Market type group is checked by default" ):( puts " Show all market groups is not checked by default")
end

def change_wager_limit1
  actionlist =  ['Refer on Stake','Refer on Liability','Reject on 1 Fail','Reject on 2 Fail','Reject on Stake','Reject on Liability']
  values = ['5000','78000','99000','777777']
  values1 = ['300','500','700','900']
  default_table =  @browser.table(:xpath, '//*[@id="table-1"]').exists?   #=> Finds table with id 'tables_id'
  default_row = @browser.text_field(:id, '1-1-1-maxStake').present?       #=> Finds first table
  to_win = @browser.text_field(:id, '1-1-1-maxLiability').present?
  valuessize = values.size
  valuessize2 = values1.size
  action_list_size = actionlist.size
  #@browser.img(:src=> "_img/sports_icons/FOOT.png").click
  #@browser.li(:id => '2040260').click
  sleep(10)
  while default_row  && to_win && default_table == true &&  valuessize > 0 && valuessize2 > 0
    values.each do |values|
      values1.each do |values1|
        actionlist.each do |actionlist|
          @browser.text_field(:id, '1-1-1-maxStake').set"#{values1}"
          @browser.text_field(:id, '1-1-1-maxLiability').set"#{values}"
          @browser.select_list(:id => '1-1-1-action').when_present.select"#{actionlist}"
          @browser.windows.first.use do @browser.button(id: 'wager-limits-save-all').click #saving the change
          @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
          sleep(2)

          valuessize -=1
          valuessize2 -=1
          action_list_size -=1
          end
        end
      end
    end
  end
  end




def check_wagers
  if  @browser.url.match(/&wager=4,3/)
    puts ' show failed bets and show all placed bets have been checked'
  else
    puts 'show failed bets and all placed bets have not been checked by default'
end



=begin if  @browser.element(:id => 'wager' ,:class => 'filter').present? == true
    puts "Wagers are present here lets do some work"

    @browser.span(:text=> 'Wager').click
    sleep(10)
    show_all_failed_bets =  @browser.checkbox(:value => '3').set(true)
    show_all_placed_bets =  @browser.checkbox(:value => '4').set(true)
    show_all_failed_bets && show_all_placed_bets ? (puts 'show all bets and show all placed bets have been checked by default') : (puts 'show all bets and show all placed bets have NOT been checked by default'.colorize :red)
         end
=end



def check_windows
  @browser.span(text: 'Window Name').click
  @browser.text_field(:css => '#windowName > ul > li > div > input' ).clear
  @browser.text_field(:css => '#windowName > ul > li > div > input' ).set("Carlos's  Automated Window")  #changing the window name
  @browser.button(:id => 'sidebar-toggle').click  #This saves the change
  @browser.refresh
  sleep(10)
  @browser.refresh
  puts  @browser.title
end

def check_price_format
  #@browser.button(:id => 'sidebar-toggle').click
 # @browser.element(text: 'Price Format').click
default_settings_correct = @browser.checkbox(value: '0').set?
  default_settings_correct == true ;puts'the default settings for the price format  are correct, test passed'
end
end
end

end