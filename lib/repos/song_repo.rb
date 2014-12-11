module Songify
  class SongRepo < Repo

    def create_table
      command = <<-SQL
        CREATE TABLE IF NOT EXISTS songs(
          id SERIAL PRIMARY KEY,
          name TEXT,
          youtube_link TEXT,
          album_id INTEGER REFERENCES albums (id)
        );
      SQL
      @db.exec(command)
    end

    def drop_table
      command = <<-SQL
        DROP TABLE IF EXISTS songs CASCADE;
      SQL
      @db.exec(command) 
    end

    def create(params)
      name = params[:name]
      youtube_link = params[:youtube_link]
      album_id = params[:album].id
      command = <<-SQL
        INSERT INTO songs(name, youtube_link, album_id)
        VALUES ($1,$2,$3)
        RETURNING *;
      SQL
      result = @db.exec(command, [name, youtube_link, album_id])
      build_song(result.first)
    end


    def build_song(params)
      id = params['id']
      name = params['name']
      youtube_link = params['youtube_link']
      album_id = params['album_id']
      album = Songify::AlbumRepo.new.find(album_id)
      Songify::Song.new({
        id: id, 
        name: name, 
        youtube_link: youtube_link, 
        album: album
      })
    end  

    def find_by(params)
      name = params[:name]
      album = params[:album]
      album_id = album.id if album
      command = <<-SQL
        SELECT * FROM songs
      SQL
      if name
        spec = <<-SQL
          WHERE name=$1;
        SQL
        results = @db.exec(command+spec, [name])
      elsif album
        spec = <<-SQL
          WHERE album_id=$1;
        SQL
        results = @db.exec(command+spec, [album_id])
      end
      results.map { |result| build_song(result) }
    end

    def update(params)
      id = params[:id]
      youtube_link = params[:youtube_link]
      command = <<-SQL
        UPDATE songs
        SET youtube_link=$2
        WHERE songs.id=$1
        RETURNING *;
      SQL
      result = @db.exec(command, [id, youtube_link])
      build_song(result.first)
    end

    def find_all(params)
      album = params[:album]
      album_id = album.id
      command = <<-SQL
        SELECT * FROM songs WHERE album_id=$1
      SQL
      results = @db.exec(command, [album_id])
      results.map { |result| build_song(result) }
    end

  end
end




