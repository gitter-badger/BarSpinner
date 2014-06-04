FactoryGirl.define do

  sequence :name do |n|
    "Name #{n}"
  end

  sequence :content do |n|
    "Lorem Ipsum #{n}"
  end

  sequence :ip do |n|
    "192.168.93.12#{n[0]}"
  end

  sequence :model_id do |n|
    n
  end

  sequence :email do |n|
    "person_#{n}_@example.com"
  end

end