class Company < ApplicationRecord
  has_rich_text :description
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create, :allow_blank => :true
  validate :email_from_permitted_domain
  before_save :save_city_state

  private
   def email_from_permitted_domain
     return true if email.end_with?('@getmainstreet.com')
     errors.add(:email, 'should be a valid email_id that ends with @getmainstreet.com')
   end

   def save_city_state
    self.city = ZipCodes.identify(self.zip_code)[:city]
    self.state = ZipCodes.identify(self.zip_code)[:state_name]
   end
end
