require 'test_helper'

class QuestionTest < ActiveSupport::TestCase

  context "A Question" do
    should_validate_presence_of :name
    should_have_many :answers
  end
  

end
