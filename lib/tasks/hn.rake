require 'active_record'
require 'lib/scrape/hnscraper'

namespace :hn do
  task :scrape => :environment do
    puts "environment is #{Rails.env}"
    puts "using db config: hn_#{Rails.env}"
    scraper = HNScraper.new
    scraper.scrape ActiveRecord::Base.configurations["hn_#{Rails.env}"]
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
