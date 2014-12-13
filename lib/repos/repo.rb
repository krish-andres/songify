require 'pg'

module Songify
  class Repo
    def initialize
      @db = Songify.db
    end
  end
end
