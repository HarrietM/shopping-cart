require_relative '../spec_helper'

describe User do
  it "has many orders" do
    should have_many(:orders)
  end
  it "has a secure password" do
    should have_secure_password
  end
  it "validate presence of name" do
    should validate_presence_of(:name)
  end
  it "validate presence of email" do
    should validate_presence_of(:email)
  end
  it "validate presence of address" do
    should validate_presence_of(:address)
  end
  it "validate uniqueness of email" do
    should validate_uniqueness_of(:email)
  end
end