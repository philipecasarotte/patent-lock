class PagesController < ApplicationController

  after_filter(:except => :contact) {|c| c.cache_page}

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
  
  def trademark_registration
    @cart = GoogleCheckout::Cart.new(MERCHANT_ID, MERCHANT_KEY)
    @cart.add_item(:name => 'Patent Lock Service', :description => 'A service to make the patent of your mark.', :price => "150.00")
    @page = Page.find_by_permalink('trademark-registration')
    if request.post?
      Mailer.deliver_trademarks(params[:trademarks])
      flash[:notice] = t(:message_sent)
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

end

