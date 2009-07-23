class Mailer < ActionMailer::Base
  
  ActionMailer::Base.raise_delivery_errors = true
  ActionMailer::Base.smtp_settings = {
      :address => "mail.#{SITE_DOMAIN}",
      :port => "25",
      :domain => SITE_DOMAIN,
      :authentication => :login,
      :user_name => "webmaster@#{SITE_DOMAIN}",
      :password => "password_here"
  }
  
  def contact(params)
    @recipients = SITE_EMAIL
    @from = params[:email] if params[:email]
    @reply_to = params[:email] if params[:email]
    @subject = I18n.t(:contact_from) + " #{SITE_DOMAIN}"
    @sent_on = Time.now
    @content_type = 'text/html'
    
    body[:params] = params
  end
  
  def trademarks(params)
    @recipients = SITE_EMAIL
    @from = params[:email] if params[:email]
    @reply_to = params[:email] if params[:email]
    @subject = "Trademarks Form #{SITE_DOMAIN}"
    @sent_on = Time.now
    @content_type = 'text/html'
    
    body[:params] = params
  end


end
