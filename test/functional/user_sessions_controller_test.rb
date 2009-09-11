require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  
  context "A user logging in" do

    context "with valid credentials" do
      setup do
        @page = Factory(:page, :name => "Member Login", :permalink => "member-login")
        @question = Factory(:question)
        @user = Factory(:user)
        @order = Factory(:order, :user_id => @user.id)
        post :create, :user_session => {:login => @user.login, :password => @user.password}
      end

      should_assign_to :user_session
      should_set_the_flash_to "Logged in successfully"
      should_redirect_to('the state of user order') { questionnaire_questions_path("questions", Question.first.position) }
      should "assign the user session" do
        assert user_session = UserSession.find
        assert_equal @user, user_session.user
      end
      
      #questionnaire_questions_path("questions", Question.first.position)
    end

    context "with invalid credentials" do
      setup do
        @page = Factory(:page, :name => "Member Login", :permalink => "member-login")
        post :create, :user_session => {:login => "invalid_user", :password => "badpassword"}
      end

      should_not_set_the_flash
      should_respond_with :success
      should_render_template :new
    end
  end

  context "A user logging out" do
    setup do
      UserSession.create(Factory(:user))
      delete :destroy
    end

    should "not have a user session" do
      assert_nil UserSession.find
    end
    should_redirect_to('the login page') { login_url }
  end
end
