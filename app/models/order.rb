class Order < ActiveRecord::Base
  
  before_create :set_price
  
  belongs_to :user
  has_many :answers, :order => "question_id"
  has_many :drawings
  has_many :inventors
  
  acts_as_state_machine :initial => :pending_answers
  
  state :pending_answers
  state :pending_terms
  state :pending_payment
  state :pending_confirmation
  state :confirmed
  
  event :answer do
    transitions :from => :pending_answers, :to  => :pending_terms
  end
  
  event :accept_terms do
    transitions :from => :pending_terms, :to  => :pending_payment
  end
  
  event :pay do
    transitions :from => :pending_payment, :to  => :pending_confirmation
  end
  
  event :confirm do
    transitions :from => :pending_confirmation, :to  => :confirmed
  end
  
  private
  def set_price
    self.total = Configuration.first.service_price
  end
end
