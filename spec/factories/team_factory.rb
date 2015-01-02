FactoryGirl.define do
  factory :team do
    sequence(:username) { |n| "best_team_#{n}" }
    sequence(:display_name) { |n| "Best Team #{n}" }
    sequence(:email) { |n| "best#{n}@team.com" }
    password 'bestteampassword'
  end
end
