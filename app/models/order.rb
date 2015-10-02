class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :store
  belongs_to :logistic, class_name: "Store"
  has_many :order_details
end
