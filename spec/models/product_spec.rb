require_relative '../spec_helper'

describe Product do
  it "has many ordered_products" do
    should have_many(:ordered_products)
  end
  it "has many orders" do
    should have_many(:orders)
  end
  it "validate presence of name" do
    should validate_presence_of(:name)
  end
  it "validate presence of description" do
    should validate_presence_of(:description)
  end
  it "validate presence of price" do
    should validate_presence_of(:price)
  end
end