class Bar < ActiveRecord::Base
  attr_accessible :link_text, :link_url, :message, :name, :setting_attributes

  belongs_to :ad_platform, counter_cache: true  
  has_many :clicks, dependent: :destroy
  has_many :visits, dependent: :destroy
  has_one :setting, dependent: :destroy

  accepts_nested_attributes_for :setting

  validates :link_text, :link_url, :message, :name, :ad_platform_id, presence: true

  def trigger_click
    self.clicks.create!
  end

  def trigger_visit
    self.visits.create!
  end

end
