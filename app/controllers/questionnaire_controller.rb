class QuestionnaireController < ApplicationController
  before_filter :require_user, :gateway
  
  def step1
    #verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    
    @question1 = Question.find(1)
    @answer1 = Answer.find_or_create_by_question_id_and_order_id(@question1.id, @order.id)
    
    @question2 = Question.find(2)
    @answer2 = Answer.find_or_create_by_question_id_and_order_id(@question2.id, @order.id)
    
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
    #verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    
    @question3 = Question.find(3)
    @answer3 = Answer.find_or_create_by_question_id_and_order_id(@question3.id, @order.id)
    
    @question4 = Question.find(4)
    @answer4 = Answer.find_or_create_by_question_id_and_order_id(@question4.id, @order.id)
    
    @order.inventors.build
    
    @inventors = Inventor.all(:conditions => ["order_id = ?", @order.id])
    
    if request.post?
      @answer3_check = Answer.create_or_update({:order_id => params[:order][:order_id], :question_id => @question3.id, :body => params[:answer3][:body]})
      @answer4_check = Answer.create_or_update({:order_id => params[:order][:order_id], :question_id => @question4.id, :body => "#{params[:inventors][:first_name]} #{params[:inventors][:last_name]}"}) if params[:inventors]
      
      @inventor = Inventor.create({:order_id => params[:order][:order_id], :first_name => params[:inventor][:first_name], :middle_name => params[:inventor][:middle_name], :last_name => params[:inventor][:last_name], :citizenship => params[:inventor][:citizenship], :street_address => params[:inventor][:street_address], :city => params[:inventor][:city], :state => params[:inventor][:state], :zipcode => params[:inventor][:zipcode], :email => params[:inventor][:email], :phone => params[:inventor][:phone]}) unless params[:inventor][:first_name].empty?
      
      if @answer3_check
        flash[:notice] = I18n.t(:success_update)
        if params[:order][:save_and_exit] == "yes"
          redirect_to logout_path
        else
          if params[:more_inventor] == "yes"
            flash[:notice] = "Please add the other inventor."
            redirect_to questionnaire_step2_path
          else
            redirect_to questionnaire_step3_path
          end
        end
      end
    end
  end
  
  def step3
    #verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    
    @question5 = Question.find(5)
    @answer5 = Answer.find_or_create_by_question_id_and_order_id(@question5.id, @order.id)
    
    @question6 = Question.find(6)
    @answer6 = Answer.find_or_create_by_question_id_and_order_id(@question6.id, @order.id)
    
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
    #verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    
    @question7 = Question.find(7)
    @answer7 = Answer.find_or_create_by_question_id_and_order_id(@question7.id, @order.id)
    
    @question8 = Question.find(8)
    @answer8 = Answer.find_or_create_by_question_id_and_order_id(@question8.id, @order.id)
    
    @question9 = Question.find(9)
    @answer9 = Answer.find_or_create_by_question_id_and_order_id(@question9.id, @order.id)
    
    if request.post?
      @answer7_check = Answer.create_or_update({:order_id => params[:order][:order_id], :question_id => @question7.id, :body => params[:answer7][:body]})
      @answer8_check = Answer.create_or_update({:order_id => params[:order][:order_id], :question_id => @question8.id, :body => params[:answer8][:body]})
      @answer9_check = Answer.create_or_update({:order_id => params[:order][:order_id], :question_id => @question9.id, :body => params[:answer9][:body]})
      if @answer7_check and @answer8_check and @answer9_check
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
    #verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    
    @question10 = Question.find(10)
    @answer10 = Answer.find_or_create_by_question_id_and_order_id(@question10.id, @order.id)
    
    if request.post?
      @answer10_check = Answer.create_or_update({:order_id => params[:order][:order_id], :question_id => @question10.id, :body => params[:answer10][:body]})
      if @answer10_check
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
    #verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    
    @question11 = Question.find(11)
    @answer11 = Answer.find_or_create_by_question_id_and_order_id(@question11.id, @order.id)
    
    if request.post?
      @answer11_check = Answer.create_or_update({:order_id => params[:order][:order_id], :question_id => @question11.id, :body => params[:answer11][:body]})
      if @answer11_check
        flash[:notice] = I18n.t(:success_update)
        if params[:order][:save_and_exit] == "yes"
          redirect_to logout_path
        else
          redirect_to questionnaire_step7_path
        end
      end
    end
  end
  
  def step7
    #verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    
    @question12 = Question.find(12)
    @answer12 = Answer.find_or_create_by_question_id_and_order_id(@question12.id, @order.id)
    
    if request.post?
      @answer12_check = Answer.create_or_update({:order_id => params[:order][:order_id], :question_id => @question12.id, :body => params[:answer12][:body]})
      if @answer12_check
        flash[:notice] = I18n.t(:success_update)
        if params[:order][:save_and_exit] == "yes"
          redirect_to logout_path
        else
          redirect_to questionnaire_step8_path
        end
      end
    end
  end
  
  def step8
    #verify_questionnaire_on_hold
    @page = Page.find_by_permalink("questionnaire")
    
    @question13 = Question.find(13)
    @answer13 = Answer.find_or_create_by_question_id_and_order_id(@question13.id, @order.id)
    
    @question14 = Question.find(14)
    @answer14 = Answer.find_or_create_by_question_id_and_order_id(@question14.id, @order.id)
    
    @drawings = Drawing.all(:conditions => ["order_id = ?", @order.id])
    
    @drawing1 = @drawings.first
    @drawing2 = @drawings.second
    @drawing3 = @drawings.third
    
    if request.post?
      @drawing1 = Drawing.create_or_update({:order_id => params[:order][:order_id], :position => 1, :image => params[:drawing1][:image]}) if params[:drawing1]
      @drawing2 = Drawing.create_or_update({:order_id => params[:order][:order_id], :position => 2, :image => params[:drawing2][:image]}) if params[:drawing2]
      @drawing3 = Drawing.create_or_update({:order_id => params[:order][:order_id], :position => 3, :image => params[:drawing3][:image]}) if params[:drawing3]
      #if @drawing1 or @drawing2 or @drawing3
        @answer14_check = Answer.create_or_update({:order_id => params[:order][:order_id], :question_id => @question14.id, :body => params[:answer14][:body]})
        flash[:notice] = I18n.t(:success_update)
        if params[:order][:save_and_exit] == "yes"
          redirect_to logout_path
        else
          if params[:answer14][:body] == "Yes"
            redirect_to questionnaire_terms_path(:combo => true)
          else
            redirect_to questionnaire_terms_path
          end
        end
      #end
    end
  end
  
  def terms
    @question1 = Question.find(1)
    @answer1 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question1.id])
    
    @question2 = Question.find(2)
    @answer2 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question2.id])
    
    @question3 = Question.find(3)
    @answer3 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question3.id])
    
    @question4 = Question.find(4)
    @answer4 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question4.id])
    @inventors = Inventor.all(:conditions => ["order_id = ?", @order.id])
    
    @question5 = Question.find(5)
    @answer5 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question5.id])
    
    @question6 = Question.find(6)
    @answer6 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question6.id])
    
    @question7 = Question.find(7)
    @answer7 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question7.id])
    
    @question8 = Question.find(8)
    @answer8 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question8.id])
    
    @question9 = Question.find(9)
    @answer9 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question9.id])
    
    @question10 = Question.find(10)
    @answer10 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question10.id])
    
    @question11 = Question.find(11)
    @answer11 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question11.id])
    
    @question12 = Question.find(12)
    @answer12 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question12.id])
    
    @question13 = Question.find(13)
    @answer13 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question13.id])
    
    @question14 = Question.find(14)
    @answer14 = Answer.first(:conditions => ["order_id = ? AND question_id = ?", @order.id, @question14.id])
    
    @page = Page.find_by_permalink("review-your-answers")
    @terms = Page.find_by_permalink("terms-of-service")
    
    if request.post?
      if params[:accept]
        @order.accept_terms!
        @user = current_user
        Mailer.deliver_provisional_patent_questionnaire(@user, @order, @terms, @inventors, @question1, @answer1, @question2, @answer2, @question3, @answer3, @question4, @answer4, @question5, @answer5, @question6, @answer6, @question7, @answer7, @question8, @answer8, @question9, @answer9, @question10, @answer10, @question11, @answer11, @question12, @answer12, @question13, @answer13, @question14, @answer14)
        if params[:combo]
          @order.update_attribute(:total, Configuration.first.combo_patent_price)
          redirect_to questionnaire_payment_path(:combo => true)
        else
          @order.update_attribute(:total, Configuration.first.service_price)
          redirect_to questionnaire_payment_path
        end
      else
        flash[:error] = "You must accept the terms to continue."
      end
    end
  end
  
  def payment
    @warning = Configuration.first if Configuration.first.questionnaire_on_hold
    if params[:combo]   
      @cart = GoogleCheckout::Cart.new(MERCHANT_ID, MERCHANT_KEY)
      @cart.add_item(:name => "COMBO - Provisional Patent Questionnaire of #{@order.user.name}", :description => "Email: #{@order.user.email} | Finished on #{Time.now} - User signed to Patent Search Together", :price => @order.total)
    else
      @cart = GoogleCheckout::Cart.new(MERCHANT_ID, MERCHANT_KEY)
      @cart.add_item(:name => "Provisional Patent Questionnaire of #{@order.user.name}", :description => "Email: #{@order.user.email} | Finished on #{Time.now}", :price => @order.total)
    end
  end
  
  def save_and_continue
    @question = Question.find(params[:answer][:question_id])
    @answer_check = Answer.create_or_update({:order_id => params[:answer][:order_id], :question_id => params[:answer][:question_id], :body => params[:answer][:body]}) rescue true
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
    @order = Order.find_by_user_id(current_user)
    if @order
      unless current_user
        store_location
        flash[:error] = I18n.t(:not_authorized)
        redirect_to login_url
        return false
      end
    else
      flash[:error] = "You are an administrator user, logout and register as an normal user to proceed."
      redirect_to login_url
    end
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
		GoogleCheckout.use_production
	end
end