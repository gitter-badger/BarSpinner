class Bar < ActiveRecord::Base
  attr_accessible :link_text, :link_url, :message, :name

  belongs_to :user
  belongs_to :ad_platform  
  has_many :clicks, dependent: :destroy
  has_many :visits, dependent: :destroy
  has_one :setting, dependent: :destroy


  before_create :generate_token

  def trigger_click
    self.clicks.create!
  end

  def trigger_visit
    self.visits.create!
  end

  private

	  def generate_token
	  	self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
	  end
end
