class SessionsController < ApplicationController

  def new
    @user = User.new
    render layout: "users_form"
  end

  def create
    if @user = login(user_params)
      flash[:success] = "#{t('.successfully')}"
      respond_to do |format|
        format.html { redirect_back_or_to root_path }
        format.js
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :remember_me)
  end

end
