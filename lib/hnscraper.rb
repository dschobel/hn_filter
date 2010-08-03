require 'open-uri'
require 'rubygems'
require 'nokogiri'
require 'story'

class HNScraper
    def initialize(path = "http://news.ycombinator.com")
        @path = path
    end


    def scrape
        hn = Nokogiri::HTML(open(@path))

        titles = hn.css('.title:nth-child(3) a')
        links = {}
        titles.each do |title|
            links[title.children.inner_text] = title.attr('href')
        end

        points = hn.css('.subtext span')
        point_data ={}
        points.each do |point|
            id = (point['id']).split('_')[1].to_i
            point_data[id] = point.inner_text.split(' ')[0].to_i
        end

        #put it all together
        stories =[]
        point_data.keys.each_index do |idx|
            stories << Story.new(point_data.keys[idx], links.keys[idx], links.values[idx],point_data.values[idx])
        end
        stories
    end
end
