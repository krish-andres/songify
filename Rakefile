require_relative 'songify.rb'

task :prep do
  album_repo = Songify::AlbumRepo.new
  song_repo = Songify::SongRepo.new
  album_repo.drop_table
  song_repo.drop_table
  album_repo.create_table
  song_repo.create_table
  album1 = album_repo.create({title: "Recovery", year: 2009, genre: 'Rap', image_link: "www.example-link.com"})
  album2 = album_repo.create({title: "Take Care", year: 2011, genre: 'Rap', image_link: "www.another-link.com"})
  album3 = album_repo.create({title: "Graduation", year: 2007, genre: 'Rap', image_link: "www.third-link.com"})
  album4 = album_repo.create({title: "Californication", year: 1999, genre: 'Rock', image_link: "www.fourth-link.com"})
  album5 = album_repo.create({title: "Stadium Arcadium", year: 2004, genre: 'Rock', image_link: "www.fifth-link.com"})
  song_repo.create({name: "Space Bound", youtube_link: "www.youtube.com/space-bound", album: album1})
  song_repo.create({name: "Not Afraid", youtube_link: "www.youtube.com/not-afraid", album: album1})
  song_repo.create({name: "We'll Be Fine", youtube_link: "www.youtube.com/well-be-fine", album: album2})
  song_repo.create({name: "Underground Kings", youtube_link: "www.youtube.com/underground-kings", album: album2})
  song_repo.create({name: "Stronger", youtube_link: "www.youtube.com/stronger", album: album3})
  song_repo.create({name: "Otherside", youtube_link: "www.youtube.com/otherside", album: album4})
  song_repo.create({name: "Snow", youtube_link: "www.youtube.com/snow", album: album5})



  `bundle exec ruby server.rb`
end
