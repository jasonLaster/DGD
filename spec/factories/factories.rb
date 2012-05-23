
FactoryGirl.define do

  factory :group do |f|
    f.sequence(:name) {|n| "Group-#{n}"}
  end

  factory :description do |f|
    f.group
    f.description "lorem ipsum"
  end

  factory :user do
  end

  factory :category do |f|
    f.sequence(:category) {|n| "Category-#{n}"}
  end

end