require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get splash" do
    get :splash
    assert_response :success
  end

  test "should get account" do
    get :account
    assert_response :success
  end

  test "should get concierge" do
    get :concierge
    assert_response :success
  end

  test "should get contact_us" do
    get :contact_us
    assert_response :success
  end

  test "should get detail" do
    get :detail
    assert_response :success
  end

  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get listing" do
    get :listing
    assert_response :success
  end

  test "should get queue" do
    get :queue
    assert_response :success
  end

  test "should get signup" do
    get :signup
    assert_response :success
  end

end
