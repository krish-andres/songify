class Songify::Playlist
  attr_reader :name, :id
  attr_accessor :description

  def initialize(params)
    @id = params[:id]
    @name = params[:name]
    @description = params[:description]
  end

end
