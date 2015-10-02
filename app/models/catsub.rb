class Catsub < ActiveRecord::Base
  belongs_to :category
  belongs_to :subcate, :class_name => "Category" 
end
