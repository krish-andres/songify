module Songify
  class AlbumRepo < Repo
    def create_table
      command = <<-SQL
        CREATE TABLE IF NOT EXISTS albums(
          id SERIAL PRIMARY KEY,
          title TEXT, 
          year INTEGER,
          genre TEXT,
          image_link TEXT
        );
      SQL
      @db.exec(command)
    end

    def drop_table
      command = <<-SQL
        DROP TABLE IF EXISTS albums CASCADE;
      SQL
      @db.exec(command)
    end

    def create(params)
      title = params[:title] 
      year = params[:year]
      genre = params[:genre]
      image_link = params[:image_link]
      command = <<-SQL
        INSERT INTO albums(title, year, genre, image_link)
        VALUES ($1,$2,$3,$4)
        RETURNING *;
      SQL
      result = @db.exec(command, [title, year, genre, image_link])
      build_album(result.first)
    end

    def build_album(params)
      id = params['id']
      title = params['title']
      year = params['year'].to_i
      genre = params['genre']
      image_link = params['image_link']

      Songify::Album.new({
        id: id,
        title: title, 
        year: year, 
        genre: genre, 
        image_link: image_link
      })
    end

    def find_by(params)
      title = params[:title]
      command = <<-SQL
        SELECT * FROM albums WHERE title=$1;
      SQL
      result = @db.exec(command, [title])
      result.map { |a| build_album(a) }
    end

    def find(id)
      command = <<-SQL
        SELECT * FROM albums WHERE id=$1;
      SQL
      result = @db.exec(command, [id])
      build_album(result.first)
    end

    def update(params)
      id = params[:id] 
      image_link = params[:image_link]
      command = <<-SQL
        UPDATE albums
        SET image_link=$2
        WHERE albums.id=$1
        RETURNING *;
      SQL
      result = @db.exec(command, [id, image_link])
      build_album(result.first)

    end

  end
end
