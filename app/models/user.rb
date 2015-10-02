class User < ActiveRecord::Base
  has_many :stores, dependent: :destroy
  has_many :orders
  has_many :favourites
  has_many :favstores, through: :favourites,  source: "store"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook] 

   geocoded_by  :full_address  #Geocoder Api
   after_validation :geocode,if: ->(user){ user.full_address.present? and user.full_address_changed? } 
        

   def full_address
    [add1, add2, city, zip].compact.join(', ')   
   end
   
   def full_address_changed?
     attrs = %w(add1 add2 city zip)
     attrs.any?{|a| send "#{a}_changed?"}
   end 

  include PgSearch  #PgSearch 
   pg_search_scope :search, against: [:name],
      using: {tsearch: {dictionary: "english", prefix: true, any_word: true, negation: true}}

   def self.text_search(query)
     if query.present?
       search(query)
     else 
       all
     end
   end
   #multisearchable against: [:name]
   
   def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
    #user.image = auth.info.image # assuming the user model has an image
  end
 end
 
    def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end

