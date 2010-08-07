require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'story'

class HNScraper

  def initialize(path = "http://news.ycombinator.com")
    @path = path
  end

  def self.validConfig?(file)
    file && File.readable?(file) && File.extname(file) == '.yml'
  end

  def scrape(dbConfig)
    hn = Nokogiri::HTML(open(@path))

    titles = hn.css('.title:nth-child(3) a')
    points = hn.css('.subtext span')

    #put it all together
    ActiveRecord::Base.establish_connection(dbConfig)
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
