module Login_Admin
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
      # require  'csv-import'

      def incorrect_login
        @browser.text_field(:id => 'username').set("testmanager25")
        @browser.text_field(:id => 'password').set ("9")
        @browser.button(:id => 'login-submit').click
      end
      def verify_incorrect_login
        @browser.text.include?("Invalid username or password.")== true ?  (puts "Incorrect Login Test Passed") :(puts "Incorrect login test failed")
      end

      def visit_grm
        @browser = Watir::Browser.new :chrome
        @browser.driver.manage.window.maximize
        @browser.goto 'https://cct-152-test.lvs.co.uk:9443/argus/'
        @browser.cookies.clear
      end
      def login_grm
        #@browser.set_fast_speed # only works when using Internet Explorer
          @browser.text_field(:id => 'username').when_present.set("testmanager10")
          @browser.text_field(:id => 'password').when_present.set ("c12345678")
          @browser.button(:id => 'login-submit').when_present.click
        if
           @browser.text.include? "ABP Login"
          $log.info 'Login Unsuccessful, trying again....in 4 secs...'
          sleep (4)
          @browser.text_field(:id => 'username').when_present.set("testmanager10")
          @browser.text_field(:id => 'password').when_present.set ("c12345678")
          @browser.button(:id => 'login-submit').when_present.click
        else
          $log.info 'Login Successful'
          sleep(7)

        end
        puts @browser.text.include? ("Couldn't load risk data : undefined Show technical details") #? (puts "Cannot Load Page")#,@browser.close #: (puts "we are all good to go")
      end

def login_proper
  @browser.text_field(:id => 'username').when_present.set("testmanager10")
  sleep(1)
  @browser.text_field(:id => 'password').when_present.set ("c12345678")
  sleep(1)
  @browser.button(:id => 'login-submit').click
  if @browser.text.include?("Login suspended")
    puts "The test account has been suspended. Please unlock the account using toolbar and restart this test"
    @browser.close
  end



