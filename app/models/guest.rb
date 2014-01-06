class Guest < ActiveRecord::Base
  belongs_to :event
  validates :user, presence: true
  validates_uniqueness_of :user, scope: :event
  validates_inclusion_of :response, :in => [ '', 'Yes', 'No', 'May be' ],:message => "%{value} is not a valid response" 
end
