# frozen_string_literal: true

class RootController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :verify_session

  def index; end

  private

  def verify_session
    if current_user&.otp
      unless current_user.validate_otp_login
        redirect_to otp_login_path, notice: 'Please validate One Time Password'
      end
    end
  end
end
