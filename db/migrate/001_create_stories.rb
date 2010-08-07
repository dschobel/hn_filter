class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories, :id => false do |t|
      t.column "id", :integer, :limit => 100, :options => 'PRIMARY KEY'
      t.column "title", :string, :limit => 200, :null => false
      t.column "url", :string, :limit => 200, :null => false
      t.column "score", :integer, :limit => 75, :null => false
      t.column "created_at", :timestamp , :null => false
      t.column "updated_at", :timestamp, :null => false
    end
  end

  def self.down
    drop_table :stories
  end
end
