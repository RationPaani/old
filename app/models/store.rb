class Store < ActiveRecord::Base
   belongs_to :user
   has_many :products
   has_many :categories
   has_many :connections
   has_many :conections, through: :connections,  source: "store"
   has_many :orders
   #has_many :sorders, class_name: "Order", foreign_key: "seller_id"
   #has_many :lorders, class_name: "Order", foreign_key: "logistic_id"
   has_many :favourites
   has_many :followers, through: :favourites, source: "user"
   geocoded_by  :full_address  #Geocoder Api
   after_validation :geocode,if: ->(user){ user.full_address.present? and user.full_address_changed? } 
        

   def full_address
    [add1, add2, city, zip].compact.join(', ')   
   end
   
   def full_address_changed?
     attrs = %w(add1 add2 city zip)
     attrs.any?{|a| send "#{a}_changed?"}
   end 

   
   include PgSearch     
     pg_search_scope :search, against: [:name],
      using: {tsearch: {dictionary: "english", prefix: true, any_word: true, negation: true}}
    
    def self.text_search(query)
     if query.present?
       search(query)
     else 
       all
     end
    end
    multisearchable against: [:name]
end
