# frozen_string_literal: true

class OTP
  # the current_user can generate up to VALID_CODES for TIME_VALID minutes
  # and any of this codes can be used for the OTP/2FA.
  # if the user exceed sending VALID_CODES in the TIME_VALID minutes
  # the user can't generate more for the next TIME_VALID minutes
  LENGTH_RANDOM = 4
  TIME_VALID = 5
  VALID_CODES = 5

  def self.random
    RandomGenerator.new.only_numbers(LENGTH_RANDOM)
  end

  def self.sendOTP(number)
    code = OTP::random
    SMS.new.send_sms(code, [number])
    [code, Time.now + TIME_VALID.minutes]
  end
end
