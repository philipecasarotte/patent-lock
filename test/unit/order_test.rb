require 'test_helper'

class OrderTest < ActiveSupport::TestCase  
  context "A order" do
    setup do
      @configuration = Factory(:configuration, :service_price => 150.00)
      @user = Factory(:user, :login => "client")
      @order = Factory(:order, :user => @user)
    end
    
    subject { @order }
    
    should_belong_to :user
    should_have_many :answers
        
    should "have initial state of 'Pending Answers'" do
      assert_equal("pending_answers", @order.state)
    end
    
    should "follow all steps" do
      @order.answer!
      assert_equal("pending_terms", @order.state)
      @order.accept_terms!
      assert_equal("pending_payment", @order.state)
      @order.pay!
      assert_equal("pending_confirmation", @order.state)
      @order.confirm!
      assert_equal("confirmed", @order.state)
    end
    
    should "have the current service price" do
      assert_equal(BigDecimal("150.00"), @order.total)
    end
  end
end
