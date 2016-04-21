require './login_admin'
require 'webdriver-user-agent'
require 'webdriver-user-agent/browser_options'
require 'webdriver-user-agent/devices'
module GlobalRiskManager

  def user_agent
    driver = Webdriver::UserAgent.driver(:browser => :firefox, :agent => :iphone, :orientation => :landscape)
    @browser = Watir::Browser.new driver
    #@browser.driver.manage.window.maximize
    @browser.goto 'https://CCT-152-TEST.lvs.co.uk:8443/abp/olympus2/'
  end

def open_browser_for_grm
  #@browser = Watir::Browser.new :phantomjs # good if we wanted to test headless but application only supports chrome
  @browser = Watir::Browser.new :chrome
  @browser.driver.manage.window.maximize
  @browser.goto 'https://CCT-152-TEST.lvs.co.uk:9443/argus/'
  sleep(5)
      puts 'welcome to the GRM test'
  if
  @browser.text.include?('This webpage is not available')
    puts "There may be an upgrade goin on"
    @browser.close

    end
end



def change_dates
  #defining variables
  selector = @browser.button(:id , 'event-date-button')
  next_7_days =  @browser.element(:css ,'#event-date > li:nth-child(1) > a')
  today = @browser.element(:css ,'#event-date > li:nth-child(1) > a')
  tomorrow =  @browser.element(:css ,'#event-date > li:nth-child(3) > a')
  future =  @browser.element(:css ,'#event-date > li:nth-child(4) > a')
  yesterday =  @browser.element(:css ,'#event-date > li:nth-child(5) > a')
  historical =  @browser.element(:css ,'#event-date > li:nth-child(6) > a')
  wait = sleep(2)
  calendar = @browser.button(:id ,'event-date-button').present?

  #end defining variables
  puts 'calendar is present ' if  calendar
   wait
    selector.click
    next_7_days.click if next_7_days.present?
  @browser.refresh
  @browser.alert.ok
    wait
    selector.click
    wait
    today.click if today.present?
  @browser.refresh
  @browser.alert.ok
  wait
  selector.click
  wait
  tomorrow.click if tomorrow.present?
  wait
  @browser.refresh
  @browser.alert.ok
  wait
  selector.click
  wait
  future.click if future.present?
  wait
  @browser.refresh
  @browser.alert.ok
  wait
  selector.click
  wait
  yesterday.click if yesterday.present?
  wait
  @browser.refresh
  @browser.alert.ok
  wait
  selector.click
  wait
  historical.click if historical.present?
  wait
end

def execute_js
 @browser.execute_script("window.alert = function() {}")
end

def change_dates_to_today
  @browser.button(:id , 'event-date-button').click
  @browser.element(:css ,'#event-date > li:nth-child(1) > a').click
end
def pricing_markets
 @browser.execute_script("$(#outcome-21').find('.price').html()")                        #This method adds prices to markets in GRM
end

def change_mode
  @browser.refresh
  @browser.alert.ok
  selector = @browser.div(:css ,'#price-line-button')
  selector.present ? (selector.click) :(puts 'selector is not present' ;@browser.close)
end

def check_tabs
@browser.button(:id , 'event-date-button').present ?  (puts 'Date button is present') : (puts 'Date button not present')

@browser.button(:id , 'price-line-button').present ? ( puts 'Price Line button is present') : (puts 'Price Line button not present')

@browser.button(:id , 'risk-lines-button').present ? (puts 'risk-lines-button is present'):(puts 'risk-lines-button not present')

@browser.button(:id , 'layout-button').present ?  (puts 'layout-button is present ') : (puts 'layout-button not present')
search_field = @browser.text_field(:id ,'search')
search_field.set 'carlos' if search_field.present?

  @browser.send_keys :enter
    sleep(3)
  end

  def side_links
    sport_link_present = @browser.li(:id ,'facet_eventpath_sport').present?
    sportlink = @browser.li(:id ,'facet_eventpath_sport')
    sportlink.click if sport_link_present
sleep(20)
  end

  def verify_book_type
book_type = @browser.li(:id , 'booktype')
puts @browser.li(:id , 'booktype').exist?
end

  def deny_same_game
    yesterday =  @browser.element(:css ,'#event-date > li:nth-child(5) > a')

    if yesterday.present?
    yesterday.click
    else
      puts "This option is not available in the menu's"
      change_dates_to_today
      end
    @browser.text_field(:id , 'search').set  "Football"
    @browser.send_keys :enter
    sleep(20)
    puts  @browser.span(class: 'icon icon-dsg gradient-icon').present?
  end



def verify_search1

       search_item = ['carlos','Arsenal vs Sunderland','FV','Brazil','Kane','Italy','']
       #@search_item = search_item
       no_of_searches = search_item.count
       while no_of_searches > 0
       search_item.each do |search_item|
       @browser.text_field(:id , 'search').set"#{search_item}"
       @browser.send_keys :enter
       #sleep(2)
       search = @browser.text_field(:id ,'search').value.include?("#{search_item}")
       search ?  (puts "search for  : #{search_item} worked!!" ):(puts "search is not working for : #{search_item}!!".colorize :red)
       no_of_searches -= 1
     end
    end

end
end
