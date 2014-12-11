class Songify::Album
  attr_reader :title, :year, :genre, :id
  attr_accessor :image_link
  
  def initialize(params)
    @id = params[:id]
    @title = params[:title]
    @year = params[:year] || "N/A"
    @genre = params[:genre] || "N/A"
    @image_link = params[:image_link] || "N/A"
  end
end
