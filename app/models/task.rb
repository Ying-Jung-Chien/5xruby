class Task < ApplicationRecord
  belongs_to :user
  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy

  SORT_COLUMN_LIST = %w[header content priority status start_time end_time created_at].freeze
  STATUA_OPTION_HASH = { all: '3', pending: '2', processing: '1', solved: '0' }.freeze

  validates :header, presence: true
  validates :content, presence: true
  validates :priority, presence: true
  validates :status, presence: true
  validates :start_time, presence: true
  validates :end_time, comparison: { greater_than: :start_time }

  scope :with_id, ->(id) { where("user_id = ?", id) }
  scope :with_header, ->(search_content) { where("header LIKE ?", "%#{search_content}%") }
  scope :with_content, ->(search_content) { where("content LIKE ?", "%#{search_content}%") }
  scope :with_status, ->(status) { where(status: status) }

  def tag_list=(contents)
    self.tags = contents.split(',').map do |item|
      Tag.where(content: item.strip).first_or_create!
    end
  end

  def self.tagged_with(content)
    Tag.find_by!(content: content).tasks
  end

  def tag_list
    tags.map(&:content).join(', ')
  end

  def tag_items
    tags.map(&:content)
  end
end
