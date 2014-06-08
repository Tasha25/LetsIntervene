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
  # p params
  # binding.pry
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