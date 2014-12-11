require_relative '../../spec_helper.rb'

describe Songify::SongRepo do
  let(:songs) { Songify::SongRepo.new } 
  let(:albums) { Songify::AlbumRepo.new }
  let(:recovery) { albums.create({title: "Recovery", year: 2009, genre: 'Rap', image_link: 'www.example-link.com'}) }

  before(:each) do
    albums.drop_table
    songs.drop_table
    albums.create_table
    songs.create_table
  end

  describe "create" do
    it "stores a new song object within an album" do
      song = songs.create({name: "Space Bound", youtube_link: 'youtube.com/space-bound', album: recovery})
      expect(song).to be_a(Songify::Song)
      expect(song.name).to eq('Space Bound')
      expect(song.album.title).to eq('Recovery')
    end
  end

  describe "find_by" do
    before(:each) { songs.create({name: "Space Bound", youtube_link: 'youtube.com/space-bound', album: recovery}) }
    
    it "finds a song by it's name" do
      song = songs.find_by({name: 'Space Bound'}).first
      expect(song).to be_a(Songify::Song)
      expect(song.name).to eq("Space Bound")
      expect(song.album.title).to eq("Recovery")
    end

    it "finds all songs within the same album" do
      songs.create({name: "Not Afraid", album: recovery})
      recovery_songs = songs.find_by({album: recovery})
      expect(recovery_songs.length).to eq(2)
      expect(recovery_songs.last).to be_a(Songify::Song)
    end
  end

  describe "update" do
    it "changes the specified attributes" do
      song = songs.create({name: "Space Bound", youtube_link: 'youtube.com/space-bound', album: recovery}) 
      expect(song.youtube_link).to eq('youtube.com/space-bound')
      updated_song = songs.update({id: song.id, youtube_link: 'www.youtube.com/space-bound'})
      expect(updated_song).to be_a(Songify::Song)
      expect(updated_song.youtube_link).to eq("www.youtube.com/space-bound")
    end
  end
end
