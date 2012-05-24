require 'spec_helper'

describe Category do
  before(:all) do
  end

  after(:all) do
    [Group, User, Category, Description].each do |model|
      model.all.each &:destroy
    end
  end


end