# frozen_string_literal: true
# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  after_create :create_profile

  has_one :profile, dependent: :destroy
  has_many :codes, dependent: :destroy

  delegate :send_otp, :phone, :otp, to: :profile

  def validate_otp_login
    time = current_sign_in_at + OTP::TIME_VALID.minutes
    if profile.otp
      valid_time = [current_sign_in_at..time]
      codes.used.exceed_last_minutes(valid_time).count >= 1
    else
      true
    end
  end

  def validate_session
    time = current_sign_in_at + OTP::TIME_VALID.minutes
    if profile.otp && Time.now > time
      valid_time = [current_sign_in_at.. time]
      codes.used.exceed_last_minutes(valid_time).count >= 1
    else
      true
    end
  end
  private

  def create_profile
    # also can be set the values by default, in the migration
    # depends the business logic
    Profile.create(user: self, phone: '', otp: false)
  end
end
