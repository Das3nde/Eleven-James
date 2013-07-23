require "active_merchant"
class RegistrationsController < Devise::RegistrationsController

  layout 'app'

  def new
    @wrapper = "signup"
    super
  end

  def create
    build_resource
    @resource = resource
    @resource.attributes = params[:user]

    @resource.valid?
    @billing_address = BillingAddress.new(params[:billing_address])
    @shipping_address = ShippingAddress.new(params[:shipping_address])
    @billing_address.valid?
    @shipping_address.valid?

    first_name = @resource.name
    last_name = @resource.username
    amount = @resource.signup_amount
    request_ip = request.remote_ip
    cc_details = {  cc_num: params[:cc_num],
                    cc_type: params[:cc_type],
                    cvv: params[:cvv],
                    expiry_month: params[:cc_expiry_month],
                    expiry_year: params[:cc_expiry_year]
                  }

    authorization_token, payment_errors = Payment.authorization(amount, cc_details, request_ip, first_name, last_name)

    @errors = {}
    if @resource.errors.keys.length == 0 and @billing_address.errors.keys.length == 0 and @shipping_address.errors.keys.length == 0 and payment_errors.length == 0
      @resource.paypal_authorization_token = authorization_token
      @resource.save
      @resource.create_billing_address(params[:billing_address])
      @resource.shipping_addresses << ShippingAddress.new(params[:shipping_address])
      @resource.save
      @resource.initialize_recurring_payment(cc_details, request_ip, first_name, last_name)
      sign_in @resource
      @status = true
    else
      @status = false
      @resource.errors.each do |k,v|
        @errors.update({ "user_#{k}" => v})
      end

      @billing_address.errors.each do |k,v|
        @errors.update({ "billing_address_#{k}" => v})
      end

      @shipping_address.errors.each do |k,v|
        @errors.update({ "shipping_address_#{k}" => v})
      end

      @errors.update({"payment_errors" => payment_errors.join(', ')}) if payment_errors.length > 0
    end
    render layout: false
  end


  def destroy_session
    redirect_path = after_sign_out_path_for(resource_name)
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    # set_flash_message :notice, :signed_out if signed_out && is_navigational_format?

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to redirect_path }
    end
  end


end