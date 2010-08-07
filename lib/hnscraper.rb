require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'dm-core'
require 'dm-migrations'
require 'story'

class HNScraper
    def initialize(path = "http://news.ycombinator.com")
        @path = path
    end


    def scrape
        hn = Nokogiri::HTML(open(@path))

        titles = hn.css('.title:nth-child(3) a')
        points = hn.css('.subtext span')

        #put it all together
        stories =[]
        for i in (0..29)
            title = titles[i].children.inner_text
            url = titles[i].attr 'href'
            id = (points[i]['id']).split('_')[1].to_i
            score = points[i].inner_text.split(' ')[0].to_i
            stories << Story.new(:id => id,
                                 :title => title,
                                 :url => url,
                                 :score => score,
                                 :created_at => Time.now,
                                 :updated_at => Time.now)
        end
        stories
    end


end

def updateOrCreate(new_story)
    s = Story.get new_story.id
    if s
        s.update( :score => new_story.score,:updated_at => Time.now )
	puts "updating story"
    else
        new_story.save
	puts "saving new story"
    end
end
if __FILE__ == $0
    if(ARGV[0])
        if !File.readable?(ARGV[0])
            puts " File does not exist."
            exit
        end
        hn = HNScraper.new ARGV[0] 
    else
        hn = HNScraper.new 
    end

    DataMapper.setup(:default, "postgres://postgres:sounder@localhost/hn" )
    DataMapper.finalize
    DataMapper.auto_upgrade!
    stories = hn.scrape
    stories.map {|s| updateOrCreate s}
end
