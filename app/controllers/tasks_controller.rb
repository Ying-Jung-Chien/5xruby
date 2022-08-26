class TasksController < ApplicationController
  def index
    if params[:search]
      search_header
    end
    @tasks = Task.order("#{params[:sort]} #{params[:dir]}")
  end

  def search_header
    if @task = Task.find{|task| task.header.include?(params[:search])}
      redirect_to task_path(@task)
    end
  end

  def show
    @task = Task.find_by(id: params[:id])
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
end
