class TasksController < ApplicationController
  def index
    pre_assign_session
    tasks = search_tasks
    @tasks = tasks.order("#{session[:sort]} #{session[:dir]}")
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

      if @task.save
        # 成功
        redirect_to tasks_path, notice: "Success!"
      else
        # 失敗
        render :new, status: :unprocessable_entity
      end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])

      if @task.update(task_params)
        # 成功
        redirect_to tasks_path, notice: "Success!"
      else
        # 失敗
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
      @task.destroy if @task
      redirect_to tasks_path, notice: "Success!"
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
    tasks = Task.page(params[:page]).where("header LIKE ?", "%#{params[:search]}%")
    tasks = tasks.where("status = ?", session[:option]) if session[:option] != '3'
    tasks
  end
end