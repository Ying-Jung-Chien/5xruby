class Admin::UsersController < ApplicationController
  before_action :authorize_admin
  def index
    @users = User.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # 成功
        format.html { redirect_to admin_users_path, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        # 失敗
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])

      if @user.update(user_params)
        # 成功
        redirect_to admin_users_path, notice: "Success!"
      else
        # 失敗
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    if @user
      @tasks = Task.where('user_id = ?', @user.id)
      @tasks.each(&:destroy)
      @user.destroy
      if User.exists?(id: params[:id])
        redirect_to admin_users_path, notice: "At least one supervisor is required!"
      else
        redirect_to admin_users_path, notice: "Success!"
      end
    else
      redirect_to admin_users_path, notice: "User not exist!"
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def tasks
    @user = User.find_by(id: params[:id])

    pre_assign_session
    tasks = search_tasks(params[:id])
    @tasks = tasks.order("#{session[:sort]} #{session[:dir]}")
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :position)
  end

  def pre_assign_session
    session_info = { dir: 'asc', option: '3', sort: 'id', user_name: '-1', search_by: 'header' }
    session_info.each { |key, value| saved_by_session(key, value) }
  end

  def saved_by_session(arg, value)
    if !request.query_string.present?
      session[arg] = value
    elsif params[arg].present?
      session[arg] = params[arg]
    end
  end

  def search_tasks(id)
    tasks = Task.includes(:user).page(params[:page]).with_id(id)
    tasks = tasks.with_header(params[:search]) if session[:search_by] == "header"
    tasks = tasks.with_content(params[:search]) if session[:search_by] == "content"
    tasks = tasks.with_status(session[:option]) if session[:option] != '3'
    tasks
  end
end
