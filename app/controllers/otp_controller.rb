class OtpController < ApplicationController
  before_action :get_code, only: [:validate]
  before_action :current_user_codes, only: [:generate, :validate]

  # one user can generate up to 5 codes in 5 minutes. current scenario

  def generate
    exceed = @current_user_codes.exceed_last_minutes.count >= OTP::VALID_CODES
    render :enable, notice: 'you exceed the quota. please try again with the codes previously generated.' if exceed
    current_user.enable_otp
  end

 #form for fill the code and see if this is correct or not
  def enable
  end

  # new
  def validate
    # The current implementation does not validate how many attempts
    # the user validates a code
    code = @current_user_codes.find_by_code(@code)
    case code
    when code.nil?
      render :enable, notice: 'this code is not valid. please try again.'
    when !code.still_valid?
      code.validate
      render :enable, notice: 'this code is not valid anymore. please try again'
    when code.still_valid?
      code.validate
      current_user.update(otp: true)
      render :status, notice: 'this code is valid. 2fa enabled successfully.'
    else
      render :enable, notice: 'Please try again.'
    end
  end

  def disable
    current_user.update(otp: false)
  end

  def status
    @status = current_user.otp
  end

  private

  def get_code
    @code = params[:code]
  end

  def current_user_codes
    @current_user_codes = Code.from_user(current_user)
  end
end
