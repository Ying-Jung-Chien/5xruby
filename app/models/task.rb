class Task < ApplicationRecord
  # belongs_to :user
  # has_many :tags

  SORT_COLUMN_LIST = %w[id header content priority status start_time end_time created_at].freeze

  validates :header, presence: true
  validates :content, presence: true
  validates :priority, presence: true, numericality: { only_integer: true, greater_than: -1, less_than: 3 }
  validates :status, presence: true, numericality: { only_integer: true, greater_than: -1, less_than: 3 }
  validates :start_time, presence: true
  validates :end_time, presence: true, comparison: { greater_than: :start_time }

  def self.search(method, params = {}, session = {})
    if method == 1
      Task.where("header LIKE ? AND status = ?", "%" + params[:search] + "%", session[:option]).order("#{session[:sort]} #{session[:dir]}")
    elsif method == 2
      Task.where("header LIKE ?", "%" + params[:search] + "%").order("#{session[:sort]} #{session[:dir]}")
    elsif method == 3
      Task.where("status = ?", session[:option]).order("#{session[:sort]} #{session[:dir]}")
    elsif method == 4
      Task.order("#{params[:sort]} #{params[:dir]}")
    else
      Task.order("#{session[:sort]} #{session[:dir]}")
    end
  end

  def get_status()
    status
  end
end
