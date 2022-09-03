class Admin::TasksController < ApplicationController
  before_action :authorize
  def index
    pre_assign_session
    tasks = search_tasks
    @tasks = tasks.order("#{session[:sort]} #{session[:dir]}")
  end

  private

  def task_params
    params.require(:task).permit(:header, :content, :priority, :status, :start_time, :end_time)
  end

  def pre_assign_session
    session_info = { dir: 'asc', option: '3', sort: 'id' }
    session_info.each { |key, value| saved_by_session(key, value) }
  end

  def saved_by_session(arg, value)
    if !request.query_string.present?
      session[arg] = value
    elsif params[arg].present?
      session[arg] = params[arg]
    end
  end

  def search_tasks
    tasks = Task.includes(:user).page(params[:page]).where("header LIKE ?", "%#{params[:search]}%")
    tasks = tasks.where("status = ?", session[:option]) if session[:option] != '3'
    tasks
  end
end
