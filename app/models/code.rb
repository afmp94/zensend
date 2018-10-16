# frozen_string_literal: true
# == Schema Information
#
# Table name: codes
#
#  id         :bigint(8)        not null, primary key
#  code       :string
#  validtime  :datetime
#  used       :boolean
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Code < ApplicationRecord
  # this classes can be also developed inside a module. depends business logic
  belongs_to :user

  def validate
    p "entro a validar"
    update(used: true)
  end

  def still_valid
    validtime > Time.now
  end

  def self.used
    where(used: true)
  end

  def self.from_user(user)
    where(user: user)
  end

  def self.exceed_last_minutes(time_window = [Time.now - OTP::TIME_VALID.minutes .. Time.now])
    where(created_at: time_window)
  end
end
