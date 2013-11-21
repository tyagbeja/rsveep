class Event < ActiveRecord::Base
  belongs_to :user
  has_many :guest
  validates :title, presence: true
  validates :venue, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true
  validates :dateTime, presence: true
  validates :privacy, presence: true
end
