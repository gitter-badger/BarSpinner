FactoryGirl.define do
  factory :bar do
    name { generate(:name) }
    message { generate(:message) }
    link_text { generate(:text) }
    link_url { generate(:url) }
    visits_count 0
    clicks_count 0
    association :ad_platform, factory: :ad_platform
  end
end