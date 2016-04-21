require './login_admin'
 Encoding
#most methods are located in login_admin.rb

module Utilities

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

  $log = Logger.new('./Logger.txt')

  def goto_utilities
    @browser = Watir::Browser.new :chrome
    @browser.driver.manage.window.maximize
    @browser.goto'https://cct-152-test.lvs.co.uk:8443/abp/olympus2/'
    sleep(2)
    login_proper
      utilities =  @browser.span(:text => 'Utilities').present?
    if utilities
      @browser.span(:text => 'Utilities').click
      sleep(3)
         end
  else
    @browser.refresh
    sleep(3)
    begin rescue

    end
  end


  def move_to_vigorish_tables
    @browser.img(:src => "_img/app_icons/utilities.svg").when_present.click
  end

def conditions_management
  #check_utilities
    # @browser.li(:id, 'namedspecialcreator').click puts 'successfully clicked named special creator'
       #@browser.li(:id, 'vigorishtables').present? #;@browser.li(:id, 'vigorishtables').click puts 'successfully cliked Vigorish tables'
     # @browser.li(:id, 'markettypedisplaygroups').present? #;  @browser.li(:id, 'markettypedisplaygroups').click puts 'successfully clicked market type display groups'
     #@browser.li(:id, 'betrestrictiongroups').present? #;  @browser.li(:id, 'betrestrictiongroups').click puts 'successfully clicked Bet restriction Groups'
     @browser.li(:id, 'markettypewagerlimitgroups').when_present.click#; @browser.li(:id, 'markettypewagerlimitgroups').click puts 'successfully clicked MArket type groups'
     @browser.li(:id, 'playerprofilegroups').when_present.click #;  @browser.li(:id, 'playerprofilegroups').click puts 'successfully clicked player profile flags'
     @browser.li(:id, 'playerprofileflags').when_present.click #;  @browser.li(:id, 'playerprofileflags').click puts 'successfully clicked player profile flags'
     @browser.li(:id, 'priceconversions').when_present.click #; @browser.li(:id, 'priceconversions').click puts 'successfully clicked Price Conversions'
     @browser.li(:id, 'vigorishgroups').when_present.click #; @browser.li(:id, 'vigorishgroups').click puts 'successfully clicked Vigorish groups'
     @browser.li(:id, 'wagerlimitlevels').when_present.click#; @browser.li(:id, 'wagerlimitlevels').click puts 'successfully clicked wager limits levels'
     @browser.li(:id, 'combinationpricereduction').when_present.click #; @browser.li(:id, 'combinationpricereduction').click puts 'successfully clicked combination P R'
end

  def test_vigorish
    @browser.li(:id, 'vigorishtables').click
    @browser.button(:id, 'add-btn').click
    @browser.text_field(:id, 'description-txt').set("Test Description")
   puts'i can see the allocation button ' if  @browser.button(:id => 'event-paths-btn').span(:class => 'btn btn-success btn-sm glyphicon-plus glyphicon').present? == true
    sleep (10)
   puts @browser.li(:id, '240').present?
    #@browser.select_list(:id, 'price-format-id-select').select_value('3')
    @browser.send_keys :enter
    #@browser.send_keys :enter
    puts @browser.button(:id,'event-paths-btn').present?
  end

