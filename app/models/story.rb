class Story < ActiveRecord::Base
  def readonly?
    true
  end
end
