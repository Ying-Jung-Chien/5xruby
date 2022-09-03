class User < ApplicationRecord
  before_destroy :check_supervisor
  has_many :tasks

  has_secure_password
  validates :name, presence: true, uniqueness: true
  validates :password, presence: true, format: { with: /[A-Za-z\d]{8,}/, message: " only accepts:length >= 8, at least one digit & lower/upper character" }
  validates :position, presence: true, inclusion: { in: %w[user supervisor] }

  private

  def check_supervisor
    raise "Destroy aborted; you can't do that!" if User.where(position: 'supervisor').count < 2 && position == "supervisor"
  end
end