def change_wager_limit
  puts @browser.uls(:class => 'root').length

  actionlist =  ['Refer on Stake','Refer on Liability','Reject on 1 Fail','Reject on 2 Fail','Reject on Stake','Reject on Liability']
  values = ['5000','78000','99000','777777']
  values1 = ['300','500','700','900']
  default_table =  @browser.table(:id, 'table-1').exists?   #=> Finds table with id 'tables_id'
  default_row = @browser.text_field(:id, '1-1-1-maxStake').present?       #=> Finds first table
  to_win = @browser.text_field(:id, '1-1-1-maxLiability').present?
  valuessize = values.size
  valuessize2 = values1.size
  action_list_size = actionlist.size

  @browser.img(:src=> "_img/sports_icons/FOOT.png").click
  @browser.li(:id => '2040260').click
  sleep(10)
  while default_row && default_table && to_win == true &&  valuessize > 0 && valuessize2 > 0
    values.each do |values|
      values1.each do |values1|
        actionlist.each do |actionlist| @browser.text_field(:id, '1-1-1-maxStake').set"#{values1}"
        @browser.text_field(:id, '1-1-1-maxLiability').set"#{values}"
        @browser.select_list(:id => '1-1-1-action').when_present.select"#{actionlist}"
        @browser.windows.first.use do @browser.button(id: 'wager-limits-save-all').click #saving the change
        @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
        sleep(2)
        end
        valuessize -=1
        valuessize2 -=1
        action_list_size -=1
        end
      end
    end
    sports = Array.new
    divs = @browser.uls(:class => 'root')
    divs.each do |div|
      sports << divs
      puts div.text
      puts sports.inspect
    end
    @browser.close
  end
  end

  def market_type_display_groups
    @browser.li(id: 'markettypedisplaygroups').when_present.click
    @browser.button(id:'market-types-display-groups-button').click
    @browser.execute_script("$('.mtdg-sport-list-item[data-sportcode=FOOT]').trigger('click');")
    @browser.button(id:"market-type-display-groups-add").when_present.click
    @browser.execute_script("$('.market-type-display-group-input:last').trigger('click');")
    @browser.execute_script("$('.market-type-display-group-input:last').val('Test auto8');")
    @browser.execute_script("$('.market-type-display-group-input:last').trigger(jQuery.Event('keyup'));")
    @browser.button(:id ,'market-type-display-groups-save-all').click
  end



def verify_duplicate_description
      @browser.text.include?('Could not save because the description (case sensitive) is a duplicate.')
      puts 'Test for duplicate Descriptions passed. A new Description is being created'
      @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
      while  @browser.text_field(:value => 'Test auto91').exist?
        @browser.text_field(:value => 'Test auto91').send_keys  [:control, 'a'], :backspace
      @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
      @browser.execute_script("$('.market-type-display-group-input:last').val('Test auto9'+2);")
      @browser.execute_script("$('.market-type-display-group-input:last').trigger(jQuery.Event('keyup'));")
      @browser.button(:id ,'market-type-display-groups-save-all').click
        end
  end
  def menu_page

    @browser.img(:src => '_img/app_icons/utilities.svg').present? == true ?  (puts "Utilities app is available!") : (puts " Utilities app is not there at all "  ;@browser.refresh )

    @browser.img(:src => '_img/app_icons/wager-limits.svg').present? == true ?  (puts "Wager Limits app is available!") : (puts " Wager Limits app is not there at all "  ;@browser.refresh )

    @browser.img(:src => '_img/app_icons/example.png').present? == true ?  (puts "The Example App is available!") : (puts " The Example App is not available "  ;@browser.refresh )
    @browser.img(:src => '_img/app_icons/bulk-update.svg').present? == true ? (puts "Bulk update is available !") : (puts "Bulk update is not available "  ;@browser.refresh)
    @browser.screenshot.save 'menupagepic.png'
  end
  def check_utilities #use this method to navigate to utilities page
    unless
    @browser.img(:src => '_img/app_icons/utilities.svg').present? == true ?  (@browser.img(:src => '_img/app_icons/utilities.svg').click) : (puts " Utilities app is not there at all ".colorize :red  ;@browser.refresh )
    end
    sleep(3)
    puts " We have successfully navigated to the Utilities page"
    #@browser.back
  end


  def check_wagerlimits
    @browser.img(:src => '_img/app_icons/wager-limits.svg').wait_until_present
    @browser.img(:src => '_img/app_icons/wager-limits.svg').click
    sleep(5)
    if @browser.text.include? 'Main book'
      puts 'This is working as expected'.colorize(:green)
    else
      puts ' This is not working at all'.colorize(:red)
    end
  end

  def test_tools
    puts 'Testing Test Tools*****'.colorize(:red)
    @browser.screenshot.save 'conditionsmanagement.png'
    while
    @browser.link(:id => 'Conditions Management').present? do @browser.link(:id => 'Conditions Management').click
    sleep(1)

    end
  end
end






