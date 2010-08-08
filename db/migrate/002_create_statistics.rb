class CreateStatistics < ActiveRecord::Migration
  def self.up
    create_table :statistics do |t|
      t.column "timeframe_in_days", :integer, :null => false
      t.column "mean", :float, :null => false
      t.column "median", :float, :null => false
      t.column "min", :integer, :null => false
      t.column "max", :integer, :null => false
      t.column "updated_at", :timestamp, :null => false
    end
  end

  def self.down
    drop_table :statistics
  end
end
