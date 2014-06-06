FactoryGirl.define do

  sequence :name do |n|
    "Name #{n}"
  end

  sequence :content do |n|
    "Lorem Ipsum #{n}"
  end

  sequence :url do |n|
    "http://url#{n[0]}.com"
  end

  sequence :model_id do |n|
    n
  end

  sequence :email do |n|
    "person_#{n}_@example.com"
  end

  sequence :message do |n|
    "message_#{n}"
  end

  sequence :text do |n|
    "text_#{n}"
  end

end