class TopHeadlines::CLI

  def call
    puts " ---------------------------"
    puts "| WELCOME TO TOP HEADLINES! |"
    puts " ---------------------------"
    puts "\n"
    TopHeadlines::Source.all.keys.each do |source|
      puts "*** #{source} ***"
    end
    puts "\n"
    menu
  end

  def menu
    puts "Which source do you want to view?"
    input = gets.strip.upcase
    if TopHeadlines::Source.all.keys.include?(input)
      puts "\n*** #{input} ***"
      TopHeadlines::Source.scrape_headlines(input).each_with_index do |headline, index|
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

    else
      puts "error"
    end
  end
end