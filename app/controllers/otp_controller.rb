# frozen_string_literal: true

class OtpController < ApplicationController
  before_action :get_code, only: %i[validate login_validate]
  before_action :current_user_codes, only: %i[generate validate login_generate login_validate]
  before_action :verify_session, except: %i[login login_generate login_validate]

  # one user can generate up to 5 codes in 5 minutes. current scenario
  def generate
    exceed = @current_user_codes.exceed_last_minutes.count >= OTP::VALID_CODES
    if exceed
      redirect_to otp_enable_path, notice: 'you exceed the quota. please try again with the codes previously generated.'
    else
      current_user.send_otp
      redirect_to otp_enable_path, notice: 'code generated.'
    end
 end

  # form for fill the code and see if this is correct or not
  def enable; end

  def login_validate
    # The current implementation does not validate how many attempts
    # the user validates a code
    code = @current_user_codes.find_by_code(@code)
    if code.nil?
      redirect_to otp_login_path, notice: 'this code is not valid. please try again.'
    elsif code.still_valid
      code.validate
      redirect_to root_path, notice: 'The validation was successful'
    else
      code.validate
      redirect_to otp_login_path, notice: 'this code is not valid anymore. please try again'
    end
  end

  def login_generate # to refactor for DRY
    exceed = @current_user_codes.exceed_last_minutes.count >= OTP::VALID_CODES
    if exceed
      redirect_to otp_enable_path, notice: 'you exceed the quota. please try again with the codes previously generated.'
    else
      current_user.send_otp
      redirect_to otp_enable_path, notice: 'code generated.'
    end
  end

  def login; end

  def validate
    # The current implementation does not validate how many attempts
    # the user validates a code
    code = @current_user_codes.find_by_code(@code)
    if code.nil?
      redirect_to otp_enable_path, notice: 'this code is not valid. please try again.'
    elsif code.still_valid
      code.validate
      current_user.profile.update(otp: true)
      redirect_to otp_status_path, notice: 'this code is valid. 2fa enabled successfully.'
    else
      code.validate
      redirect_to otp_enable_path, notice: 'this code is not valid anymore. please try again'
    end
  end

  def disable
    current_user.profile.update(otp: false)
    redirect_to otp_status_path, notice: '2fa disabled'
  end

  def status
    @profile = current_user.profile
    @status = current_user.otp
  end

  private

  def get_code
    @code = params[:code]
  end

  def current_user_codes
    @current_user_codes = Code.from_user(current_user)
  end

  def verify_session
    if current_user&.otp
      unless current_user.validate_otp_login
        redirect_to otp_login_path, notice: 'Please validate One Time Password.'
      end
    end
  end
end
