require 'sinatra'
require 'sinatra/json'
require "sinatra/reloader" if development?

require_relative 'songify.rb'

set :bind, '0.0.0.0' # This is needed for Vagrant


get '/' do
  @albums = Songify::AlbumRepo.new.find_all
  erb :index
end

post '/albums' do
  puts params
redirect to('/')
end