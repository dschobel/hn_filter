class Statistic < ActiveRecord::Base
  TIMEFRAMES = {
    :last_day => 1,
    :last_week => 7,
    :last_month => 30,
    :last_year => 365,
    :alltime => -1
  }

  validate :timeframe_must_be_valid

  def timeframe_must_be_valid
    errors.add_to_base("timeframe must be one of: [#{TIMEFRAMES.keys.join ", "}]") unless TIMEFRAMES.has_key? timeframe
  end

  def self.CalculateStatistics(timeframe)
      tf = TIMEFRAMES[timeframe] || puts ("failed to find key #{timeframe}")
      puts "calculating last day for real, using connection #{connection.to_s}"
      puts "parameter will be #{tf}"
      connection.execute("select update_statistics(#{tf});")
  end
end
