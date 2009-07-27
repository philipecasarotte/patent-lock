class Question < ActiveRecord::Base
  
  before_create :update_position
  
  validates_presence_of :name
  
  has_many :answers
  
  default_scope :order => "position ASC"
  
  def next
    arr = Question.all
    (arr[arr.index(self) + 1]).position
  end

  def previous
    arr = Question.all
    arr[arr.index(self) -1].position
  end
  
  private
  def update_position
    @last_question = Question.last
    @new_position = @last_question.position+1 rescue 0
    self.position = @new_position
  end
end
