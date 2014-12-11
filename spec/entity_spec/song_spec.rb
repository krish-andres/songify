require_relative '../../spec_helper.rb'

describe Songify::Song do
  let(:recovery) { Songify::Album.new({
    title: 'Recovery', 
    year: 2009, 
    genre: 'Rap', 
    image_link: 'www.example-link.com'
  }) }
  let(:take_care) { Songify::Album.new({
    title: 'Take Care', 
  }) }

  let(:space_bound) { Songify::Song.new({
    name: "Space Bound", 
    youtube_link: "www.youtube.com/space-bound",
    album: recovery
  }) }
  let(:not_afraid) { Songify::Song.new({
    name: "Not Afraid", 
    youtube_link: "www.youtube.com/not-afraid",
    album: recovery
  }) }
  let(:underground_kings) { Songify::Song.new({
    name: "Underground Kings", 
    youtube_link: "www.youtube.com/underground-kings",
    album: take_care
  }) }

  describe "initialize" do
    it "creates a new song instance" do
      expect(space_bound).to be_a(Songify::Song)
      expect(space_bound.name).to eq("Space Bound")
      expect(space_bound.album).to be_a(Songify::Album)
      expect(not_afraid.album.title).to eq("Recovery")
      expect(underground_kings.album.title).to eq("Take Care")
    end
  end
end
