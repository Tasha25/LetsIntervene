require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter =>'postgresql',
  :host => 'localhost',
  :database => 'letsintervene'
  )

#migration into database will be:

class CreateServiceProvider < ActiveRecord::Migration
  def self.up
    create_table :service_providers do |t|
      t.string :name
      t.string :mission
      t.string :image_url
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


#call the migrations

# CreateServiceProvider.up
# CreateServiceCategory.up
JoinTableServiceCategoriesServiceProviders.up



#you can now run the database by running ruby setup.rb

