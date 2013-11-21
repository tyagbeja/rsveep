class User < ActiveRecord::Base
  validates :name, presence: true
  validates :number, presence: true, length: { minimum: 11 }
end
