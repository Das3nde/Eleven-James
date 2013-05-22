class Customer < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_customers
  belongs_to :resource, :polymorphic => true
  
  scopify
  # attr_accessible :title, :body
end
