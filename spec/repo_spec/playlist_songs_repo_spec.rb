require_relative '../../spec_helper.rb'

describe Songify::PlaylistSongsRepo do
  let (:playlist_songs) { Songify::PlaylistSongsRepo.new }
  before(:each) do
    playlist_songs.drop_table
    playlist_songs.create_table
  end

  describe "find_by" do
    it "dummy spec" do
      playlist = Songify::PlaylistRepo.new.create({name: "Workout", description: "Description"})
      playlist_songs.find_by(playlist: playlist)
    end
  end

end
