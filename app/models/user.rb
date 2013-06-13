class User < ActiveRecord::Base
  rolify :role_cname => 'Customer'
  rolify :role_cname => 'Admin'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :role_ids, :as => :admin
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :transit_table

  validates :name, presence: true

  has_one :billing_address, :as => :addressable
  has_one :shipping_address, :as => :addressable
  has_many :rotations

  def requests
    sql = 'fulfillment_time is not null and removal_time is not null and user_id = ?'
    ProductRequest.where(sql, id).to_a.map{|req|
      req.product.toVector()
    }
  end
end
