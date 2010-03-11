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
  
  def provisional_patent_questionnaire(order)
    @recipients = SITE_EMAIL
    @from = order.user[:email] if order.user
    @reply_to = order.user[:email] if order.user
    @subject = "Provisional Patent Questionnaire #{SITE_DOMAIN}"
    @sent_on = Time.now
    @content_type = 'text/html'
    
    body[:params] = order
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