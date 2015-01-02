FactoryGirl.define do
  factory :group do
    name 'Default'
    association :user
  end
end
