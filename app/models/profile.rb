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

  def otp_enabled?
    self.otp
  end

  def enable_otp
    transaction do
      
    end
  end
end
