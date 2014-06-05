class AdPlatform < ActiveRecord::Base
  attr_accessible :name, :url

  belongs_to :user
  has_many :bars, dependent: :destroy

  before_create :generate_token

  validates :name, :url, :user_id, presence: true
  validates :url, url: true

  private

    def generate_token
      self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end
end
