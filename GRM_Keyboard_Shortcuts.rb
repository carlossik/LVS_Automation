module Grm_Shortcuts

    require 'rubygems'
    require 'watir-webdriver'
    require 'page-object'
    require 'colorize'
    require 'open-uri'
    require 'nokogiri'
    require 'capybara'
    require 'capybara/dsl'
    require 'csv'
    require'watir-webdriver/elements/image'
    require 'watir-webdriver-performance'
    require './Global_risk_manager'
    require './login_admin'
    require './utilities'
    require 'logger'
    require 'colorize'
    require 'colorize/class_methods'

    def log_info
    @browser = Watir::Browser.new :chrome
    $log = Logger.new('./Logger.txt')
    #$log.info @browser.url
    $log.info @browser.status
   #$log.info @browser.url
    end

    $log = Logger.new('./Logger.txt')


  def select_event_in_grm
    #require './Global_risk_manager'
   # require './login_admin'
    #require './utilities'
    #require 'watir-webdriver/alert'
    #require'selenium-webdriver'
    #require 'watir-classic'
    #require 'watir-webdriver/browser'
    #require 'watir-classic/browser'
    visit_grm
    @browser.li(:id => 'facet-title').click
  end

def activate_grids
  @browser.img(:src, 'img/blank.png').when_present.click
end

 def alt_f6
   sleep(1)
   activate_grids
   @browser.send_keys [:alt,:f6]
   sleep(1)
   $log.info'Hide/Publish Outcomes  (ALT+F6) works perfectly. User can successfully hide/Publish outcomes'.colorize :green if @browser.text.include?('Are you sure you want to hide this outcome?')
   @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
 end

def ctrl_f6
  sleep(1)
  activate_grids
  @browser.send_keys [:control,:f6]
  sleep(1)
  $log.info'Hide Mainline markets shortcut (CTRL+F6) works perfectly. User can successfully hide mainline markets'.colorize :red if @browser.text.include?('Are you sure you want to Hide main line markets in this period ?')
  @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
end

def toggle_btn_publish_and_hiding_events
  sleep(1)
  activate_grids
  @browser.send_keys :f6
  sleep(1)
  $log.info'Hide/Unhide  all markets shortcut (F6) works perfectly. User can successfully toggle between hiding and unhiding markets' if @browser.text.include?('Are you sure you want to Hide all markets for this event ?')
  @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
end
    def shift_f6
      @browser.refresh
      @browser.alert.ok
      sleep(1)
      activate_grids
      @browser.send_keys [:shift ,:f6]
      sleep(1)
      # $log.info'Close all markets(F3) shortcut works perfectly. All Markets are now Closed' if @browser.text.include?('Are you sure you want to Close all markets in this event?')
      $log.info'Shift + F6 works ' if @browser.text.match('Are you sure you want to Hide this market ?')or ('Are you sure you want to Open this market ?')
      @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
    rescue
    end

def shift_A
    @browser.refresh
  @browser.alert.ok
  sleep(1)
  activate_grids
  @browser.send_keys [:shift ,'a']
  sleep(1)
  $log.info 'Shift A works ' if @browser.text.include?('Bet analysis')
end

def shift_C
  @browser.refresh
  @browser.alert.ok
  sleep(1)
  activate_grids
  @browser.send_keys [:shift ,'c']
  sleep(1)
  $log.info 'Shift +C works ' if @browser.text.include?('Outcome Wager Limits')
end

    def shift_D
      @browser.refresh
      @browser.alert.ok
      sleep(1)
      activate_grids
      @browser.send_keys [:shift ,'d']
      sleep(1)
      $log.info ' Deny Same Game Shift + D works ' if @browser.text.include?('Are you sure you want to deny same game for all periods for this event?')
      @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
    end

def shift_E
  @browser.refresh
  @browser.alert.ok
  sleep(1)
  activate_grids
  @browser.send_keys [:shift ,'e']
  sleep(4)
  $log.info ' Edit Market Dialogue,Shift + E works ' if @browser.text.include?('The ABP Toolbar is not responding')
  @browser.execute_script("$('#modal').find('button[type=button]').trigger('click');")
                                               "$('#logout').trigger('click');"
end

  def shift_H

