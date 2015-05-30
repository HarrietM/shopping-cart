class Order < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  has_many :ordered_products
  has_many :products, through: :ordered_products
end
