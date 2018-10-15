require 'test_helper'

class OtpControllerTest < ActionDispatch::IntegrationTest
  test "should get enable" do
    get otp_enable_url
    assert_response :success
  end

  test "should get validate" do
    get otp_validate_url
    assert_response :success
  end

  test "should get disable" do
    get otp_disable_url
    assert_response :success
  end

  test "should get status" do
    get otp_status_url
    assert_response :success
  end

end
