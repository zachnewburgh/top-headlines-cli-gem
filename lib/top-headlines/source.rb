class TopHeadlines::Source

  SOURCES = {
    "CNN" => {
      url: "http://www.cnn.com/us",
      headlines_selector: ".cd__headline",
      urls_selector: "h3.cd__headline",
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
      url: "https://www.nytimes.com/",
      headlines_selector: "section#top-news h2.story-heading a",
      urls_selector: "section#top-news h2.story-heading",
      child_selector: "a"
    },
    "BLOOMBERG" => {
      url: "https://www.bloomberg.com/",
      headlines_selector: "section.top-news-v3 h1 a",
      urls_selector: "section.top-news-v3 h1",
      child_selector: "a"
    },
    "GUARDIAN" => {
      url: "https://www.theguardian.com/us",
      headlines_selector: "section#headlines div.fc-container__inner div.fc-item__container a.u-faux-block-link__overlay.js-headline-text",
      urls_selector: "section#headlines div.fc-container__inner div.fc-item__container",
      child_selector: "a.u-faux-block-link__overlay.js-headline-text"
    },
    "HUFF POST" => {
      url: "http://www.huffingtonpost.com/",
      headlines_selector: "h2[class*='js-card-headline']",
      urls_selector: "h2[class*='js-card-headline']",
      child_selector: "a"
    },
    # "FORBES" => {
    #   url: "https://www.forbes.com/",
    #   headlines_selector: "h2 span",
    #   urls_selector: "div[class*='related-articles ng-scope']",
    #   child_selector: "a"
    # },   
    "WSJ" => {
      url: "https://www.wsj.com/",
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
      url: "https://fivethirtyeight.com/",
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
    "DAILY BEAST" => {
      url: "http://www.thedailybeast.com/",
      headlines_selector: "li.cheat h3",
      urls_selector: "li.cheat",  
      child_selector: "a:nth-child(2)"
    },
    "YAHOO" => {
      url: "https://www.yahoo.com/news",
      headlines_selector1: "div#mrt-node-Col1-1-WideHero h3",
      headlines_selector: "div#item-0 ul li",
      urls_selector: "div#item-0 ul li",
      child_selector: "a[class*='D(b)']"
    },  
    "AP" => {
      url: "http://bigstory.ap.org",
      headlines_selector: "h5.entry-title.node-title.title",
      urls_selector: "h5.entry-title.node-title.title",
      child_selector: "a:first-child"
    }, 
    "MONDE" => {
      url: "http://www.lemonde.fr/",
      headlines_selector: "div.titres_edito h1, h2", # NEEDS TO REMOVE '14' and '13' from beginning of 1st and 3rd headlines 
      urls_selector: "div.titres_edito article",
      child_selector: "a"
    }, 
    "INDEPENDENT UK" => {
      url: "http://www.independent.co.uk",
      headlines_selector: "h1:not(.box-title), h2",
      urls_selector: "div.row[data-tb-region='row-2'] div.content h1, div.grid-mod-card-list ul li",
      child_selector: "a"
    }, 
    "NPR" => {
      url: "http://www.npr.org/",
      headlines_selector: "article:not(.hp-item.attachment.volume-low) h1.title:first-child",
      urls_selector: "section#main-section div.story-text",
      child_selector: "a:nth-child(2)"
    },
    # "TELEGRAPH" => {
    #   url: "http://www.telegraph.co.uk/",
    #   headlines_selector: "main h3 a",
    #   urls_selector: "main div[class*='list-of-entities'] h3", # NEED TO FIX LINKS
    #   child_selector: "a:first-child"
    # },     
    # "REUTERS" => {
    #   url: "http://www.reuters.com/news",
    #   headlines_selector: "div.column1.gridPanel.grid8 div.moduleBody :not(div.photo) a", # NEED TO ACCOUNT FOR :not(span a) at same level as a
    #   urls_selector: "div.column1.gridPanel.grid8 div.moduleBody :not(div.photo)",
    #   child_selector: "a"
    # }, 
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

    headlines = doc.css(headlines_selector).map {|headline| headline.text.strip.gsub("â", "'").gsub(/\n/,"").gsub(/\t/,"").gsub(/\d+$/,"")}
  end

  def self.scrape_urls(source)
    source = SOURCES[source]
    page_url = source[:url]
    urls_selector = source[:urls_selector]
    child_selector = source[:child_selector]
    
    doc = Nokogiri::HTML(open(page_url))

    page_url = page_url[0...-5] if page_url[-4...-1]+page_url[-1] == "news" ### EDGE CASES (BBC & YAHOO)
    page_url = "http://www.cnn.com/" if page_url.include?("www.cnn.com") ### EDGE CASE (CNN)

    urls = doc.css(urls_selector).children.css(child_selector).map {|url| url.attribute('href').value[0] == 'h' ? url.attribute('href').value : page_url + url.attribute('href').value}
  end
end