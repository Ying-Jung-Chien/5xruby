class Task < ApplicationRecord
  belongs_to :user
  # has_many :tags

  SORT_COLUMN_LIST = %w[header content priority status start_time end_time created_at].freeze
  STATUA_OPTION_HASH = { all: '3', pending: '2', processing: '1', solved: '0' }.freeze

  validates :header, presence: true
  validates :content, presence: true
  validates :priority, presence: true
  validates :status, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true, comparison: { greater_than: :start_time }
end
