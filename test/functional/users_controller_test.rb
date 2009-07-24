require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @controller = UsersController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "Registering a new user" do

    context "in the registration page" do
      setup do
        get :new
      end
      should_render_template :new
    end

    context "after creating" do

      context "an invalid user" do
        setup do
          User.any_instance.stubs(:valid?).returns(false)
          post :create
        end
        should_render_template :new
      end

      context "a valid user" do
        setup do
          User.any_instance.stubs(:valid?).returns(true)
          post :create, :user => Factory.attributes_for(:user)
        end
        
        should "should have the 'user' role" do
          assert assigns(:user).has_role?('user')
        end
        
        should "have an order after created" do
          assert_not_nil(assigns(:user).order)
        end
        
        should_redirect_to("profile page") { user_path(assigns(:user)) }
      end
    end

    context "edit" do
      setup do
        @user = Factory(:user)
        activate_authlogic
        UserSession.create(@user)
        get :edit, :id => @user
      end
      should_render_template :edit
    end
    
    context "Update" do
      setup do
        @user = Factory(:user)
        activate_authlogic
        UserSession.create(@user)
      end
    
      context "an invalid user" do
        setup do
          User.any_instance.stubs(:valid?).returns(false)
          post :update, :id => @user
        end
        should_render_template "edit"
      end
    
      context "a valid user" do
        setup do
          User.any_instance.stubs(:valid?).returns(true)
          post :update, :id => @user
        end
        should_redirect_to("profile page") { user_path(@user) }
      end
    end
  end
  

end
