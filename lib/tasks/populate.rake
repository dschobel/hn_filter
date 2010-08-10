namespace :db do
  desc "Erase and fill database with test data"
  task :populate => :environment do
    require 'populator'
    require 'randomtime'
    require 'faker'
    puts 'populating!'
    Story.delete_all
    Story.populate 10000 do |story|
      story.title = Populator.words(3..6).titleize
      story.score = rand(200)
      story.created_at = Time.random
      story.updated_at = story.created_at + (2+rand(10)).days
      story.url = "http://#{Faker::Internet.domain_name}"
    end
  end
end
