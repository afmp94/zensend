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
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_profile

  has_one :profile, dependent: :destroy
  has_many :codes, dependent: :destroy

  delegate :enable_otp, :phone, :otp, to: :profile

  private

  def create_profile
    # also can be set the values by default, in the migration
    # depends the business logic
    Profile.create(user: self, phone: '', otp: false)
    # or
    # self.profile.create(phone: '', otp:false)
  end
end
