require_relative '../../spec_helper.rb'

describe Songify::PlaylistSongsRepo do
  let (:playlist_songs) { Songify::PlaylistSongsRepo.new }
  before(:each) do
    playlist_songs.drop_table
    playlist_songs.create_table
  end


end