end
    def shift_N

    end

    def shift_L
      @browser.refresh
      @browser.alert.ok
      sleep(1)
      activate_grids
      @browser.send_keys [:shift ,'l']
      sleep(4)
      $log.info ' Liability Indcators page,Shift + L works ' if @browser.text.include?('Liability Indicators')
      @browser.button(:id => 'liability-indicators-cancel').click
    end

    def shift_S
      @browser.refresh
      @browser.alert.ok
      sleep(1)
      activate_grids
      @browser.send_keys [:shift ,'s']
      sleep(4)
      $log.info ' Liability Indcators page,Shift + S works ' if @browser.text.include?('Are you sure you want to make all markets in this event Single Only?')
      @browser.execute_script("$('#modal').find('button[type=button]').trigger('click');")
      sleep(12)
      #activate_grids
      @browser.send_keys [:shift ,'s']
      sleep(4)
      $log.info ' Liability Indcators page,Shift + S works ' if @browser.text.include?('Are you sure you want to remove Singles Only for this event?')
      @browser.execute_script("$('#modal').find('button[type=button]').trigger('click');")
    end

    def shift_T

    end

  def open_all_markets_in_event
    sleep(1)
    activate_grids
    @browser.send_keys :f1
    sleep(1)
    $log.info'Open all markets shortcut (F1) works perfectly. All Markets are now open' if @browser.text.include?('Are you sure you want to Open all markets in this event?')
    @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
  end

def open_main_line_markets_only
  @browser.refresh
  @browser.alert.ok
  sleep(1)
  activate_grids
  @browser.send_keys [:f1]
  sleep(1)
  $log.info'Open All Main Lines shortcut (Control +F1) works perfectly. All Mainlines are now open' if @browser.text.include?('Are you sure you want to Open game line markets ?')
  @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
  rescue
end


def suspend_all_markets_in_event
  @browser.refresh
  @browser.alert.ok
  sleep(1)
  activate_grids
  #byebug
  @browser.send_keys :f2
  sleep(1)
  $log.info'Suspend all markets shortcut (F2) works perfectly. All Markets are now Suspended' if @browser.text.include?('Are you sure you want to Suspend all markets in this event?')
  @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
rescue
  end

def suspend_main_line_markets_only
  @browser.refresh
  @browser.alert.ok
  sleep(1)
  activate_grids
  #byebug
  @browser.send_keys [:control,:f2]
  sleep(1)
  $log.info'Suspend main line markets shortcut (Control +F2) works perfectly. All Markets are now Suspended' if @browser.text.include?('Are you sure you want to Suspend game line markets ?')
  @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
rescue
end

def close_all_markets_in_event
  @browser.refresh
  @browser.alert.ok
  sleep(1)
  activate_grids
  @browser.send_keys :f3
  sleep(1)
 # $log.info'Close all markets(F3) shortcut works perfectly. All Markets are now Closed' if @browser.text.include?('Are you sure you want to Close all markets in this event?')
  $log.info'Close all markets(F3)********** shortcut works perfectly. All Markets are now Closed' if @browser.text.match('Are you sure you want to Close all markets in this event?')
  @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
rescue
end

  def ctrl_f3
    @browser.refresh
    @browser.alert.ok
    sleep(1)
    activate_grids
    #byebug
    @browser.send_keys [:control,:f3]
    sleep(1)
    $log.info'Close Mainline markets (Control + F3) works perfectly. All Markets are now Suspended' if @browser.text.include?('Are you sure you want to Close game line markets ?')
    @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
  rescue
  end

def open_selected_market_only
  @browser.element(:xpath => '/html/body/div[1]/div/div[2]/div[1]/table/tbody[1]/tr[4]/td[7]').when_present.click
  @browser.send_keys [:shift,:f1]
rescue
end

def shift_key_open_market
  change_dates_to'date'
rescue
end

def change_dates_to(date)
  selector = @browser.button(:id , 'event-date-button')
  selector.when_present.click
  @browser.element(:css ,'#event-date > li:nth-child(5) > a').when_present.click
  @browser.window(:index => 0).use
  @browser.execute_script("$('#customDate').val('2015-12-31');")
  @browser.button(:text , 'Yes').when_present.click
rescue
end
end

def alt_f7
  @browser.refresh
  @browser.alert.ok
  sleep(1)
  activate_grids
  #byebug
  @browser.send_keys [:alt,:f7]
  sleep(1)
  @browser.table(:class => 'price-history-table').present? ?   ($log.info '(ALT+F7) works perfectly.User able to toggle between minimising and maximising details') : ($log.info 'Not working')
  @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
 end

  def change_market_status_batch_mode
    @browser.refresh
    @browser.alert.ok
    sleep(1)
    activate_grids
    #byebug
    @browser.send_keys [:f4]
    sleep(1)
    $log.info'Change Market status (F4) works perfectly. Market Status has been changed successfully' if @browser.text.include? 'Market state1 details'
    @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
    @browser.refresh
    @browser.alert.ok
  rescue
  end

  def toggle_between_priceline_groups
    @browser.refresh
    @browser.alert.ok
    sleep(1)
    activate_grids
    #byebug
   3.times do @browser.send_keys [:f8]
    sleep(1)
    $log.info'Toggling between groups (F8) works perfectly. Market Status has been changed successfully' if @browser.text.include? '$Public111' or '$Sharp333' or '$Betradar222'
    @browser.execute_script("$('#modal').find('button[type=submit]').trigger('click');")
   end


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
end
  end


