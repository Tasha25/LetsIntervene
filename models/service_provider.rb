class ServiceProvider < ActiveRecord::Base
  attr_accessible :name, :mission, :image_url, :website, :providers_email ,:street1 ,:street2, :city, :state, :zip_code, :work_phone, :fax,:infraction_supported, :other, :contact_person, :contact_email, :service_category_ids

  has_and_belongs_to_many :service_categories



end