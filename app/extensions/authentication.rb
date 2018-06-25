require 'sinatra/base'

module Sinatra
  module Authenticate
    def auth(user)
      redirect '/signin' if user.nil?
    end
  end
end