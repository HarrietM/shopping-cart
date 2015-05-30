class Product < ActiveRecord::Base
  # Remember to create a migration!
  validates_presence_of :name, :description, :price
  has_many :ordered_products
  has_many :orders, through: :ordered_products
end
