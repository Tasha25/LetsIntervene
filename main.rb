require 'rubygems'
gem 'activerecord', '=3.2.0'
require 'sinatra'
require 'sinatra/flash'
require 'sinatra/reloader' if development?
require 'active_record'
require 'bcrypt'
require 'pry'

require_relative 'models/service_category'
require_relative 'models/service_provider'
require_relative 'models/user'
require_relative 'methods_from_scratch/plural'

ActiveRecord::Base.establish_connection(
  :adapter =>'postgresql',
  :host => 'localhost',
  :database => 'letsintervene'
  )

enable :sessions

get '/' do
  redirect to '/welcome'
end

get '/welcome' do
  erb :welcome
end

######## Users section

get '/users/login' do
  erb :login
end

post "/users/login" do

  def authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_has == BCrypt::Engine.hash_secret(params[:password], password_salt)
      user
    else
      nil
    end
  end

  user = User.authenticate(params[:email], params[:password])

  binding.pry
  if user
    session[:user_id] = user.id
    redirect_to '/service_provider'
  else
    erb :login
  end

end


#   @user = User.all
#   if @user.has_key?(params[:username])
#     user = @user[params[:username]]
#     if user[:password_hash] == BCrypt::Engine.hash_secret(params[:password], user[:salt])
#       session[:username] = params[:username]
#       redirect "/"
#     end
#   end
#   erb :login
# end


get '/users/signup' do
  erb :user_new
end


post '/users/signup' do

  @user = User.create(
    :username => params[:username],
    :email => params[:email],
    :password => params[:password],
    :password_confirmation => params[:password_confirmation]
    )

  binding.pry
  session[:username] = params[:username]

  if @user.save
    flash[:success] = "Welcome"
    redirect '/users'
  else
    erb :user_new
  end
end

get '/users' do
  @users = User.all
  erb :user_index
end


get '/logout' do
  session[:user_id] = nil
  redirect_to '/'
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

  @service_provider = ServiceProvider.create(
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

  if @service_provider.save
    redirect '/service_providers'
  else
    redirect '/service_providers/new'
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
  id = params[:id]
  @service_category= ServiceCategory.find_by_id(id)
  erb :service_category_update
end

post '/service_categories/:id' do
  id = params[:id]
  sc1 = ServiceCategory.find_by_id(id)
  sc1.name = params[:service_category]
  sc1.save
  url = 'service_categories/' + id
  redirect to url
end

######## Users

get '/users' do
  erb :signup_page
end



post '/users/signin' do
  username = params[:username]
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



