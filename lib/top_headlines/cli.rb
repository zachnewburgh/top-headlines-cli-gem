class TopHeadlines::CLI

  def call
    # puts " ---------------------------"
    # puts "| WELCOME TO TOP HEADLINES! |"
    # puts " ---------------------------"
    # time
    # puts "\n"
    # TopHeadlines::Source.all.keys.each do |source|
    #   puts "*** #{source} ***"
    # end
    # puts "\n"
    # menu
    goodbye
  end

  def menu
    puts "Which source do you want to view? Alternatively, type 'all' to view all headlines or 'exit' to exit!"
    input = nil
    while input != "EXIT"
      input = gets.strip.upcase 
      if input == "ALL"
        puts " -------------------------------"
        puts "| TOP HEADLINES & BREAKING NEWS |"
        puts " -------------------------------"
        time
        puts "\n"
        TopHeadlines::Source.all_headlines
        puts "\nSelect a source or type 'exit' to exit."
      elsif
        input == "SOURCES"
        puts "\n"
        puts "NEWS SOURCES"
        puts "------------"
        TopHeadlines::Source.all.keys.each do |source|
          puts "*** #{source} ***"
        end
        puts "\nSelect a source or type 'exit' to exit."
      elsif TopHeadlines::Source.all.keys.include?(input)
        puts "\n*** #{input} ***"
        time
        puts "\n"
        TopHeadlines::Source.scrape_headlines(input)[0,5].each_with_index do |headline, index|
          puts "#{index + 1}. #{headline}"
        end
        puts "\n"

        puts "Select article number to open."
        num = gets.strip.to_i

        while num > 0
          url = TopHeadlines::Source.scrape_urls(input)[num-1]
          system("open", url)
          puts "Select another article number to open."
          num = gets.strip.to_i
        end
        puts "Invalid entry: select a source or type 'exit'."
      elsif input != "EXIT"
        puts "error"
      else
        nil
      end
    end
  end

  def time
    puts "Reporting live as of #{Time.now.strftime("%l:%M %p %Z on %a, %b #{Time.now.strftime("%e").to_i.ordinalize}, %Y")}"
  end

  def goodbye
    puts "\nThanks for visiting – see you next time!"

    puts <<-DOC
                                                                                                    
                          `.`                                                                       
                     ..` .-:-.                                                                      
                    `:::--:::.                                                                      
                 .---::::::::.                       ``````..``````                                 
                `-:::::::::::``````             ``...---------------..```                           
             .-..::::::::::::--:::-.        ``..-------------------------.``                        
             .:::::::::::::::::::-.`      `..-------------------------------.`                      
              -::::::::::::::::-`       `.------------------------------------.`                    
              `-::::::::::::::-`      `.----------------------------------------.`                  
               `-:::::::::::::.      `--------------------------------------------.`                
                `-::::::::::::.     .----------------------------------------------.`               
                 `--::::::::--`    .------------:oso/--------------/oso:------------.`              
                   ``.---..``     .-------------shhhh:-------------yhhhs-------------.              
                      .--.       `--------------:oss+--------------/sss:--------------`             
                      `---`      .----------------------------------------------------.             
                       `.--.`    .-----------------------------------------------------`            
                        `.---.```------------------------------------------------------`            
                          `..----------------------------------------------------------`            
                             ``..------------------------------------------------------`            
                                 .-----------------------------------------------------`            
                                 `--------------:/--------------------//--------------.             
                                  .------------+hhs/----------------/shho-------------`             
                                  `.------------+yhhs+:----------:/shhy+-------------`              
                                   `.------------:+yhhhyso++++oosyhhyo:-------------.               
                                    `.--------------:+syyyhhhhyyys+/---------------`                
                                     `.------------------:://:::-----------------.`                 
                                       `.--------------------------------------.`                   
                                         `.----------------------------------.`                     
                                           `..----------------------------..`                       
                                              ``..--------------------...`                          
                                                  ```.....----......``                              
                                                                                                    
    

    Image: VectorStock (https://www.vectorstock.com/royalty-free-vector/bye-goodbye-vector-6122218)
    ASCII Image Conversion: Patrik Roos (http://www.text-image.com/convert/ascii.html)
  
    TopHeadlines created by Zach Newburgh (http://www.zachnewburgh.com/)
    Copyright © 2016 Zach Newburgh
    
    DOC

  end
end