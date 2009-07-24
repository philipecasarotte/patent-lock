class QuestionnaireController < ApplicationController
  before_filter :require_user, :verify_questionnaire_on_hold
  
  def questions
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end
  
  def save_and_continue
    @question = Question.find(params[:answer][:question_id])
    @answer_check = Answer.first(:conditions => {:order_id => params[:answer][:order_id], :question_id => params[:answer][:question_id]})
    if @answer_check.present?
      #update
      if @answer_check.update_attribute("body", "#{params[:answer][:body]}")
        flash[:notice] = I18n.t(:success_update)
        redirect_to questionnaire_questions_path("questions", @question.id+1)
      end
    else
      #create
      @answer = Answer.new(:question_id => params[:answer][:question_id], :order_id => params[:answer][:order_id], :body => params[:answer][:body])
      if @answer.save
        flash[:notice] = I18n.t(:success_create)
        redirect_to questionnaire_questions_path("questions", @question.id+1)
      end
    end
  end
  
  def on_hold
    @page = Configuration.first
  end
  
  def verify_questionnaire_on_hold
    @order = Order.find_by_user_id(current_user)
    if @order.state == "pending_answers" and Configuration.first.questionnaire_on_hold == true
      redirect_to on_hold_path
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