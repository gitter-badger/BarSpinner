class Setting < ActiveRecord::Base
  attr_accessible :bar_color, :link_color, :max_impressions_count, :text_color

  belongs_to :bar
end
