class PagesController < ApplicationController
  
  before_filter :gateway
  before_filter :require_user, :only => "patent-search"
  
  after_filter(:except => [:contact, :patent_search, :trademark_search, :trademark_registration, "patent-search", "trademark-search", "trademark-registration"]) {|c| c.cache_page}

  def index
    @page = Page.find_by_permalink("home")
    @how_patent_lock_works = Page.find_by_permalink("how-patent-lock-works")
    @trademarks = Page.find_by_permalink("trademarks")
    @services = Page.find_by_permalink("services")
    @blog = Page.find_by_permalink("blog")
    @inventor_resource = Page.find_by_permalink("inventor-resource")
    @patent_search = Page.find_by_permalink("patent-search")
    @metatag_object = @page
  end

  def contact
    @page = Page.find_by_permalink('contact')
    if request.post?
      Mailer.deliver_contact(params[:contact])
      flash[:notice] = t(:message_sent)
    end
    @metatag_object = @page
  end
  
  def patent_search
    @page = Page.find_by_permalink('patent-search')
    if request.post?
      @file1 = params[:trademarks][:image1] unless params[:trademarks][:image1].blank?
      @file2 = params[:trademarks][:image2] unless params[:trademarks][:image2].blank?
      @file3 = params[:trademarks][:image3] unless params[:trademarks][:image3].blank?
      @cart = GoogleCheckout::Cart.new(MERCHANT_ID, MERCHANT_KEY)
      @cart.add_item(:name => "Patent Search for #{params[:trademarks][:name]}", :description => "User email: #{params[:trademarks][:email]} | Applicant Name: #{params[:trademarks][:applicant_name]}", :price => Configuration.first.patent_search_price)
      Mailer.deliver_patent_search(params[:trademarks], @file1, @file2, @file3)
    end
    @metatag_object = @page
  end
  
  def trademark_search
    @page = Page.find_by_permalink('trademark-search')
    if request.post?
      @cart = GoogleCheckout::Cart.new(MERCHANT_ID, MERCHANT_KEY)
      @cart.add_item(:name => "Trademark Search for #{params[:trademarks][:name]}", :description => "User email: #{params[:trademarks][:email]} | Patent Phrase: #{params[:trademarks][:phrase]}", :price => Configuration.first.trademark_search_price)
      Mailer.deliver_trademark_search(params[:trademarks])
    end
    @metatag_object = @page
  end
  
  def trademark_application
    @page = Page.find_by_permalink('trademark-application')
    if request.post?
      @cart = GoogleCheckout::Cart.new(MERCHANT_ID, MERCHANT_KEY)
      @cart.add_item(:name => "Trademark Application for #{params[:trademarks][:name]}", :description => "User email: #{params[:trademarks][:email]} | Applicant Name: #{params[:trademarks][:applicant_name]}", :price => Configuration.first.trademark_application_price)
      Mailer.deliver_trademark_application(params[:trademarks])
    end
    @metatag_object = @page
  end

  def method_missing(method, *args)
    @page = Page.find_by_permalink(method) || @page = Page.page_not_found
    @pages = @page.pages || []
    @metatag_object = @page
    send(method.underscore) if respond_to?(method.underscore)
    
    render method.underscore
    rescue ActionView::MissingTemplate
      render 'show'
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
  
  def gateway
		GoogleCheckout.use_sandbox
	end
end