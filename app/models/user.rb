class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :remember_me

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :bars, dependent: :destroy
  has_many :ad_platforms, dependent: :destroy

end
