class User < ActiveRecord::Base

  validates_presence_of :name, :email, :address
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  has_many :orders
  has_secure_password

end
