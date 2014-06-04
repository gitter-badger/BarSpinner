class AdPlatform < ActiveRecord::Base
  attr_accessible :name, :url

  belongs_to :user
  has_many :bars, dependent: :destroy
end
