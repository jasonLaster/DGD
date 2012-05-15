require 'spec_helper'

describe Category do
  before(:all) do
  end
  
  after(:all) do
    [Group, User, Category, Description].each do |model|
      model.all.each &:destroy
    end
  end
  
  it "#primary_category"
  it "#sub_category"
  it "#groups"
  it "#primary_category_pages"
  it "#primary_categories"
  it "#sub_categories"
  it "#num_pages"
  it "#num_added_pages"
  
  
end