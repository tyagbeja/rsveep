class User < ActiveRecord::Base
  has_many :event
  validates :name, presence: true
  validates :number, presence: true, length: { minimum: 11 }
end
