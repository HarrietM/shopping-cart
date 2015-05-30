class OrderedProduct < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :order
  belongs_to :product
end
