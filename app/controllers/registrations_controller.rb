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

    @errors = {}
    if @resource.errors.keys.length == 0 and @billing_address.errors.keys.length == 0 and @shipping_address.errors.keys.length == 0
      @resource.save
      @resource.create_billing_address(params[:billing_address])
      @resource.create_shipping_address(params[:shipping_address])
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