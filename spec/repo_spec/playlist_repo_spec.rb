require_relative '../../spec_helper.rb'

describe Songify::PlaylistRepo do
  let(:playlists) { Songify::PlaylistRepo.new }
  before(:each) do
    playlists.drop_table
    playlists.create_table
  end

  describe "create and find by" do
    it "adds a playlist to the list" do
      playlist = playlists.create({name: "Workout", description: "Songs for working out"})
      expect(playlist).to be_a(Songify::Playlist)
      expect(playlist.name).to eq("Workout")
    end

    it "finds a playlist by name" do
      playlists.create({name: "Workout", description: "Songs for working out"})
      playlist = playlists.find_by({name: "Workout"}).first
      expect(playlist).to be_a(Songify::Playlist)
      expect(playlist.description).to eq("Songs for working out")
    end

    it "finds a playlist by id" do
      playlist = playlists.create({name: "Workout", description: "Songs for working out"})
      found_playlist = playlists.find(playlist.id)
      expect(found_playlist).to be_a(Songify::Playlist)
      expect(found_playlist.name).to eq(playlist.name)
    end
  end

  describe "find all" do
    it "finds all playlists from the database" do
      playlists.create({name: "Workout", description: "Songs for working out"})
      playlists.create({name: "Chill", description: "Songs for chilling"})
      playlists.create({name: "EDM", description: "Electronic music"})
      all_playlists = playlists.find_all
      expect(all_playlists.length).to eq(3)
      expect(all_playlists.last).to be_a(Songify::Playlist)
    end
  end
end
