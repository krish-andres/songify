module Songify
  class PlaylistRepo < Repo
    def create_table
      command = <<-SQL
        CREATE TABLE IF NOT EXISTS playlists(
          id SERIAL PRIMARY KEY,
          name TEXT, 
          description TEXT
        );
      SQL
      @db.exec(command)
    end

    def drop_table
      command = <<-SQL
        DROP TABLE IF EXISTS playlists CASCADE;
      SQL
      @db.exec(command)
    end

    def create(params)
      name = params[:name]
      description = params[:description]
      command = <<-SQL
        INSERT INTO playlists(name, description)
        VALUES ($1,$2)
        RETURNING *;
      SQL
      result = @db.exec(command, [name, description])
      build_playlist(result.first)
    end

    def build_playlist(params)
      id = params['id']
      name = params['name']
      description = params['description']
      Songify::Playlist.new({
        id: id, 
        name: name, 
        description: description
      })
    end

    def find_by(params)
      name = params[:name]
      command = <<-SQL
        SELECT * FROM playlists WHERE name=$1;
      SQL
      results = @db.exec(command, [name])
      results.map { |result| build_playlist(result) }
    end

    def find(id)
      command = <<-SQL
        SELECT * FROM playlists WHERE id=$1;
      SQL
      result = @db.exec(command, [id])
      build_playlist(result.first)
    end

    def find_all
      command = <<-SQL
        SELECT * FROM playlists;
      SQL
      results = @db.exec(command)
      results.map { |result| build_playlist(result) }
    end

  end
end



