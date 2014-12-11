require_relative '../../spec_helper.rb'

describe Songify::AlbumRepo do
  let(:albums) { Songify::AlbumRepo.new }
  before(:each) do
    albums.drop_table
    albums.create_table
  end

  describe "create and find by" do
    it "adds an album to the list" do
      album = albums.create({title: "Recovery", year: 2009, genre: 'Rap', image_link: "www.example-link.com"})       
      expect(album).to be_a(Songify::Album)
      expect(album.title).to eq('Recovery')
      expect(album.genre).to eq('Rap')
    end

    it "retrieves an existing album" do
      albums.create({title: "Recovery", year: 2009, genre: 'Rap', image_link: "www.example-link.com"})       
      album = albums.find_by({title: 'Recovery'}).first
      expect(album).to be_a(Songify::Album)
      expect(album.year).to eq(2009)
    end
  end

  describe "find all" do
    it "finds all albums from the database" do
      albums.create({title: "Recovery", year: 2009, genre: 'Rap', image_link: "www.example-link.com"})
      albums.create({title: "Take Care", year: 2011, genre: 'Rap', image_link: "www.another-link.com"})
      albums.create({title: "Graduation", year: 2007, genre: 'Rap', image_link: "www.third-link.com"})
      all_albums = albums.find_all
      expect(all_albums.length).to eq(3)
    end
  end

  describe 'update' do
    it "changes the specified attributes" do
      album = albums.create({title: "Recovery", year: 2009, genre: 'Rap', image_link: "www.example-link.com"})       
      expect(album.image_link).to eq("www.example-link.com")
      updated_album = albums.update({id: album.id, image_link: "www.new-link.com"})
      expect(updated_album).to be_a(Songify::Album)
      expect(updated_album.image_link).to eq("www.new-link.com")
    end
  end
end
