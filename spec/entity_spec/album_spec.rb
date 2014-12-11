require_relative '../../spec_helper.rb'

describe Songify::Album do
  let(:recovery) { Songify::Album.new({
    title: 'Recovery', 
    year: 2009, 
    genre: 'Rap', 
    image_link: 'www.example-link.com'
  }) }
  let(:take_care) { Songify::Album.new({
    title: 'Take Care', 
  }) }

  describe "initialize" do
    it "creates an instance of Album" do
      expect(recovery).to be_a(Songify::Album)
      expect(recovery.title).to eq("Recovery")
    end

    it "has a default year, genre, and image_link of 'N/A'" do
      expect(take_care).to be_a(Songify::Album)
      expect(take_care.year).to eq("N/A")
      expect(take_care.genre).to eq("N/A")
      expect(take_care.image_link).to eq("N/A")
    end
  end
end