end
      def open_browser_for_wagertracker
        @browser = Watir::Browser.new :chrome
        @browser.driver.manage.window.maximize
        @browser.goto 'https://cct-152-test.lvs.co.uk:9443/argus/instantaction/'
      end

      def login_for_olympus
        @browser = Watir::Browser.new :chrome
        @browser.driver.manage.window.maximize
        @browser.goto 'https://CCT-152-TEST.lvs.co.uk:8443/abp/olympus2/'
        @browser.text_field(:id => 'username').when_present.set('testmanager10')
        @browser.text_field(:id => 'password').when_present.set ('c123456')
        @browser.button(:id => 'login-submit').when_present.click
        sleep (1)
      end


      def test_IE
        @browser = Watir::Browser.new :ie
        @browser.goto 'https://CCT-152-TEST.lvs.co.uk:8443/abp/olympus2/'
        @browser.img(:src => 'red_shield.png').present? ;@browser.img(:src => 'red_shield.png').click
        if
        @browser.text.include?(' You are using and unsupported browser. Please use a version of Chrome')
          puts ' The Test for Firefox has passed , closing the browser now. Test passed'
          @browser.close
        else
          puts 'This is not a supported browser!! Test has failed '.colorize(:red)
          @browser.close
        end
      end

      def test_browser_ff
        @browser = Watir::Browser.new
        @browser.goto 'https://CCT-152-TEST.lvs.co.uk:8443/abp/olympus2/'
        if @browser.text.include? 'You are using and unsupported browser. Please use a version of Chrome'
          puts ' The Test for Firefox has passed , closing the browser now. Test passed'
          @browser.close
        else
          puts 'This is not a supported browser!! Test has failed '.colorize(:red)
          @browser.close
        end
      end

      def close_browser
        @browser.close
      end


      def responding  #TODO
        @browser.text.include?'Invalid username or password.' or @browser.text.include?'{ "errors" : [ { "code" : null, "message" : "20902 - The status (4) of the specified account (ID: 2266) does not allow login.", "field" : null, "actionType" : null } ] }'
      end

      def login_with_data
        filename = "data.csv"
        filesize = filename.size
        puts filesize
        CSV.foreach(filename, :headers => true) do |row|
          num =row.field(0)
          pass =row.field(1)
          @browser.text_field(:id => 'username').when_present.set("#{num}")
          @browser.text_field(:id => 'password').when_present.set ("#{pass}")
          @browser.button(:id => 'login-submit').when_present.click
          sleep (1)
          if  not responding
             @browser.element(:xpath, "//nav[@id='header']/ul/li[2]/a/i").when_present.click
             @browser.element(:id => 'logout').wait_until_present
             @browser.element(:id => 'logout').click
          #@browser.element(:css => '#action-menu > li:nth-child(1) > a').click
        end
          begin
          rescue Watir::Exception::NavigationException => e #catch the Exception
          puts "Page did not load: #{e}"
            end
        end
      end

      def check_time_zones_1
        @browser.li(id: 'timeZone').click
        CSV.foreach('./Zones.csv'=> true, :encoding => 'ISO-8859-1:UTF-8') do |row|
          num =row.field(0)
          time_zones.each do |num|
            end
              @browser.text_field(xpath:'/html/body/div[1]/div/div[1]/ul/li[16]/ul/div/div/div[3]/div/div/div/input').send_keys"#{num}"
              end
            end

      def goback
        @browser.goto 'https://cct-trunk-test.lvs.co.uk:8443/abp/olympus2/'
      end

      def logout_grm
        @browser.execute_script"$('#logout').trigger('click');"
      end

      def logout1
        @browser.button(:id => 'settingsBtn').click
        @browser.button(:id => 'settingsBtn' , :index  =>  -1).click
        sleep(5)
      end


      def check_site_availability
        @browser.close if @browser.text_field(:id => 'username').present? == false ; puts "Pages are not available . Please restart the test" || @browser.text.include?('This webpage is not available')
        @browser.close
      end


      def get_links
       puts @browser.links.each {|link| puts link.attribute_value("class") if link.visible?}
      end

      def change_lang  #This method iterates through list of languages in langs.list.csv. use when testing all languages
        file = "langs_list.csv"
        CSV.foreach(file, :headers => true) do |row|
          lang =row.field(0)
          @browser.button(:id => 'settingsBtn').click
          @browser.li(:class => 'dropdown-submenu').hover
          sleep(1)
          @browser.link(:id => ("#{lang}")).click
          end


        end

      def change_language  #use this method to test for single languages
        @browser.button(:id => 'settingsBtn').click
        @browser.ul(:id, "language-list").select_text("English")
        sleep(1)
        @browser.li(:class => 'dropdown-submenu').hover
        @browser.link(:text => /português/).present? ;@browser.link(:text => /português/).click
        sleep(2)

      end

      def page_performance
        puts 'Testing Page Performance*****'
        puts '************************************************'.colorize(:red)
        currentpage = @browser.url
        avarage_load_secs = (@browser.performance.summary[:response_time]/1000)/3  #ToDo summary :navigation :memory :timing
        3.times do
          @browser.goto currentpage
          @browser.performance.summary[:response_time]/1000
        end

      puts " this is  the average Load Time: #{avarage_load_secs} seconds."
      puts '******************************************************************'
      end

      ###############################################################################
      def get_version

        puts 'testing version ****    ' +  @browser.span(:id => 'infoVersion').text
        puts '*******************************************************************'.colorize(:red)
      end

      def error_message
        @browser.add_checker lambda { |browser| raise "Error!" if browser.text.include? "Error" }
     end


def misc_elle_neous
  while @browser.div(:class, 'containerDIV').a(:text, 'Add').exists? do
    @browser.div(:class, 'containerDIV').a(:text, 'Add').click
  end
end

end

