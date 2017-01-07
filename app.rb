 
require "json"
require "open-uri"
require "pry"
require "sinatra"
require "sinatra/namespace"
require "sinatra/reloader"

class ApiBlog < Sinatra::Base
  set :root, File.dirname(__FILE__)
  register Sinatra::Namespace
end

require_relative "routes/api/posts"
require_relative "routes/home"
require_relative "db/db"

ApiBlog.helpers DB 
