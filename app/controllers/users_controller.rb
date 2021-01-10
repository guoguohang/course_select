class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy] # 只有登录的用户才可以修改用户资料
  before_action :correct_user, only: [:edit, :update] # 确保是正确用户，登录的用户1不可以修改用户2的
  before_action :admin_user, only: :destroy # 限制只有管理员才能访问destroy 动作
  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params) 
    if @user.save
      log_in @user
      flash[:success] = "欢迎来到课程管理系统!"
      redirect_to @user
    else
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "个人信息已更新！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "用户删除成功！"
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :email, :major, :department, :password, :password_confirmation, :admin, :teacher)
    end

    # 前置过滤器
    # 确保用户已登录
    def logged_in_user
      unless logged_in?
        flash[:danger] = "请先登录！"
        redirect_to login_url
      end
    end

    # 确保是正确的用户
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    # 确保是管理员
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
