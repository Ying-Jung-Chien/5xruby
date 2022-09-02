class TasksController < ApplicationController
  def index
    if current_user.nil?
      redirect_to login_path, notice: "Please login!"
    else
      pre_assign_session
      tasks = search_tasks
      @tasks = tasks.order("#{session[:sort]} #{session[:dir]}")
    end
  end

  def new
    @task = Task.new
  end

  def create
    # temp_user = User.first
    task = current_user.tasks.build(task_params)

    respond_to do |format|
      if task.save
        format.html { redirect_to tasks_path, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])

    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: "Task was successfully edited." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
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
    tasks = Task.includes(:user).page(params[:page]).where("header LIKE ? AND user_id=?", "%#{params[:search]}%", current_user.id)
    tasks = tasks.where("status = ?", session[:option]) if session[:option] != '3'
    tasks
  end
end
