# == Schema Information
#
# Table name: codes
#
#  id         :bigint(8)        not null, primary key
#  code       :string
#  valid      :boolean
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Code < ApplicationRecord
  belongs_to :user
end
