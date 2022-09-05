class TasksController < ApplicationController
  before_action :authorize
  def index
    pre_assign_session
    tasks = search_tasks
    @tasks = tasks.order("#{session[:sort]} #{session[:dir]}")
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
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
    params.require(:task).permit(:header, :content, :priority, :status, :start_time, :end_time, :tag_list)
  end

  def pre_assign_session
    session_info = { dir: 'asc', option: '3', sort: 'id', search_by: 'header' }
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
    tasks = search_by_tag
    tasks = tasks.page(params[:page]).with_id(current_user.id)
    tasks = tasks.with_header(params[:search]) if session[:search_by] == "header"
    tasks = tasks.with_content(params[:search]) if session[:search_by] == "content"
    tasks = tasks.with_status(session[:option]) if session[:option] != '3'
    tasks
  end

  def search_by_tag
    if session[:search_by] == "tag" && params[:search].present?
      Task.tagged_with(params[:search]).includes(:user)
    else
      Task.includes(:user)
    end
  end
end
