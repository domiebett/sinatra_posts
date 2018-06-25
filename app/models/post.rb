require 'sinatra/activerecord'

class Post < ActiveRecord::Base
  validates :title, :content, presence: true
end