class Vehicle < ActiveRecord::Base
  has_many :user_vehicles, dependent: :destroy
  has_many :users, through: :user_vehicles
end
