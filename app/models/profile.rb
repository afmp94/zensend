# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint(8)        not null, primary key
#  phone      :string
#  otp        :boolean
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Profile < ApplicationRecord
  belongs_to :user
  #validates :phone, phone: true

  def otp_enabled?
    otp
  end

  def enable_otp
    transaction do
      code, valid = OTP::sendOTP(self.phone)
      Code.create(user: self.user, code: code, validtime: valid)
    end
  end
end
