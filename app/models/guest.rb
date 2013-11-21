class Guest < ActiveRecord::Base
  belongs_to :event
  validates :user, presence: true
  validates_uniqueness_of :user, scope: :event
end
