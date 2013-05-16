require 'spec_helper'

describe FedexTransitsController do

  describe "create a pickup preview" do
    it "should be ready to make an api call to fedex" do
      get 'index'
      response.should be_success
    end
  end

end
