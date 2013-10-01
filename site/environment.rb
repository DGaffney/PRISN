require 'pry'
require 'mongo_mapper'
require 'hashie'
require 'oauth'
require 'sinatra'
require 'oauth'
require 'bcrypt'
require 'sinatra/flash'
require 'oauth2'

Dir[File.dirname(__FILE__) + '/extensions/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../specification/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/../plugins/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/helpers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/handlers/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/handlers/**/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/before_hooks/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/before_hooks/**/*.rb'].each {|file| require file }

MongoMapper.connection = Mongo::MongoClient.new("localhost", 27017, :pool_size => 25, :pool_timeout => 60)
MongoMapper.database = "prisn"

set :erb, :layout => :'layouts/main'
enable :sessions
set :session_secret, Setting.site_session_secret
register Sinatra::Flash

helpers LayoutHelper
helpers LoginHelper
helpers AuthenticateHelper