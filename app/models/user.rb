class User < ApplicationRecord
  # has_many :tasks
  validates :name, presence: true
  validates :password, presence: true, format: { with: /[A-Za-z\d]{8,}/, message: " only accepts:length >= 8, at least one digit & lower/upper character" }
  validates :position, presence: true, inclusion: { in: %w[user supervisor] }
end
