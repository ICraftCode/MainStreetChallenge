class Company < ApplicationRecord
  has_rich_text :description
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, :allow_blank => :true
  validates_length_of :zip_code, :maximum => 5, :minimum => 5, :message => "zip code must be 5 digits"
  validate :email_from_permitted_domain
  validate :zip_code_valid
  before_save :save_city_state

  private
   def email_from_permitted_domain
     return true if email.end_with?('@getmainstreet.com')
     errors.add(:email, 'should be a valid email_id that ends with @getmainstreet.com')
   end

   def zip_code_valid
   	  return true if ZipCodes.identify(zip_code)
   	  errors.add(:zip_code, 'should be a valid zip code')
   end

   def save_city_state
     self.city = ZipCodes.identify(self.zip_code)[:city]
     self.state = ZipCodes.identify(self.zip_code)[:state_name]
   end
end
