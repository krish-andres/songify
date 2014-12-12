module Songify
  class PlaylistSongsRepo < Repo
    def create_table
      command = <<-SQL
        CREATE TABLE IF NOT EXISTS playlist_songs(
          id SERIAL PRIMARY KEY, 
          playlist_id INTEGER REFERENCES playlists ( id),
          song_id INTEGER REFERENCES songs ( id)
        );
      SQL
      @db.exec(command)
    end

    def drop_table
      command = <<-SQL
        DROP TABLE IF EXISTS playlist_songs;
      SQL
      @db.exec(command)
    end

    def create(params)
      playlist_id = params[:playlist]
      song_id = params[:song]
      command = <<-SQL
        INSERT INTO playlist_songs(playlist_id, song_id)
        VALUES ($1,$2)
        RETURNING *;
      SQL
      result = @db.exec(command, [playlist_id, song_id])
    end

    def find_by(params)
      playlist_id = params[:playlist].id
      command = <<-SQL
        SELECT * FROM playlist_songs ps
        JOIN songs s
        ON s.id = ps.song_id
        WHERE ps.playlist_id=$1;
      SQL
      results = @db.exec(command, [playlist_id])
    end

  end
end
