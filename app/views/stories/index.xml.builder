xml.instruct! :xml, :version=>"1.0"
xml.rss(:version=>"2.0"){
  xml.channel{
  xml.title("HN Threshold")
  xml.link("http://www.example.com")
  xml.description("HN Stories")
  xml.language('en-us')
  for story in @stories
    xml.item do
      xml.title(story.title)
      xml.description("score: #{story.score}")
      #xml.author("Your Name Here")
      xml.pubDate(story.created_at.strftime("%a, %d %b %Y %H:%M:%S %z"))
      xml.link(story.url)
      xml.guid("http://example.com/stories/#{story.id}")
    end
  end
}
}
