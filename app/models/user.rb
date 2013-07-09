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
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :transit_table, :username

  validates :name, presence: true
  validates :username, presence: true
  validates_uniqueness_of :username, case_sensitive: false

  has_one :billing_address, :as => :addressable
  has_many :shipping_addresses, :as => :addressable
  has_many :rotations
  has_many :comments, :dependent => :destroy

  def request_vectors
    sql = 'fulfillment_time is null and removal_time is null and user_id = ?'
    reqs = []
    ProductRequest.where(sql, id).to_a.map{|req|
      reqs << req.product.to_vector()
    }
    return reqs.empty? ?  nil : reqs
  end

  def needs_rotation
    rotations = Rotation.where('user_id = ?', id)
    rotations.last == nil || Rotation.last.start_date != nil
  end
end
