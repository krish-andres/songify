require 'pg'

module Songify
  class Repo
    def initialize
      @db = PG.connect(dbname: 'songify-db')
    end
  end
end