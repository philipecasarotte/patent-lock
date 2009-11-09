class Inventor < ActiveRecord::Base
  validates_presence_of :order_id
  
  belongs_to :order
  
  def self.create_or_update(options = {})
      record = find_by_email_and_order_id(options[:email], options[:order_id]) || new
      record.attributes = options
      record.save!
      record
  end
end
