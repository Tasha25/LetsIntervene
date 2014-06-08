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

# requiring all controllers
Dir[File.absolute_path(File.dirname(__FILE__)) + '/controllers/*.rb'].each { |file| require File.absolute_path(file) }

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
set :session_secret, 'secret'

get '/' do
  redirect to '/welcome'
end

get '/welcome' do
   erb :welcome #, :layout => false
end
