require 'test_helper'

class Admin::ConfigurationsControllerTest < ActionController::TestCase

  def setup
    @controller = Admin::ConfigurationsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "An admin accessing" do
    setup do
      activate_authlogic
      UserSession.create(Factory(:admin))
    end

    context "editing a configuration" do
      setup do
        get :edit, :id => Factory(:configuration)
      end
      should_render_template :edit
    end

    context "updating" do
      context "an invalid configuration" do
        setup do
          configuration = Factory(:configuration)
          Configuration.any_instance.stubs(:valid?).returns(false)
          post :update, :id => Configuration.first
        end
        should_render_template "edit"
      end

      context "a valid configuration" do
        setup do
          Configuration.any_instance.stubs(:valid?).returns(true)
          post :update, :id => Factory(:configuration)
        end
        should_redirect_to("list of configurations") { edit_admin_configuration_path(1) }
      end
    end
  end
end