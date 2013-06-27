class Address < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :address_line, :apt_unit, :city, :state, :zip, :phone, :selected_shipping

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address_line, presence: true
  validates :apt_unit, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :phone, presence: true

  belongs_to :addressable, :polymorphic => true

end
