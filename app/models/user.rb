class User < ApplicationRecord
  # has_many :tasks
  PASSWORD_FORMAT = /\A
  (?=.{8,})          # Must contain 8 or more characters
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  /x
  validates :name, presence: true
  validates :password, presence: true, format: { with: /[A-Za-z\d]{8,}/, message: " only accepts:length >= 8, at least one digit & lower/upper character" }
  validates :position, presence: true, inclusion: { in: %w[user supervisor] }
end
