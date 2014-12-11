require_relative 'songify.rb'

task :prep do
  album_repo = Songify::AlbumRepo.new
  song_repo = Songify::SongRepo.new
  album_repo.drop_table
  song_repo.drop_table
  album_repo.create_table
  song_repo.create_table
  album_repo.create({title: "Recovery", year: 2009, genre: 'Rap', image_link: "www.example-link.com"})
  album_repo.create({title: "Take Care", year: 2011, genre: 'Rap', image_link: "www.another-link.com"})
  album_repo.create({title: "Graduation", year: 2007, genre: 'Rap', image_link: "www.third-link.com"})
  album_repo.create({title: "Californication", year: 1999, genre: 'Rock', image_link: "www.fourth-link.com"})
  album_repo.create({title: "Stadium Arcadium", year: 2004, genre: 'Rock', image_link: "www.fifth-link.com"})

  `bundle exec ruby server.rb`
end
