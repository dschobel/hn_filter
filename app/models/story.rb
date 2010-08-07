class Story < ActiveRecord::Base
  include Comparable

  def <=>(other)
    self.score <=> other.score
  end

  def url=(new_url)
    if new_url =~ /item\?id=\d+/
      write_attribute(:url,"http://news.ycombinator.com/#{new_url}")
    else 
      write_attribute(:url,new_url)
    end
  end

  def HNUrl(id)
    @hn_url = "http://news.ycombinator.com/item?id=#{@id}"
  end
end
