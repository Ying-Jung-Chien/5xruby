class UsersController < ApplicationController
    def index
        @users = User.all
    end
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
    
        if @user.save
          # 成功
          redirect_to users_path, notice: "Success!"
        else
          # 失敗
          render :new
        end
    end

    def edit
        @user = User.find_by(id: params[:id])
    end

    def update
        @user = User.find_by(id: params[:id])
    
        if @user.update(user_params)
          # 成功
          redirect_to users_path, notice: "Success!"
        else
          # 失敗
          render :edit
        end
    end

    def destroy
        @user = User.find_by(id: params[:id])
        @user.destroy if @user
        redirect_to users_path, notice: "Success!"
    end

    def show
        @user = User.find_by(id: params[:id])
        # @user.destroy if @user
        # redirect_to users_path, notice: "Success!"
    end
    

    private
    def user_params
        params.require(:user).permit(:name, :password, :position)
    end
end
