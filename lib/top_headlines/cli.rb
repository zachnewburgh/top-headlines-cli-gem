class TopHeadlines::CLI

  def call
    system "clear"
    welcome_banner
    news_sources
    menu
    goodbye
  end

  def menu
    puts "Which source do you want to view? Alternatively, type 'all' to view all headlines or 'exit' to exit!"
    print "YOUR SELECTION: "
    @input = nil
    while @input != "EXIT" && @num != "EXIT"
      @input = gets.strip.upcase 
      if @input == "ALL"
        system "clear"
        list_all_headlines_banner
        list_all_headlines
        puts request_input_full_menu
        print "YOUR SELECTION: "
      elsif @input == "SOURCES"
        news_sources_banner
        news_sources
        puts request_input_full_menu
        print "YOUR SELECTION: "
      elsif TopHeadlines::Source.all.keys.include?(@input)
        system "clear"
        list_headlines_from_source
        open_headline_in_browser
      elsif @input != "EXIT"
        invalid_entry
      else
        nil
      end
    end
  end

  def time
    puts "Reporting live as of #{Time.now.strftime("%l:%M %p %Z on %a, %b #{Time.now.strftime("%e").to_i.ordinalize}, %Y")}:"
    puts "\n"
  end

  def list_headlines_from_source
    puts "\n*** #{@input} ***"
    time
    TopHeadlines::Source.scrape_headlines(@input)[0,5].each_with_index {|headline, index| puts "#{index + 1}. #{headline}"}
    puts "\n"
  end

  def open_headline_in_browser
    puts "Select article number to open."
    print "YOUR SELECTION: "
    @num = gets.strip.upcase
      while @num.to_i.between?(1,5)
        headline = TopHeadlines::Source.scrape_headlines(@input)[@num.to_i-1]
        puts "\nYou selected the #{@num.to_i.ordinalize} headline: '#{headline}'."
        puts "Opening..."

        sleep(2)
        url = TopHeadlines::Source.scrape_urls(@input)[@num.to_i-1]
        system("open", url)

        sleep(1)
        puts "\nSelect another article number to open."
        print "YOUR SELECTION: "
        @num = gets.strip.upcase
      end
    invalid_entry if @num != "EXIT"
  end

  def request_input_full_menu
    "Select a source, type 'sources' to view sources, type 'all' to view all headlines, or type 'exit' to exit."
  end

  def invalid_entry
    puts "\nINVALID: #{request_input_full_menu.downcase}"
    sleep(1)
    news_sources_banner
    news_sources
    print "YOUR SELECTION: "
  end

  def welcome_banner
    puts " --------------------------- "
    puts "| WELCOME TO TOP HEADLINES! |"
    puts " --------------------------- "
    time
  end

  def list_all_headlines_banner
    puts " -------------------------------"
    puts "| TOP HEADLINES & BREAKING NEWS |"
    puts " -------------------------------"
    time
  end

  def list_all_headlines
    TopHeadlines::Source.list_all_headlines
  end

  def news_sources_banner
    puts "\n"
    puts "NEWS SOURCES"
    puts "------------"
  end

  def news_sources
    TopHeadlines::Source.all.keys.sort.each {|source| puts "*** #{source} ***"}
    puts "\n"
  end

  def goodbye
    system "clear"
    puts "\nThanks for visiting – see you next time!"

    puts <<-DOC
              

          ```-.                                   
        `.-:::-           ````````                
      `.-:::::---.    `..----------..`            
       -:::::::-`   `.-----------------.          
       `-::::::`  `.---------------------`        
        `-:::--  `------/o:------:o/------`       
           ..    -------+o/------:o+-------`      
           `..` `--------------------------.      
             `..---------------------------.      
                `--------------------------.      
                 .-----:yo:------:oy:------       
                 `.------+yyooooyyo:------`       
                   .--------::/:--------.         
                    `.----------------.`          
                       ``..------...`                                                                    


    Image: VectorStock (https://www.vectorstock.com/royalty-free-vector/bye-goodbye-vector-6122218)
    ASCII Image Conversion: Patrik Roos (http://www.text-image.com/convert/ascii.html)
  
    TopHeadlines Gem made by Zach Newburgh (http://www.zachnewburgh.com/)
    Copyright © 2016 Zach Newburgh
    
    DOC

  end
end