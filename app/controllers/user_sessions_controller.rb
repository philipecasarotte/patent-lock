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
      if current_user.order
        case current_user.order.state
          when "pending_answers"
            redirect_to questionnaire_questions_path("questions", Question.first.position)
          when "pending_terms"
            redirect_to questionnaire_terms_path
          when "pending_payment"
            redirect_to questionnaire_payment_path
          when "pending_confirmation"
            redirect_to questionnaire_confirmation_path
          when "confirmed"
            redirect_to questionnaire_thankyou_path
          else
            redirect_to user_path(current_user)
        end
      else
        redirect_to user_path(current_user)
      end
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
