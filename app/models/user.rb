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
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :transit_table, :username, :payment_mode

  validates :name, presence: true
  validates :username, presence: true
  validates_uniqueness_of :username, case_sensitive: false
  validates :payment_mode, presence: true

  has_one :billing_address, :as => :addressable
  has_many :shipping_addresses, :as => :addressable
  has_many :rotations
  has_many :comments, :dependent => :destroy
  has_many :product_requests, :dependent => :destroy

  SUBSCRIPTION_MONTHLY_CHARGE = 925
  SUBSCRIPTION_YEARLY_CHARGE = 1000

  before_validation :strip_username

  def strip_username
    self.username = self.username.to_s.strip
  end

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

  def signup_amount
    case self.payment_mode
    when 'monthly'
      #first payment is for 3 months then recurring is for 1 month
      3 * SUBSCRIPTION_MONTHLY_CHARGE.to_i
    when 'yearly'
      SUBSCRIPTION_YEARLY_CHARGE.to_i
    else
      0
    end
  end

  def approved_and_active?
    self.approved == true and self.paid_till > Time.now
  end

  def approve
    return if self.approved == true

    #capture payment first approval and clear up the token
    if not self.paypal_authorization_token.blank?
      status = Payment.signup_payment(self.id, self.signup_amount, self.paypal_authorization_token)
      self.paypal_authorization_token = nil
      self.save
      self.extend_activation
    end

    self.approved = true
    #TODO: approval date
    self.save

    #activate recurring as it is suspended while signing up
    if not self.paypal_profile_id.blank?
      gateway = Payment.paypal_gateway
      gateway.reactivate_recurring(self.paypal_profile_id)
    end
  end

  def extend_activation
    activation_till = self.paid_till
    activation_till ||= Time.now
    case self.payment_mode
    when 'monthly'
      self.paid_till = 3.months.since(activation_till)
    when 'yearly'
      self.paid_till = 1.year.since(activation_till)
    end
  end

  def unapprove
    self.approved = false
    #TODO: unapproval date
    self.save
    if not self.paypal_profile_id.blank?
      gateway = Payment.paypal_gateway
      gateway.suspend_recurring(self.paypal_profile_id)
    end
  end

  def next_recurring_date
    payment = Payment.where("user_id = ? AND status IN (?)", self.id, ['pending', 'success']).order("created_at DESC").first

    start_time = payment.blank? ? Time.now : payment.created_at

    case self.payment_mode
    when 'monthly'
      next_date = 3.months.since(start_time)
    when 'yearly'
      next_date = 1.year.since(start_time)
    end

    next_date
  end

  def recurring_metrics
    case self.payment_mode
    when 'monthly'
      period = 'Month'
      frequency = 1
      amount = SUBSCRIPTION_MONTHLY_CHARGE.to_i

    when 'yearly'
      period = 'Year'
      frequency = 1
      amount = SUBSCRIPTION_YEARLY_CHARGE.to_i
    end

    [period, frequency, amount]
  end

  def initialize_recurring_payment(cc_details, request_ip, f_name, l_name)
    gateway = Payment.paypal_gateway

    credit_card = ActiveMerchant::Billing::CreditCard.new(
      :type               => cc_details[:cc_type],
      :number             => cc_details[:cc_num],
      :verification_value => cc_details[:cvv],
      :month              => cc_details[:expiry_month],
      :year               => cc_details[:expiry_year],
      :first_name         => f_name,
      :last_name          => l_name
    )

    next_date = self.next_recurring_date
    period, frequency, amount = self.recurring_metrics

    recurring_options = {
      start_date: next_date,
      period: period,
      frequency: frequency,
      description: 'ElevenJames recurring payment'
    }
    response = gateway.recurring(amount * 100, credit_card, recurring_options)

    if response.success?
      profile_id = response.params['profile_id']
      self.paypal_profile_id = profile_id
      self.save
      #suspend recurring for now as it will be reactivated after admin approval
      gateway.suspend_recurring(profile_id)
    end

  end

end
