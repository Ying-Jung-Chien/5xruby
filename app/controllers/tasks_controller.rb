class TasksController < ApplicationController
  def index
    assign(:dir, 'asc')
    assign(:option, '3')
    assign(:sort, 'id')

    @tasks = if session[:option] != '3' && params[:search].present?
               search(1)
             elsif session[:option] != '3'
               search(2)
             else
               search(3)
             end
  end

  def assign(arg, value)
    if !params[arg].present? && !session[arg].present?
      session[arg] = value
    elsif params[arg].present?
      session[arg] = params[arg]
    end
  end

  def search(method)
    @paginated = Task.page(params[:page])
    case method
    when 1
      @paginated.where("header LIKE ? AND status = ?", "%#{params[:search]}%", session[:option]).order("#{session[:sort]} #{session[:dir]}")
    when 2
      @paginated.where("status = ?", session[:option]).order("#{session[:sort]} #{session[:dir]}")
    else
      @paginated.where("header LIKE ?", "%#{params[:search]}%").order("#{session[:sort]} #{session[:dir]}")
    end

    # @tasks = Task.page(params[:page]).order("#{session[:sort]} #{session[:dir]}")
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
