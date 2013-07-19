class Payment < ActiveRecord::Base

  validates :user_id, presence: true
  validates :amount, presence: true
  validates :purpose, presence: true

  serialize :paypal_response_dump, :ipn_response_dump


  def self.authorization(amount, cc_details, request_ip, f_name, l_name)
    gateway = self.paypal_gateway

    credit_card = ActiveMerchant::Billing::CreditCard.new(
      :type               => cc_details[:cc_type],
      :number             => cc_details[:cc_num],
      :verification_value => cc_details[:cvv],
      :month              => cc_details[:expiry_month],
      :year               => cc_details[:expiry_year],
      :first_name         => f_name,
      :last_name          => l_name
    )

    errors = []
    token = ''
    if credit_card.valid?
      response = gateway.authorize(amount * 100, credit_card, :ip => request_ip)
      if response.success?
        token =  response.authorization
      else
        errors << response.message
      end
    else
      errors << credit_card.errors.full_messages.join('. ')
    end
    return token, errors
  end

  def self.signup_payment(user_id, amount, authorization_token)
    gateway = self.paypal_gateway
    response = gateway.capture(amount * 100, authorization_token)
    obj = new({
                user_id: user_id,
                amount: amount,
                purpose: 'signup'
              })


    if response.success?
      obj.status = 'success'
    else
      obj.status = 'failed'
    end
  end

  private

  def self.paypal_gateway
    ActiveMerchant::Billing::PaypalGateway.new(
          :login => PAYPAL_API_LOGIN,
          :password => PAYPAL_API_PASSWORD,
          :signature => PAYPAL_API_SIGNATURE
        )
  end

end
