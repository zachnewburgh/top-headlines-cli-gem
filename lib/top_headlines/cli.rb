class TopHeadlines::CLI

  def call
    puts "Welcome to TopHeadlines! :)"
    menu
  end

  def menu
    puts "Which source do you want to view?"
    input = gets.strip.upcase
    if input == "CNN"
      puts <<-DOC  
*** CNN ***
  1. Bernie Sanders surges in the polls.
  2. Facebook stock reaches record high.
      DOC
    else
      puts "error"
    end
  end
end