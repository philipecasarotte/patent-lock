class UserSessionsController < ApplicationController

  def new
    if current_user
      redirect_to user_path(current_user)
    else
      @user_session = UserSession.new
    end
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = I18n.t(:login_message)
      redirect_back_or_default user_path(current_user)
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = I18n.t(:logout_message)
    redirect_back_or_default login_url
  end

end
