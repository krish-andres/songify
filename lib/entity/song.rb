class Songify::Song
  attr_reader :name, :album, :id
  attr_accessor :youtube_link

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @album = params[:album]
    @youtube_link = params[:youtube_link] || "N/A"
  end
end
