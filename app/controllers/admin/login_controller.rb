class Admin::LoginController < ApplicationController
  def new
    redirect_to admin_tasks_path if current_user
  end

  def create
    user = User.find_by(name: params[:login][:name])
    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id
      if user.position == "user"
        redirect_to tasks_path, notice: "Logged in successfully"
      else
        redirect_to admin_users_path, notice: "Logged in successfully"
      end
    else
      # Create an error message.
      render 'new', notice: "Incorrect email or password, try again."
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: "Logged out!"
  end
end
