# frozen_string_literal: true

# == Schema Information
#
# Table name: codes
#
#  id         :bigint(8)        not null, primary key
#  code       :string
#  valid      :datetime
#  used       :boolean
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Code < ApplicationRecord
  belongs_to :user

  def validate
    update(used: true)
  end

  def still_valid
    valid > Time.now
  end

  def self.from_user(user)
    where(user: user)
  end

  def self.exceed_last_minutes
    start_time_window = Time.now - OTP::TIME_VALID.minutes
    end_time_window = Time.now
    time_window = [start_time_window..end_time_window]
    where(created_at: time_window)
  end
end
