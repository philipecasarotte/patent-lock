class PagesController < ApplicationController

  after_filter(:except => :contact) {|c| c.cache_page}

  def index
    @pages = Page.main_pages
  end

  def contact
    @page = Page.find_by_permalink('contact')
    if request.post?
      Mailer.deliver_contact(params[:contact])
      flash[:notice] = t(:message_sent)
    end
    @metatag_object = @page
  end
  
  def trademarks
    @cart = GoogleCheckout::Cart.new(MERCHANT_ID, MERCHANT_KEY)
    @cart.add_item(:name => 'Patent Lock Service', :description => 'A service to make the patent of your mark.', :price => "150.00")
    @page = Page.find_by_permalink('trademarks')
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

