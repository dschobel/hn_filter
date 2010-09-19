require 'rubygems'
require 'open-uri'
require 'active_record'
require 'nokogiri'
require 'story'

class HNScraper

  HN = 'http://news.ycombinator.com'

  def self.getMoreLink(hn)
    link = hn.css('.title:nth-child(2) a')
    HN + link.first.attr('href')
  end

  def self.Scrape(dbConfig, rounds=1, delay_in_seconds=5)
    rounds = rounds.to_i unless rounds.class == Fixnum
    ActiveRecord::Base.establish_connection(dbConfig)
    puts "scraping #{rounds} pages"
    nextPage = HN
    for round in (1..rounds)
      puts "current round is #{round}"
      puts "nextPage is #{nextPage}"
      page = Nokogiri::HTML(open(nextPage))
      HNScraper.scrapePage(page)
      nextPage = HNScraper::getMoreLink page
      puts "sleeping for #{delay_in_seconds} seconds"
      sleep delay_in_seconds unless rounds == 1
    end
  end

  def self.scrapePage(page)

    titles = page.css('.title:nth-child(3) a')
    points = page.css('.subtext span')

    stories =[]
    for i in (0..29)
      title = titles[i].children.inner_text
      url = titles[i].attr 'href'
      id = (points[i]['id']).split('_')[1].to_i
      score = points[i].inner_text.split(' ')[0].to_i

      story = Story.find_by_id(id)
      if !story
        story = Story.new do |s|
          s.title = title
          s.id = id
          s.score = score
          s.url = url
          s.created_at = Time.now
          s.updated_at = Time.now
        end
      else
        story.updated_at = Time.now
      end
      story.save!
      stories
    end
  end
end
