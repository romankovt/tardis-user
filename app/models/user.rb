class User < ApplicationRecord
  validates :phone, presence: true, uniqueness: true
  validates :email, uniqueness: true, allow_nil: true
end
