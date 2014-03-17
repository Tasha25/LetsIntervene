#login page

require 'rubygems'
gem 'activerecord', '=3.2.0'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_record'
require_relative 'models/service_category'
require_relative 'models/service_provider'

ActiveRecord::Base.establish_connection(
  :adapter =>'postgresql',
  :host => 'localhost',
  :database => 'letsintervene'
  )


get '/' do
  @service_categories = ServiceCategory.all
  erb :index
end


# create a login page where users can go to


# create an index page where users see a list of service providers
# - allow users to see a link to add a service provider
# - allow users to submit a service provider for us to add



#The post will create a service provider service provider

post '/' do

  ServiceProvider.create(
    :image_url => params[:image],
    :name  => params[:org_name],
    :street1  => params[:address],
    :city => params[:city],
    :state => params[:state],
    :zipcode => params[:zip_code],
    :work_phone => params[:org_phone_number],
    :contact_person => params[:contact_person],
    :contact_email => params[:email_address],
    :mission => params[:mission],
    :service_category_ids => params[:category]
  )

end

get '/service_category' do
  erb :service_category
end

#create service category
post '/service_category' do
  @service_category = ServiceCategory.create(:name => params[:service_category])
  if @service_category.save
    redirect "/service_category/#{@service_category.id}"
  else
    redirect '/'
  end
end

#show service category

get '/service_category/:id' do
  @service_category = ServiceCategory.find_by_id(params[:id])
  if @service_category
    erb :show
  else
    redirect '/'
  end
end







