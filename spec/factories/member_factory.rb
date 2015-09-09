FactoryGirl.define do
  factory :member do
    first_name 'Roland'
    association :team
    association :group
  end
end
