class RegistrationsController < Devise::RegistrationsController

  layout 'app'

  def new
    @wrapper = "signup"
    super
  end

  def create
    # add custom create logic here
  end


end