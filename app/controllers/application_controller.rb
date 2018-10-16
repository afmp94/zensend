# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :verify_session!

  private

  def verify_session!
    if current_user
      if !current_user.validate_session
        sign_out current_user
        redirect_to root_path
      end
    end
  end


end
