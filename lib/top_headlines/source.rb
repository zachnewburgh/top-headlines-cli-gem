class TopHeadlines::Source

  SOURCES = {
    "CNN" => "http://www.cnn.com/"
  }

  def self.all
    SOURCES
  end

  def self.scrape_headlines(source)
    source = SOURCES[source]
    doc = Nokogiri::HTML(open(source))
    headlines = doc.css('div.column.zn__column--idx-1 span.cd__headline-text').map {|headline| headline.text}
  end

  def self.scrape_urls(source)
    source = SOURCES[source]
    doc = Nokogiri::HTML(open(source))
    urls = doc.css('div.column.zn__column--idx-1').children.css('a').map {|url| source + url.attribute('href').value}
  end
end