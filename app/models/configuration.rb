class Configuration < ActiveRecord::Base
  validates_presence_of :service_price
end
