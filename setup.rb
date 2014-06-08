require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter =>'postgresql',
  :host => 'localhost',
  :database => 'letsintervene'
)

#migration into database will be:



####### Serice Providers
class CreateServiceProvider < ActiveRecord::Migration
  def self.up
    create_table :service_providers do |t|
      t.string :name
      t.string :mission
      t.string :image
      t.string :remote_image_url;
      t.string :website
      t.string :providers_email
      t.string :contact_person
      t.string :contact_email
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :work_phone
      t.string :fax
      t.string :infraction_supported
      t.text :other
      t.timestamps
  end
end

  def self.down
    drop_table :service_providers
  end
end


##### Service Category

class CreateServiceCategory < ActiveRecord::Migration
  def self.up
    create_table :service_categories do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :service_categories
  end
end



##@# Join Table
class JoinTableServiceCategoriesServiceProviders < ActiveRecord::Migration
  def self.up
    create_table :service_categories_service_providers, :id => false do |t|
      t.integer :service_category_id
      t.integer :service_provider_id
    end
  end

   def self.down
    drop_table :service_categories_service_providers
  end
end


#### Users

class User < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :salt
      t.string :encrypted_password
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end


#call the migrations
# CreateServiceProvider.down
CreateServiceProvider.up
# CreateServiceCategory.up
# JoinTableServiceCategoriesServiceProviders.up
# User.up


#you can now run the database by running ruby setup.rb

