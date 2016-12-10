class Board < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of  :name
  
  has_many :pinnings
  has_many :pins, through: :pinnings
  has_many :board_pinners , dependent: :destroy 
  
  accepts_nested_attributes_for :board_pinners

end
