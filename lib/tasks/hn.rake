require 'active_record'
require 'app/models/statistic'
require 'lib/scrape/hnscraper'

namespace :hn do
  task :scrape => :environment do
    start = Time.now
    puts "environment is #{Rails.env}"
    puts "using db config: hn_#{Rails.env}"
    scraper = HNScraper.new
    scraper.scrape ActiveRecord::Base.configurations["hn_#{Rails.env}"]
    puts "Done scraping in #{Time.now - start}s"
  end
  task :echo, :message do |t, args|
    message = args[:message] || 'Hello'
    puts message
  end

  namespace :stats do
    task :update, :timeframe, :needs => :environment do |t, args|
      start = Time.now
      unless Statistic::TIMEFRAMES.has_key? args[:timeframe].to_sym 
        puts "#{args[:timeframe]} is an unsupported timeframe!"
        puts "valid values are: #{Statistic::TIMEFRAMES.keys.join ", "}"
        exit 
      end

      Statistic.CalculateStatistics  args[:timeframe].to_sym
      puts "Finished processing #{args[:timeframe]}'s statistics in #{Time.now - start}s"
    end
    task :update_all => :environment do
      #Rake::Task["your_task"].execute({:some_param => some_value})
      Statistic::TIMEFRAMES.keys.each do |key|
        Rake::Task['hn:stats:update'].execute({:timeframe => key})
      end
    end
  end

end
