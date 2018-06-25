require 'sinatra'
require 'slim'

require_relative '../helpers/html'
require_relative '../models/post'

class App < Sinatra::Application

  helpers Html::StyleHelpers, Html::FormHelpers, Html::HtmlMethodHelpers

  get '/posts/new' do
    @post = Post.new
    slim :"posts/new"
  end

  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    slim :"posts/edit"
  end

  get '/posts' do
    @posts = Post.all
    slim :"posts/post"
  end

  post '/posts' do
    title = params[:title]
    content = params[:content]

    @post = Post.new(title: title, content: content)

    if @post.save
      redirect '/posts'
    else
      puts @post.errors.full_messages
      redirect '/posts/new'
    end
  end

  put '/posts/:id' do
    @post = Post.find(params[:id])
    if @post.update(title: params[:title], content: params[:content])
      redirect '/posts'
    else
      redirect "/posts/#{params[:id]}/edit"
    end
  end

  delete '/posts' do
    'Deleting posts'
  end
end
