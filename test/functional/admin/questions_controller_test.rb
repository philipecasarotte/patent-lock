require 'test_helper'

class Admin::QuestionsControllerTest < ActionController::TestCase
  def setup
    @controller = Admin::QuestionsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  context "An admin accessing" do
    setup do
      activate_authlogic
      UserSession.create(Factory(:admin))
    end

    context "the list of questions" do

      setup do
        get :index
      end

      should_render_template :index
      should_respond_with_content_type :html

    end

    context "the form for new question" do
      setup do
        get :new
      end
      should_render_template :new
    end

    context "creating" do
      context "an invalid question" do
        setup do
          Question.any_instance.stubs(:valid?).returns(false)
          post :create
        end
        should_render_template :new
      end

      context "a valid question" do
        setup do
          Question.any_instance.stubs(:valid?).returns(true)
          post :create
        end
        should_redirect_to("list of questions") { admin_questions_path }
      end
    end

    context "editing a question" do
      setup do
        get :edit, :id => Factory(:question)
      end
      should_render_template :edit
    end

    context "updating" do
      context "an invalid question" do
        setup do
          question = Factory(:question)
          Question.any_instance.stubs(:valid?).returns(false)
          post :update, :id => Question.first
        end
        should_render_template "edit"
      end

      context "a valid question" do
        setup do
          Question.any_instance.stubs(:valid?).returns(true)
          post :update, :id => Factory(:question)
        end
        should_redirect_to("list of questions") { admin_questions_path }
      end
    end

    context "reordering" do
      context "the main questions" do
        setup do
          get :reorder
        end
        should_assign_to(:items) { Question.all }
        should_render_template :reorder
      end

      context "questions and saving" do
        setup do
          post :order, :order => []
        end
        should_render_without_layout
      end
    end
  end
end
