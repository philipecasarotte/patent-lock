class Question < ActiveRecord::Base

  validates_presence_of :name
  
  has_many :answers
  
  default_scope :order => "position ASC"
end
