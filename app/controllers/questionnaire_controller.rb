class QuestionnaireController < ApplicationController
  before_filter :require_user, :gateway
  
  def step1
    verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    
    @question1 = Question.find(1)
    @answer1 = Answer.find_or_create_by_question_id(@question1.id)
    
    @question2 = Question.find(2)
    @answer2 = Answer.find_or_create_by_question_id(@question2.id)
    
    if request.post?
      @answer1_check = Answer.create_or_update({:order_id => params[:order][:order_id], :question_id => @question1.id, :body => params[:answer1][:body]})
      @answer2_check = Answer.create_or_update({:order_id => params[:order][:order_id], :question_id => @question2.id, :body => params[:answer2][:body]})
      if @answer1_check and @answer2_check
        flash[:notice] = I18n.t(:success_update)
        if params[:order][:save_and_exit] == "yes"
          redirect_to logout_path
        else
          redirect_to questionnaire_step2_path
        end
      end
    end
  end
  
  def step2
    verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    
    @question3 = Question.find(3)
    @answer3 = Answer.find_or_create_by_question_id(@question3.id)
    
    @question4 = Question.find(4)
    @answer4 = Answer.find_or_create_by_question_id(@question4.id)
  end
  
  def step3
    verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    
    @question5 = Question.find(5)
    @answer5 = Answer.find_or_create_by_question_id(@question5.id)
    
    @question6 = Question.find(6)
    @answer6 = Answer.find_or_create_by_question_id(@question6.id)
    
    if request.post?
      @answer5_check = Answer.create_or_update({:order_id => params[:order][:order_id], :question_id => @question5.id, :body => params[:answer5][:body]})
      @answer6_check = Answer.create_or_update({:order_id => params[:order][:order_id], :question_id => @question6.id, :body => params[:answer6][:body]})
      if @answer5_check and @answer6_check
        flash[:notice] = I18n.t(:success_update)
        if params[:order][:save_and_exit] == "yes"
          redirect_to logout_path
        else
          redirect_to questionnaire_step4_path
        end
      end
    end
  end
  
  def step4
    verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    
    @question7 = Question.find(7)
    @answer7 = Answer.find_or_create_by_question_id(@question7.id)
    
    if request.post?
      @answer7_check = Answer.create_or_update({:order_id => params[:order][:order_id], :question_id => @question7.id, :body => params[:answer7][:body]})
      if @answer7_check
        flash[:notice] = I18n.t(:success_update)
        if params[:order][:save_and_exit] == "yes"
          redirect_to logout_path
        else
          redirect_to questionnaire_step5_path
        end
      end
    end
  end
  
  def step5
    verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    
    @question8 = Question.find(8)
    @answer8 = Answer.find_or_create_by_question_id(@question8.id)
    
    if request.post?
      @answer8_check = Answer.create_or_update({:order_id => params[:order][:order_id], :question_id => @question8.id, :body => params[:answer8][:body]})
      if @answer8_check
        flash[:notice] = I18n.t(:success_update)
        if params[:order][:save_and_exit] == "yes"
          redirect_to logout_path
        else
          redirect_to questionnaire_step6_path
        end
      end
    end
  end
  
  def step6
    verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    
    @question9 = Question.find(9)
    @answer9 = Answer.find_or_create_by_question_id(@question9.id)
    
    @drawings = Drawing.all(:conditions => ["order_id = ?", @order.id])
    
    @drawing1 = @drawings.first
    @drawing2 = @drawings.second
    @drawing3 = @drawings.third
    
    if request.post?
      @drawing1 = Drawing.create_or_update({:order_id => params[:order][:order_id], :position => 1, :image => params[:drawing1][:image]}) if params[:drawing1]
      @drawing2 = Drawing.create_or_update({:order_id => params[:order][:order_id], :position => 2, :image => params[:drawing2][:image]}) if params[:drawing2]
      @drawing3 = Drawing.create_or_update({:order_id => params[:order][:order_id], :position => 3, :image => params[:drawing3][:image]}) if params[:drawing3]
      if @drawing1 or @drawing2 or @drawing3
        flash[:notice] = I18n.t(:success_update)
        if params[:order][:save_and_exit] == "yes"
          redirect_to logout_path
        else
          redirect_to questionnaire_terms_path
        end
      end
    end
  end
  
  #************* OLD WAY ***************#
  def questions
    verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    @question = Question.find_by_position(params[:position])
    @answer = Answer.find_or_create_by_question_id(@question.id)
  end
  
  def terms
    @question1 = Question.find(1)
    @answer1 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question1.id])
    
    @question2 = Question.find(2)
    @answer2 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question2.id])
    
    @question3 = Question.find(3)
    @answer3 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question3.id])
    
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
    @order = Order.find_by_user_id(current_user)
  end
  
  def verify_questionnaire_on_hold
    @order = Order.find_by_user_id(current_user)
    if Configuration.first.questionnaire_on_hold == true #@order.state == "pending_answers" and 
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