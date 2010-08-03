class Story 
    include Comparable
    attr_accessor :id
    attr_accessor :name
    attr_accessor :url
    attr_accessor :hn_url
    attr_accessor :score
    def <=>(other)
        self.score <=> other.score
    end

    def initialize(id, name, url, score)
        @id = id
        @name = name
        if url =~ /item\?id=\d+/
            @url = "http://news.ycombinator.com/#{url}"
        else 
            @url = url
        end
        @score = score
        @hn_url = "http://news.ycombinator.com/item?id=#{@id}"
    end
end
