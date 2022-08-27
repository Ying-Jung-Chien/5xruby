class TasksController < ApplicationController
  def index
    if !params[:dir].present? && !session[:dir].present?
      session[:dir] = 'asc'
    elsif params[:dir].present? 
      session[:dir] = params[:dir]
    end
    
    if !params[:option].present? && !session[:option].present?
      session[:option] = '3'
    elsif params[:option].present? 
      session[:option] = params[:option]
    end

    if !params[:sort].present? && !session[:sort].present?
      session[:sort] = 'id'
    elsif params[:sort].present? 
      session[:sort] = params[:sort]
    end

    # if session[:option] != '3' && params[:search].present?
    #   @tasks = Task.where("header LIKE ? AND status = ?", "%" + params[:search] + "%", session[:option]).order("#{session[:sort]} #{session[:dir]}")
    # elsif params[:search].present?
    #   @tasks = Task.where("header LIKE ?", "%" + params[:search] + "%").order("#{session[:sort]} #{session[:dir]}")
    # elsif session[:option] != '3'
    #   @tasks = Task.where("status = ?", session[:option]).order("#{session[:sort]} #{session[:dir]}")
    # elsif params[:sort].present?
    #   @tasks = Task.order("#{params[:sort]} #{params[:dir]}")
    # else
    #   @tasks = Task.order("#{session[:sort]} #{session[:dir]}")
    # end

    if session[:option] != '3' && params[:search].present?
      @tasks = Task.search(1, params, session)
    elsif params[:search].present?
      @tasks = Task.search(2, params, session)
    elsif session[:option] != '3'
      @tasks = Task.search(3, params, session)
    elsif params[:sort].present?
      @tasks = Task.search(4, params, session)
    else
      @tasks = Task.search(5, params, session)
    end
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
