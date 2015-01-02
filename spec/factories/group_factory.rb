FactoryGirl.define do
  factory :group do
    name 'Default'
    association :team
  end
end
