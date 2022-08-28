class Task < ApplicationRecord
  # belongs_to :user
  # has_many :tags

  SORT_COLUMN_LIST = %w[header content priority status start_time end_time created_at].freeze

  validates :header, presence: true
  validates :content, presence: true
  validates :priority, presence: true, numericality: { only_integer: true, greater_than: -1, less_than: 3 }
  validates :status, presence: true, numericality: { only_integer: true, greater_than: -1, less_than: 3 }
  validates :start_time, presence: true
  validates :end_time, presence: true, comparison: { greater_than: :start_time }
end
