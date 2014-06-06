class AdPlatform < ActiveRecord::Base
  attr_accessible :name, :url

  belongs_to :user
  has_many :bars, dependent: :destroy

  before_create :generate_token

  validates :name, :url, :user_id, presence: true
  validates :url, url: true


  def get_next_bar
    with_lock do
      bar_ids = self.bars.pluck(:id)
      recent_bar = self.recent_bar_id || bar_ids.first
      bar_index = bar_ids.index(recent_bar)
      next_bar_id = bar_ids.last == recent_bar ? bar_ids.first : bar_ids[bar_index + 1]
      self.update_attribute(:recent_bar_id, next_bar_id)
      Bar.find(next_bar_id)
    end
  end

  private

    def generate_token
      self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    end
end
