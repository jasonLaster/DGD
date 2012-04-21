
FactoryGirl.define do

  factory :group do
    sequence(:name) {|n| "Group-#{n}"}
  end

  factory :description do
    group
    description "lorem ipsum"
  end
  
  factory :user do
  end
  
end