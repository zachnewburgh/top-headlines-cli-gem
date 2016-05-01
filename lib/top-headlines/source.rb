class TopHeadlines::Source

  SOURCES = {
    "CNN" => {
      url: "http://www.cnn.com/",
      headlines_selector: "div.column.zn__column--idx-1 span.cd__headline-text",
      urls_selector: "div.column.zn__column--idx-1",
      child_selector: "a"
      },
    "MSNBC" => {
      url: "http://www.msnbc.com/",
      headlines_selector: "span.featured-slider-menu__item__link__title",
      urls_selector: "ul.featured-slider-menu",
      child_selector: "a"
    },
    "FOX" => {
      url: "http://www.foxnews.com/",
      headlines_selector: "section#trending li a",
      urls_selector: "section#trending li",
      child_selector: "a"
    },
    "NYTIMES" => {
      url: "http://www.nytimes.com/",
      headlines_selector: "section#top-news h2.story-heading a",
      urls_selector: "section#top-news h2.story-heading",
      child_selector: "a"
    },
    "BLOOMBERG" => {
      url: "http://www.bloomberg.com/",
      headlines_selector: "section.top-news-v3 h1 a",
      urls_selector: "section.top-news-v3 h1",
      child_selector: "a"
    },
    "GUARDIAN" => {
      url: "http://www.theguardian.com/us",
      headlines_selector: "section#headlines div.fc-container__inner div.fc-item__container a.u-faux-block-link__overlay.js-headline-text",
      urls_selector: "section#headlines div.fc-container__inner div.fc-item__container",
      child_selector: "a.u-faux-block-link__overlay.js-headline-text"
    },
    "HUFF POST" => {
      url: "http://www.huffingtonpost.com/",
      headlines_selector: "div#center_entries_container h2 a",
      urls_selector: "div#center_entries_container h2",
      child_selector: "a"
    },
    "FORBES" => {
      url: "http://www.forbes.com/",
      headlines_selector: "h4",
      urls_selector: "h4",
      child_selector: "a"
    },   
    "WSJ" => {
      url: "http://www.wsj.com/",
      headlines_selector: "a.wsj-headline-link",
      urls_selector: "div.cb-col",
      child_selector: "a.wsj-headline-link"
    },   
    # "REDDIT" => { ## 429 Error
    #   url: "https://www.reddit.com/r/news/",
    #   headlines_selector: "p.title a.title.may-blank",
    #   urls_selector: "p.title",
    #   child_selector: "a"
    # },
    # "BBC" => {
    #   url: "http://www.bbc.com/news",
    #   headlines_selector: "div.column--primary span.title-link__title-text",
    #   urls_selector: "div.column--primary",  
    #   child_selector: "a.title-link" ## NEEDS WORK returns e.g. /news/world-middle-east-36180184
    # },  
    # "CBS" => {
    #   url: "http://www.cbsnews.com/",
    #   headlines_selector: "div.col-5.nocontent h3.title",
    #   urls_selector: "div.col-5.nocontent",
    #   child_selector: "a" ## NEEDS WORK – only select a child of parent h3.title
    # },
    # "YAHOO" => {
    #   url: "https://www.yahoo.com/news/",
    #   headlines_selector: "div#mrt-node-Col1-1-WideHero h3",
    #   urls_selector: "div#mrt-node-Col1-1-WideHero",
    #   child_selector: "a" ## NEEDS WORK – only select a child of parent h3
    # },        
  }

  def self.all
    SOURCES
  end

  def self.list_all_headlines
    SOURCES.keys.sort.each do |source|
      puts "*** #{source} ***"
      scrape_headlines(source)[0,5].each_with_index {|headline, index| puts "#{index+1}. #{headline}"}
      puts "\n"
    end
  end

  def self.scrape_headlines(source)
    source = SOURCES[source]
    page_url = source[:url]
    headlines_selector = source[:headlines_selector]

    doc = Nokogiri::HTML(open(page_url))
    headlines = doc.css(headlines_selector).map {|headline| headline.text.gsub("â", "'").gsub(/\n/,"").gsub(/\t/,"").strip}
  end

  def self.scrape_urls(source)
    source = SOURCES[source]
    page_url = source[:url]
    urls_selector = source[:urls_selector]
    child_selector = source[:child_selector]
    
    doc = Nokogiri::HTML(open(page_url))
    urls = doc.css(urls_selector).children.css(child_selector).map {|url| url.attribute('href').value[0] == 'h' ? url.attribute('href').value : page_url + url.attribute('href').value}
  end
end