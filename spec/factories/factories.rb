
FactoryGirl.define do

  factory :group do
    sequence(:name) {"Group-#{n}"}
  end

  factory :description do
    group
    description "lorem ipsum"
  end
  
end