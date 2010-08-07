require 'dm-core'

class Story 
    include Comparable
    include DataMapper::Resource
    property :id,    Integer, :key => true
    property :title,    String, :length => 200
    property :url, String, :length => 200
    property :score, Integer
    property :created_at, DateTime
    property :updated_at, DateTime

    def <=>(other)
        self.score <=> other.score
    end

    def url=(new_url)
        if new_url =~ /item\?id=\d+/
            attribute_set(:url,"http://news.ycombinator.com/#{new_url}")
        else 
            attribute_set(:url,new_url)
        end
    end

    def HNUrl(id)
        @hn_url = "http://news.ycombinator.com/item?id=#{@id}"
    end
end
