FactoryGirl.define do
  factory :member do
    first_name {Faker::Name.first_name}
    association :team
    association :group
  end
end
