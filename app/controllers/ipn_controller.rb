class IpnController < ApplicationController

  protect_from_forgery except: :index

  def index
    Notify.ipn(params).deliver

    case params[:payment_type]
    when 'instant'
      user = User.where("username = ? ", params[:last_name]).first
      payment = Payment.where("user_id = ? and purpose = 'signup'", user.id).first
      payment.ipn_status = params[:payment_status]
      payment.status = 'success' if params[:payment_status] == 'Completed'
      payment.ipn_response_dump = params
      payment.save
    end
    render text: "IPN"
  end

end
