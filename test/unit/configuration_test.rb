require 'test_helper'

class ConfigurationTest < ActiveSupport::TestCase
  context "The Configuration" do
    should_validate_presence_of :service_price
  end
end
