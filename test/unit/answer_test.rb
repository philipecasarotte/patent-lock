require 'test_helper'

class AnswerTest < ActiveSupport::TestCase

  context "An answer" do
    should_belong_to :order
    should_belong_to :question
    should_validate_presence_of :body
  end
  

end
