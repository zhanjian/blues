class UsersController < ApplicationController
  before_action :require_login, only: [ :edit, :update ]
  before_action :find_correct_user, only: [ :edit, :update ]
  before_action :find_user, only: [ :show ]

  def new
    @user = User.new
    @signup = true
    render layout: "users_form"
  end

  def show
    if @user
      @songs = @user.songs.order("created_at desc")
    else
      redirect_to root_path
      flash[:error] = "#{t('.no_user')}"
    end
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

  def edit
  end

  def update
    debugger
    if @user.update_attributes(update_user_params)
      flash[:success] = "#{t('.successfully')}"
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash.now[:error] = "#{t('.faild')}"
      respond_to do |format|
        format.html { render 'edit' }
        format.js
      end
    end
  end

  private

    def find_correct_user
      @user = User.find_by_name(params[:id])
      unless current_user?(@user)
        flash[:warning] = "#{t('permission_denied')}"
        redirect_to root_path
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def find_user
      @user = User.find_by_name(params[:id])
    end

    def not_login_user
      if logged_in?
        redirect_to root_path
        flash[:warning] = "#{t('users.has_already_logged_in')}"
      end
    end

    def update_user_params
      params.require(:user).permit(:bio, :avator, :locale, :password, :password_confirmation)
    end




end
