class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :order

  validates_presence_of :body
end