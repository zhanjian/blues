class UsersController < ApplicationController
  def new
    @user = User.new
    @signup = true
    render layout: "users_form"
  end

  def create
    @user = User.new(user_params)
    debugger
    if @user.save
      flash[:success] = "#{t('.successfully')}"
      respond_to do |format|
          format.html { redirect_to root_path }
          format.js
      end
    else
      respond_to do |format|
        format.html { render 'new' }
        format.js
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
