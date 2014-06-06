FactoryGirl.define do
  factory :ad_platform do
    name { generate(:name) }
    url { generate(:url) }
    association :user, factory: :user
  end

  factory :ad_platform_with_bars, parent: :ad_platform do
    after :create do |ad_platform|
      3.times do 
        FactoryGirl.create(:bar, ad_platform: ad_platform)
      end
    end
  end
end