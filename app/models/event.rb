class Event < ActiveRecord::Base
  belongs_to :user
  has_many :guest
  validates :title, presence: true
  validates :venue, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :dateTime, presence: true
  validates :privacy, presence: true
  validates_inclusion_of :status, :in => [ 'active', 'expired', 'cancelled'],:message => "%{value} is not a valid status" 
end
