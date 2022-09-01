class LoginController < ApplicationController
    def new
    end
  
    def create
      user = User.find_by(name: params[:login][:name])
      if user && user.authenticate(params[:login][:password])
        session[:user_id] = user.id
        session[:login] = true
        redirect_to tasks_path, notice: "Logged in successfully"
      else
        # Create an error message.
        render 'new', notice: "Failed"
      end
    end
  
    def destroy
    end
end
