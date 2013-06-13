class Vendor < ActiveRecord::Base
  attr_accessible :address, :address, :city, :email, :fax, :name, :phone, :postal_code, :state, :website, :services
  has_many :services

end