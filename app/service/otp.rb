# frozen_string_literal: true

class OTP
  LENGTH_RANDOM = 4
  TIME_VALID = 5

  def self.random
    RandomGenerator.only_numbers(LENGTH_RANDOM)
  end

  def self.sendOTP(number)
    SMS.send_sms(random, [number])
  end
end
