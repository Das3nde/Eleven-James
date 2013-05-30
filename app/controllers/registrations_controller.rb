class RegistrationsController < Devise::RegistrationsController

  layout 'app'

  def new
    @wrapper = "signup"
    super
  end

  def create
    build_resource
    @resource = resource
    @resource.name = params[:name]
    @resource.email = params[:email]
    @resource.password = params[:password]
    @resource.password_confirmation = params[:confirm_password]
    @resource.valid?
    puts @resource.errors.full_messages.join("__")
    if @resource.errors.keys.length == 0
      @resource.save
    end
    render json: {done: "sf"}
  end


end