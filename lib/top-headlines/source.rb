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
    "POLITICO" => {
      url: "http://www.politico.com/",
      headlines_selector: "ul.headline-list a",
      urls_selector: "ul.headline-list",
      child_selector: "a"
    },
    "FIVETHIRTYEIGHT" => {
      url: "http://fivethirtyeight.com/",
      headlines_selector: "div#primary h3 a",
      urls_selector: "div#primary h3",
      child_selector: "a"
    },      
    "WASHINGTON POST" => {
      url: "https://www.washingtonpost.com/",
      headlines_selector: "section#main-content div[class*='headline'] a",
      urls_selector: "section#main-content div[class*='headline']",
      child_selector: "a"
    },  
    "BBC" => {
      url: "http://www.bbc.com/news",
      headlines_selector: "div.column--primary span.title-link__title-text",
      urls_selector: "div.column--primary",  
      child_selector: "a.title-link"
    }, 
    "THE DAILY BEAST" => {
      url: "http://www.thedailybeast.com/",
      headlines_selector: "li.cheat h3",
      urls_selector: "li.cheat",  
      child_selector: "a:nth-child(2)"
    },
    "YAHOO" => {
      url: "https://www.yahoo.com/news",
      headlines_selector: "div#mrt-node-Col1-1-WideHero h3",
      urls_selector: "div#mrt-node-Col1-1-WideHero",
      child_selector: "a[class*='D(b)']"
    },  
    # "REDDIT" => { ## 429 Error
    #   url: "https://www.reddit.com/r/news/",
    #   headlines_selector: "p.title a.title.may-blank",
    #   urls_selector: "p.title",
    #   child_selector: "a"
    # },
    # "CBS" => {
    #   url: "http://www.cbsnews.com/",
    #   headlines_selector: "div.col-5.nocontent li.item-full-lead h3.title",
    #   urls_selector: "div.col-5.nocontent li.item-full-lead",
    #   child_selector: "a:first-child" ## NEEDS WORK – only select first parent h3.title
    # },      
  }

  def self.all
    SOURCES
  end

  def self.list_all_headlines
    article_sum = 0  
    SOURCES.keys.sort.each do |source|
      puts "*** #{source} ***"
      scrape_headlines(source)[0,5].each {|headline| puts "#{article_sum+1}. #{headline}"; article_sum += 1}
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
    page_url = page_url[0...-5] if page_url[-4...-1]+page_url[-1] == "news" ### BBC CORNER CASE
    urls = doc.css(urls_selector).children.css(child_selector).map {|url| url.attribute('href').value[0] == 'h' ? url.attribute('href').value : page_url + url.attribute('href').value}
  end
end