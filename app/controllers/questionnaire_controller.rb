class QuestionnaireController < ApplicationController
  before_filter :require_user, :gateway
  
  def questions
    verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    @question = Question.find_by_position(params[:position])
    @answer = Answer.find_or_create_by_question_id(@question.id)
  end
  
  def terms
    verify_questionnaire_on_hold
    @answers = @order.answers
    @page = Page.find_by_permalink("review-your-answers")
    @terms = Page.find_by_permalink("terms-of-service")
    if request.post?
      if params[:accept]
        @order.accept_terms!
        Mailer.deliver_provisional_patent_questionnaire(@order)
        redirect_to questionnaire_payment_path
      else
        flash[:error] = "You must accept the terms to continue."
      end
    end
  end
  
  def payment
    verify_questionnaire_on_hold
    @cart = GoogleCheckout::Cart.new(MERCHANT_ID, MERCHANT_KEY)
    @cart.add_item(:name => "Provisional Patent Questionnaire of #{@order.user.name}", :description => "Email: #{@order.user.email} | Finished on #{Time.now}", :price => @order.total)
  end
  
  def save_and_continue
    @question = Question.find(params[:answer][:question_id])
    @answer_check = Answer.create_or_update({:order_id => params[:answer][:order_id], :question_id => params[:answer][:question_id], :body => params[:answer][:body]})
    if @answer_check
      flash[:notice] = I18n.t(:success_update)
      if params[:answer][:save_and_exit] == "yes"
        redirect_to logout_path
      else
        verify_next_step
      end
    end
  end
  
  def on_hold
    @page = Configuration.first
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
  
  def verify_questionnaire_on_hold
    @order = Order.find_by_user_id(current_user)
    if @order.state == "pending_answers" and Configuration.first.questionnaire_on_hold == true
      redirect_to questionnaire_on_hold_path
    end
  end
  
  def verify_next_step
    @next_question = Question.find(@question.id)
    @next_question = Question.find_by_position(@next_question.next) rescue ""
    if @next_question.present?
       redirect_to questionnaire_questions_path("questions", @next_question.position)
    else
       @order.answer!
       redirect_to questionnaire_terms_path
    end
  end
  
  def gateway
		GoogleCheckout.use_sandbox
	end
end