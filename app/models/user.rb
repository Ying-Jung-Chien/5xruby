class User < ApplicationRecord
  # has_many :tasks
  validates :name, presence: true
  validates :password, presence: true, format: { with: /[A-Za-z\d]{8,}/ }
  validates :position, presence: true, format: { with: /[(user)pvio]/ }
end
