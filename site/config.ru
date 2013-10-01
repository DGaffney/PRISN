require 'sinatra'
require 'rack'

load 'environment.rb'
set :root, Pathname(__FILE__).dirname
set :environment, :production
set :run, false
# require 'rack/ssl-enforcer'
# use Rack::SslEnforcer
run Sinatra::Application