require 'sinatra'
require_relative '../helpers/view_helpers'

######## Users section

get '/users/signin' do
  erb :login, :layout => false
end

post "/users/signin" do
  if session[:user] = User.authenticate(params[:session][:email].downcase, params[:session][:password])
    flash[:success]  = "Login successful"
    redirect '/service_providers'
  else
    flash[:failure] = "Login failed - Try again"
    redirect '/users/signin'
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
    erb :user_new
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
