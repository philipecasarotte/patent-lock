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
  
  def contact(params)
    @recipients = SITE_EMAIL
    @from = params[:email] if params[:email]
    @reply_to = params[:email] if params[:email]
    @subject = I18n.t(:contact_from) + " #{SITE_DOMAIN}"
    @sent_on = Time.now
    @content_type = 'text/html'
    
    body[:params] = params
  end
  
  def trademark_registration(params)
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
    
    for i in [1...3] do
      attachment :content_type => "application/octet-stream", :body => "file#{i}".to_param.read, :filename => "file#{i}".to_param.original_filename unless "file#{i}".to_param.blank?
    end
  end
end