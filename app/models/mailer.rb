class Mailer < ActionMailer::Base
  
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = {
      :address => "mail.#{SITE_DOMAIN}",
      :port => "25",
      :domain => SITE_DOMAIN,
      :authentication => :login,
      :user_name => "webmaster@#{SITE_DOMAIN}",
      :password => "patent123"
  }
  
  def forgot_password(user, password)
    @recipients = user[:email] if user[:email]
    @from = SITE_EMAIL
    @reply_to = SITE_EMAIL
    @subject = "Password Request #{SITE_DOMAIN}"
    @sent_on = Time.now
    @content_type = 'text/html'
    
    body[:params] = user
    body[:password] = password
  end
  
  def contact(params)
    @recipients = SITE_EMAIL
    @from = params[:email] if params[:email]
    @reply_to = params[:email] if params[:email]
    @subject = I18n.t(:contact_from) + " #{SITE_DOMAIN}"
    @sent_on = Time.now
    @content_type = 'text/html'
    
    body[:params] = params
  end
  
  def new_user_registration(user)
    @recipients = SITE_EMAIL
    @from = user.email if user.email
    @reply_to = user.email if user.email
    @subject = "New User Registration #{SITE_DOMAIN}"
    @sent_on = Time.now
    @content_type = 'text/html'
    
    body[:params] = user
  end
  
  def provisional_patent_questionnaire(user, order,terms,inventors,question1,answer1,question2,answer2,question3,answer3,question4,answer4,question5,answer5,question6,answer6,question7,answer7,question8,answer8,question9,answer9,question10,answer10,question11,answer11,question12,answer12,question13,answer13,question14,answer14)
    @recipients = SITE_EMAIL
    @from = order.user[:email] if order.user
    @reply_to = order.user[:email] if order.user
    @subject = "Provisional Patent Questionnaire #{SITE_DOMAIN}"
    @sent_on = Time.now
    @content_type = 'multipart/alternative'
    
    body[:user] = user
    body[:order] = order
    body[:terms] = terms
    body[:question1] = question1
    body[:answer1] = answer1
    body[:question2] = question2
    body[:answer2] = answer2
    body[:question3] = question3
    body[:answer3] = answer3
    body[:question4] = question4
    body[:answer4] = answer4
    body[:question5] = question5
    body[:answer5] = answer5
    body[:question6] = question6
    body[:answer6] = answer6
    body[:question7] = question7
    body[:answer7] = answer7
    body[:question8] = question8
    body[:answer8] = answer8
    body[:question9] = question9
    body[:answer9] = answer9
    body[:question10] = question10
    body[:answer10] = answer10
    body[:question11] = question11
    body[:answer11] = answer11
    body[:question12] = question12
    body[:answer12] = answer12
    body[:question13] = question13
    body[:answer13] = answer13
    body[:question14] = question14
    body[:answer14] = answer14
    
    body[:inventors] = inventors
    
    if order.drawings.count > 0
      order.drawings.each do |image|
        attachment :content_type => "image/jpeg", :body => File.read(image.image.path)
      end
    end
  end
  
  def trademark_application(params)
    @recipients = SITE_EMAIL
    @from = params[:email] if params[:email]
    @reply_to = params[:email] if params[:email]
    @subject = "Trademark Registration Form #{SITE_DOMAIN}"
    @sent_on = Time.now
    @content_type = 'text/html'
    
    body[:params] = params
  end
  
  def trademark_search(params)
    @recipients = SITE_EMAIL
    @from = params[:email] if params[:email]
    @reply_to = params[:email] if params[:email]
    @subject = "Trademarks Search Form #{SITE_DOMAIN}"
    @sent_on = Time.now
    @content_type = 'text/html'
    
    body[:params] = params
  end
  
  def patent_search(params, file1, file2, file3)
    @recipients = SITE_EMAIL
    @from = params[:email] if params[:email]
    @reply_to = params[:email] if params[:email]
    @subject = "Patent Search Form #{SITE_DOMAIN}"
    @sent_on = Time.now
    @content_type = 'text/html'
    
    part "text/html" do |p|
      p.body = render_message("patent_search", :params => params) 
    end
    
    (1..3.to_i).each do |i|
      image_file = eval("file#{i}")
      attachment :content_type => "application/octet-stream", :body => image_file.read, :filename => image_file.original_filename unless image_file.blank?
    end
  end
end