require 'rubygems'
gem 'activerecord', '=3.2.0'
require 'sinatra'
require 'sinatra/flash'
require 'sinatra/reloader' if development?
require 'active_record'
require 'bcrypt'
require 'pry'
require 'pathname'
require 'uri'
require 'open-uri'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'rmagick'
require 'mini_magick'


soda_token = "rB9mf0ACww6KyuStQtrbXtCKF"
require_relative 'models/service_category'
require_relative 'models/image_uploader'
require_relative 'models/service_provider'
require_relative 'models/user'

require_relative 'methods_from_scratch/methods'


# APP_ROOT = Pathname.new(File.expand_path('../../',__FILE__))
# APP_NAME = APP_ROOT.basename.to_s


# CarrierWave.configure do |config|
#   if development?
#     config.storage = :file
#     config.root = File.join(APP_ROOT, 'public')
#     config.store_dir = File.join('uploads')
#   else
#     # store on S3 or whatever
#     raise "Not ready for production!"
#   end
# end




before do
  ActiveRecord::Base.establish_connection(
    :adapter =>'postgresql',
    :host => 'localhost',
    :database => 'letsintervene'
   )
end

after do
  ActiveRecord::Base.connection.close
end

enable :sessions

get '/' do
  redirect to '/welcome'
end

get '/welcome' do
  erb :welcome, :layout => false
end

######## Users section

get '/users/signin' do
  erb :signin, :layout => false
end

post "/users/signin" do

  if session[:user] = User.authenticate(params[:session][:email].downcase, params[:session][:password])
    flash[:success]  = "Login successful"
    redirect '/service_providers'
  else
    flash[:failure] = "Login failed - Try again"
    @object = session[:user]
    redirect 'users/signin'
  end
end


get '/users/signup' do
  erb :user_new, :layout => false
end


post '/users/signup' do
  # this should be User.new instead of User.create
  # User.create both calls User.new and then saves
  @user = User.create(
    :username => params[:username],
    :email => params[:email],
    :password => params[:password],
    :password_confirmation => params[:password_confirmation]
  )


  session[:username] = params[:username]

  if @user.save
    flash[:success] = "Welcome #{@user.username}"
    redirect '/service_providers'
  else
    @object = @user
    erb :user_new, :layout => false
  end
end

get '/users' do
  @users = User.all
  erb :user_index
end


get '/logout' do
  session[:user] = nil
  flash[:logged_out] = "You are logged out"
  redirect '/'
end

######## Service Providers

# create an index page where users see a list of service providers
get '/service_providers' do
  @service_providers = ServiceProvider.order("id DESC").all
  erb :service_provider_index
end

# create a new service_provider page
get '/service_providers/new' do
  @service_categories = ServiceCategory.all
  erb :service_provider_new
end


#The post will create a service provider service provider

post '/service_providers/new' do
  # this should also be ServiceProvider.new
  @service_provider = ServiceProvider.create(
    :image => params[:image],
    :remote_image_url => params[:remote_image_url],
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

  if @service_provider.save
    redirect '/service_providers'
  else
    @object = @service_provider
    @service_categories = ServiceCategory.all
    erb :service_provider_new
  end
end


get '/service_providers/:id' do
  @service_provider = ServiceProvider.find_by_id(params[:id])
  if @service_provider
    erb :service_provider_show
  else
    redirect '/service_providers'
  end
end


get '/service_providers/:id/edit' do
  @service_provider = ServiceProvider.find_by_id(params[:id])
  @service_categories = ServiceCategory.all
  erb :service_provider_update
end

post '/service_providers/:id' do
  provider = ServiceProvider.find_by_id(params[:id])
  provider.name = params[:service_provider]
  provider.save
  redirect to "/service_providers/#{id}"
end


get '/service_providers/:id/delete' do
  @service_provider = ServiceProvider.find_by_id(params[:id])
  erb :service_provider_delete
end

post '/service_providers/:id/delete' do
  provider = ServiceProvider.find_by_id(params[:id])
  provider.destroy
  redirect to 'service_providers'
end
####### Service Categories


#see a list of service_categories
get '/service_categories' do
  @service_categories = ServiceCategory.all
  erb :service_category_index
end


#Add a service category to the list.
get '/service_categories/new' do
  erb :service_category_new
end

#create service category
post '/service_categories/new' do
  # this should also be new instead of create
  @service_category = ServiceCategory.create(:name => params[:service_category])
  if @service_category.save
    redirect "/service_categories/#{@service_category.id}"
  else
    redirect '/service_categories'
  end
end

#show service category
get '/service_categories/:id' do
  @service_category = ServiceCategory.find_by_id(params[:id])
  if @service_category
    erb :service_category_show
  else
    redirect '/'
  end
end


get '/service_categories/:id/edit' do
  @service_category= ServiceCategory.find_by_id(params[:id])
  erb :service_category_update
end

post '/service_categories/:id' do
  category = ServiceCategory.find_by_id(params[:id])
  category.name = params[:service_category]
  category.save
  redirect to "/service_categories/#{params[:id]}"
end

get '/service_categories/:id/delete' do
  @service_category = ServiceCategory.find_by_id(params[:id])
  erb :service_category_delete
end

post '/service_categories/:id/delete' do
  category = ServiceCategory.find_by_id(params[:id])
  category.destroy
  redirect to 'service_categories'
end


######## Users

get '/users' do
  erb :signup_page
end



post '/users/signin' do
  username = params[:username]
  binding.pry
  if User.exists?(username: username)
    redirect to '/username_error'
  else
    user = User.new
    user.username = username
    user.save
    redirect to '/service_providers'
  end
end



get 'username_error' do
  erb :username_error
end



