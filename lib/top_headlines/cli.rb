class TopHeadlines::CLI

  def call
    puts "Welcome to TopHeadlines! :)"
    menu
  end

  def menu
    puts "Which source do you want to view?"
    input = gets.strip.upcase
    if input == "CNN"
      puts "\n*** CNN ***"
      TopHeadlines::Source.scrape_headlines(input).each_with_index do |headline, index|
        puts "#{index + 1}. #{headline}"
      end
      puts "\n"

      puts "Select article number to open."
      num = gets.strip.to_i
      url = TopHeadlines::Source.scrape_urls(input)[num-1]
      system("open", url)
    else
      puts "error"
    end
  end
end