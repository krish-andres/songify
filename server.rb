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
  @title = params[:albumTitle]
  @year = params[:albumYear]
  @genre = params[:albumGenre]
  @image_link = params[:albumImage]
  Songify::AlbumRepo.new.create({title: @title, year: @year, genre: @genre, image_link: @image_link})
  redirect to('/')
end

get '/albums/:id' do
  @album = Songify::AlbumRepo.new.find(params[:id])
  @songs = Songify::SongRepo.new.find_all(album: @album)


  erb :album
end