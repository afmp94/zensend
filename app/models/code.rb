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
    valid > Time.now
  end
end
