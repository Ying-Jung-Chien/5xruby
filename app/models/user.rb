class User < ApplicationRecord
  before_destroy :check_supervisor
  has_many :tasks

  has_secure_password
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true, format: { with: /[A-Za-z\d]{8,}/, message: :invalid_password }
  validates :position, presence: true, inclusion: { in: %w[user supervisor] }

  private

  def check_supervisor
    throw(:abort) if User.where(position: 'supervisor').count < 2 && position == "supervisor"
  end
end
