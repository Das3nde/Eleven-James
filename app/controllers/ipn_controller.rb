class IpnController < ApplicationController

  protect_from_forgery except: :index

  def index
    Notify.ipn(params).deliver

    case params["txn_type"]

    when 'web_accept'
      if params["payment_status"] == 'Completed'
        user = User.where("username = ? ", params["last_name"]).first
        payment = Payment.where("user_id = ? and purpose = 'signup'", user.id).first
        payment.ipn_status = params["payment_status"]
        payment.ipn_response_dump = params
        payment.save
      end

    when 'recurring_payment'
      user = User.where("username = ? ", params["last_name"]).first
      payment = Payment.where("txn_id = ? and purpose = 'recurring'", params['txn_id']).first
      if payment.blank?
        payment = Payment.new({user_id: user.id, purpose: 'recurring'})
        payment.amount = params['amount']
        payment.ipn_status = params["payment_status"]
        payment.status = params["payment_status"] == 'Completed' ? 'success' : 'failed'
        payment.txn_id = params['txn_id']
        payment.ipn_response_dump = params
        payment.save
        user.extend_activation
      end

    end
    render text: "IPN"
  end

end
