require 'sinatra'
require 'slim'

require_relative '../models/user'
require_relative '../helpers/helpers'
require_relative '../helpers/html'

class App < Sinatra::Application
  helpers Html::FormHelpers

  get '/login' do
    slim :"auth/login"
  end

  get '/register' do
    slim :"auth/register"
  end

  post '/signup' do
    @user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email]
    )
    @user.password = params[:password]

    if @user.save
      session[:user_id] = @user.id
      redirect '/posts'
    else
      puts @user.errors.full_messages
      redirect '/register'
    end
  end

  post '/signin' do
    @user = User.find_by(email: params[:email])
    if @user.password == params[:password]
      session[:user_id] = @user.id
      redirect '/posts'
    else
      puts @user.errors.full_messages
      redirect '/login'
    end
  end
end
