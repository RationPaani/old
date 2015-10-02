class Category < ActiveRecord::Base
  has_many :catsubs
  has_many :subcates, through: :catsubs
  has_many :inverse_catsubs, :class_name => "Catsub", :foreign_key => "subcate_id"
  has_many :inverse_subcates, :through => :inverse_catsubs, :source => :category
  belongs_to :store
end
