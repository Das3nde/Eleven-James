class IpnController < ApplicationController

  protect_from_forgery except: :index

  def index
    Notify.ipn(params).deliver
    render text: "IPN"
  end

end
