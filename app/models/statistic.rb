class Statistic < ActiveRecord::Base
  TIMEFRAMES = %w{ last_day last_week last_month last_year alltime }

  validate :timeframe_must_be_valid

  def timeframe_must_be_valid
    errors.add_to_base("timeframe must be one of: [#{TIMEFRAMES.join ", "}]") unless TIMEFRAMES.member? timeframe
  end
end
