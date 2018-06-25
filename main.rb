require 'sinatra'

class App < Sinatra::Application
  enable :sessions
end

require_relative 'app/controllers/init'