class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :order

  validates_presence_of :body
  
  default_scope :order => "`questions`.position", :include => :question
  
  def self.create_or_update(options = {})
      record = find_by_question_id_and_order_id(options[:question_id], options[:order_id]) || new
      record.attributes = options
      record.save!
      record
  end
end