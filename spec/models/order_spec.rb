require_relative '../spec_helper'

describe Order do
  it "has many ordered_products" do
    should have_many(:ordered_products)
  end
  it "has many products" do
    should have_many(:products)
  end
  it "belong to a user" do
    should belong_to(:user)
  end
end