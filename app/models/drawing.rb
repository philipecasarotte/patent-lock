class Drawing < ActiveRecord::Base
  validates_presence_of :order_id
  
  belongs_to :order
  
  has_attached_file :image,
                    :styles => { :thumb => "150x150#" },
                    :path => PAPERCLIP_PATH,
                    :url => PAPERCLIP_URL,
                    :default_url => ""
  
  def self.create_or_update(options = {})
      record = find_by_position_and_order_id(options[:position], options[:order_id]) || new
      record.attributes = options
      record.save!
      record
  end
end
