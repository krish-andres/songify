require 'sinatra'
require 'sinatra/json'
require "sinatra/reloader" if development?
require 'pry-byebug'

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

post '/albums/:id/songs' do
  puts params
  @name = params[:songName]
  @youtube_link = params[:songLink]
  @song_album = Songify::AlbumRepo.new.find(params[:albumId])
  Songify::SongRepo.new.create({name: @name, youtube_link: @youtube_link, album: @song_album})
  redirect to("albums/#{@song_album.id}")
end

get '/playlists' do 
  @playlists = Songify::PlaylistRepo.new.find_all
  erb :playlists
end

post '/playlists' do
  puts params
  @name = params[:playlistName]
  @description = params[:playlistDesc]
  Songify::PlaylistRepo.new.create({name: @name, description: @description})
  redirect to('/playlists')
end

get '/playlists/:id' do
  @playlist = Songify::PlaylistRepo.new.find(params[:id])

  @playlist_songs = Songify::PlaylistSongsRepo.new.find_by({playlist_id: @playlist})
  
  @songs = Songify::SongRepo.new.all

  erb :playlist
end

post '/playlists/:id/songs' do
  puts params
  playlist_id = params[:playlistId]
  song_id = params[:playlistSong]
  Songify::PlaylistSongsRepo.new.create(playlist_id: playlist_id, song_id: song_id)
  redirect to("playlists/#{playlist_id}")
end


