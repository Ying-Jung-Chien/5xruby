class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        # 成功
        if current_user.nil?
          format.html { redirect_to login_path, notice: "User was successfully created. Please login again!" }
        else
          format.html { redirect_to users_path, notice: "User was successfully created." }
        end
        format.json { render :show, status: :created, location: @user }
      else
        # 失敗
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :position)
  end
end
