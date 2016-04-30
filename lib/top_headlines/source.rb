class TopHeadlines::Source

  SOURCES = {
    "CNN" => {
      url: "http://www.cnn.com/",
      headlines_selector: "div.column.zn__column--idx-1 span.cd__headline-text",
      urls_selector: "div.column.zn__column--idx-1"
      },
    "MSNBC" => {
      url: "http://www.msnbc.com/",
      headlines_selector: "span.featured-slider-menu__item__link__title",
      urls_selector: "ul.featured-slider-menu"
    }
  }

  def self.all
    SOURCES
  end

  def self.list_all_headlines
    SOURCES.keys.each do |source|
      puts "*** #{source} ***"
      scrape_headlines(source)[0,5].each_with_index do |headline, index|
        puts "#{index+1}. #{headline}"
      end
      puts "\n"
    end
  end

  def self.scrape_headlines(source)
    source = SOURCES[source]
    page_url = source[:url]
    headlines_selector = source[:headlines_selector]

    doc = Nokogiri::HTML(open(page_url))
    headlines = doc.css(headlines_selector).map {|headline| headline.text}
  end

  def self.scrape_urls(source)
    source = SOURCES[source]
    page_url = source[:url]
    urls_selector = source[:urls_selector]
    
    doc = Nokogiri::HTML(open(page_url))
    urls = doc.css(urls_selector).children.css('a').map {|url| page_url + url.attribute('href').value}
  end
end