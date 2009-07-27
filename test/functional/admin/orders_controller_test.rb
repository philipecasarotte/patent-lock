require 'test_helper'

class Admin::OrdersControllerTest < ActionController::TestCase
  def setup
    @controller = Admin::OrdersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "An admin accessing" do
    setup do
      activate_authlogic
      UserSession.create(Factory(:admin))
    end

    context "the detail of the  order" do
      setup do
        @user = Factory(:user, :login => "client")
        @order = Factory(:order, :user_id => @user.id)
        get :show, :user_id => @user
      end
      
      should_render_template :show
      should_respond_with_content_type :html
    end
  end
end
