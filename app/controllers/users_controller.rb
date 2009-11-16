class UsersController < ApplicationController
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @page = Page.find_by_permalink("member-login") rescue ""
    @user = User.new
    @metatag_object = @page
  end
  
  def create
    @user = User.new(params[:user])
    @user.build_order
    if @user.save
      role = Role.find_or_create_by_name('user')
      @user.roles << role
      flash[:notice] = I18n.t(:success_create)
      redirect_to questionnaire_step1_path
    else
      render :action => 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    redirect_to user_path(current_user) if @user != current_user
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = I18n.t(:success_update)
      redirect_to user_path(@user)
    else
      render :action => "edit"
    end 
  end
  
  private
  def require_user
    unless current_user
      store_location
      flash[:error] = I18n.t(:not_authorized)
      redirect_to login_url
      return false
    end
  end
end
