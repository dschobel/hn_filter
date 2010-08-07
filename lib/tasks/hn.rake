require 'lib/scrape/hnscraper'

namespace :hn do
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

  task :scrape => :environment do
    puts "starting scrape"
    puts Dir.pwd
    hn = HNScraper.new
    DataMapper.setup(:default, "postgres://postgres:sounder@localhost/hn" ) 
    DataMapper.finalize 
    DataMapper.auto_upgrade! 
    stories = hn.scrape 
    stories.map {|s| updateOrCreate s} 
    puts 'done scraping'
  end


  namespace :stats do
    task :last_day  => :environment do
      puts 'last day'
    end

    task :last_week  => :environment do
      puts 'last week'
    end

    task :last_month  => :environment do
      puts 'last month'
    end

    task :last_year  => :environment do
      puts 'last year'
    end

    task :all_time  => :environment do
      puts 'all time'
    end
  end
end
