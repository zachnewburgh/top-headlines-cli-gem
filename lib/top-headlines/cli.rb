class TopHeadlines::CLI

  def call
    welcome_banner
    news_sources
    menu
    goodbye
  end

  def menu
    puts "Which source do you want to view? Alternatively, type 'all' to view all headlines or 'exit' to exit!"
    print "YOUR SELECTION: "
    while @input != "EXIT" && @num != "EXIT"
      @input = gets.strip.upcase 
      menu_if_statement
    end
  end

  def menu_if_statement
    if @input == "ALL"
      list_all_headlines_banner
      list_all_headlines
      all_headlines_open_in_browser
    elsif @input == "SOURCES"
      news_sources_banner
      news_sources
      puts request_input_full_menu
      print "YOUR SELECTION: "
    elsif source_includes?(@input)
      list_headlines_from_source
      headlines_from_source_open_in_browser
    elsif @input != "EXIT"
      invalid_entry
    else
    end
  end

  def welcome_banner
    system "clear"
    puts " --------------------------- "
    puts "| WELCOME TO TOP HEADLINES! |"
    puts " --------------------------- "
    time
  end
  
  def time
    puts "Reporting live as of #{Time.now.strftime("%l:%M %p %Z on %a, %b #{Time.now.strftime("%e").to_i.ordinalize}, %Y")}:"
    puts "\n"
  end

  def news_sources
    TopHeadlines::Source.all.keys.sort.each {|source| puts "*** #{source} ***"}
    puts "\n"
  end

  def list_all_headlines_banner
    system "clear"
    puts " -------------------------------"
    puts "| TOP HEADLINES & BREAKING NEWS |"
    puts " -------------------------------"
    time
  end

  def list_all_headlines
    TopHeadlines::Source.list_all_headlines
  end

  def request_input_full_menu
    "Select a source, type 'sources' to view sources, type 'all' to view all headlines, or type 'exit' to exit."
  end

  def source_includes?(input)
    TopHeadlines::Source.all.keys.include?(input)
  end

  def news_sources_banner
    puts "\n"
    puts "NEWS SOURCES"
    puts "------------"
  end

  def list_headlines_from_source
    system "clear"
    puts "\n*** #{@input} ***"
    time
    TopHeadlines::Source.scrape_headlines(@input)[0,5].each_with_index {|headline, index| puts "#{index + 1}. #{headline}"}
    puts "\n"
  end

  def all_headlines_open_in_browser
    puts "Select source and headline number to open the full article in the browser. \n(e.g. 'cnn 3') \n\nAlternatively, #{request_input_full_menu.downcase}"
    print "\nYOUR SELECTION: "
    @num = gets.strip.upcase

    while @num[-1].to_i.between?(1,5) && !num_included_in_menu_if_statement
      source = @num[0...-1].strip.upcase
      headline = @num.strip[-1].to_i

      open_url(source, headline)

      sleep(1)
      puts "\nSelect another source and headline number to open full article in the browser. \n\nAlternatively, #{request_input_full_menu.downcase}"
      print "\nYOUR SELECTION: "
      @num = gets.strip.upcase
    end

    num_included_in_menu_if_statement ? @input = @num : invalid_entry
    menu_if_statement
  end

  def headlines_from_source_open_in_browser
    puts "Select headline number to open the full article in the browser. \n\nAlternatively, #{request_input_full_menu.downcase}"
    print "\nYOUR SELECTION: "
    @num = gets.strip.upcase

    while @num.to_i.between?(1,5) && !num_included_in_menu_if_statement
      open_url(@input, @num)
      
      sleep(1)
      puts "\nSelect another headline number to open full article in the browser. \n\nAlternatively, #{request_input_full_menu.downcase}"
      print "\nYOUR SELECTION: "
      @num = gets.strip.upcase
      
      @input = @num if num_included_in_menu_if_statement
    end
      
    num_included_in_menu_if_statement ? @input = @num : invalid_entry
    menu_if_statement
  end

  def open_url(source, number)
    headline = TopHeadlines::Source.scrape_headlines(source)[number.to_i-1]
    puts "\n=> You selected the #{number.to_i.ordinalize} headline: '#{headline}'."
    puts "=> Opening..."

    sleep(2)
    url = TopHeadlines::Source.scrape_urls(source)[number.to_i-1]
    url != nil ? system("open", url) : invalid_entry
  end

  def num_included_in_menu_if_statement
    @num == "EXIT" || @num == "ALL" || @num == "SOURCES" || source_includes?(@num)
  end

  def invalid_entry
    puts "\n=> INVALID SELECTION: #{request_input_full_menu}"
    sleep(1)
    news_sources_banner
    news_sources
    print "YOUR SELECTION: "
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