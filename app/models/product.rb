class Product < ActiveRecord::Base
    store_accessor :specs
    belongs_to :store
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
